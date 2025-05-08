import { CommonModule } from '@angular/common';
import { Component, ElementRef, QueryList, AfterViewInit, HostListener, ViewChild, ChangeDetectorRef, AfterViewChecked, ViewChildren } from '@angular/core';
import { PiService } from '../../pi.service';
import { InputService } from '../../input.service';

interface Digit {
  index: number;
  symbol: string;
  answer: string;
  isDirty: boolean;
  status: 'default' | 'wrong' | 'correct' | 'active';
}

// TODO:
// - Create a buffer of indexed cells and maintain that list instead of tying 
//   it to the fetched digits.
// - Make digit belt flex-end, so that removing old digits wouldn't cause
//   reflow.

@Component({
  selector: 'app-digit-belt',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './digit-belt.component.html',
  styleUrl: './digit-belt.component.scss',
})
export class DigitBeltComponent implements AfterViewInit, AfterViewChecked {
  @ViewChild('cellsContainer', { static: true, }) cellsContainer!: ElementRef<HTMLDivElement>;
  @ViewChildren('cells') cells!: QueryList<ElementRef<HTMLElement>>;

  constructor(private cdRef: ChangeDetectorRef, private piService: PiService, private inputService: InputService) {}

  readonly DIGIT_LAG = 1;
  readonly FETCH_CHUNK_SIZE = 2;

  localPosition = 0;
  globalPosition = 0;
  window: Digit[] = [];
  history: Digit[] = [];

  loadNewDigits(startDigitIndex: number, callback: () => void = () => {}) {
    this.piService.getDigits(startDigitIndex, this.FETCH_CHUNK_SIZE).subscribe({
      next: digits => {
        const newDigits = digits.split('').map((digit, index): Digit => ({
          symbol: digit,
          answer: digit,
          status: 'default',
          isDirty: false,
          index: this.globalPosition + index,
        }));

        this.window.push(...newDigits);
        this.cdRef.markForCheck();
        callback();
      },
      error: err => {
        console.error('Failed to fetch Pi digits', err);
      },
    });
  }

  ngOnInit() {
    this.loadNewDigits(1);
  }

  ngAfterViewInit() {
    // for (let i = -this.BUFFER_CENTER; i <= this.BUFFER_CENTER; i++) 
    //   this.window.push(this.globalIndex + i);
  
    // this.cdRef.detectChanges();

    // setTimeout(() => {
    // const offset = this.getCellWidth() * this.BUFFER_CENTER;
    // this.belt.nativeElement.scrollLeft = offset;
    // });
  }

  ngAfterViewChecked(): void {
    this.centerActiveCell();
  }

  centerActiveCell(skipTransition: boolean = false) {
    const activeElement = this.cells.get(this.globalPosition)?.nativeElement;

    if (!activeElement || !this.cellsContainer)
      return;

    const box = activeElement.getBoundingClientRect();
    const parentBox = this.cellsContainer.nativeElement.getBoundingClientRect();
    const relOffset = this.cellsContainer.nativeElement.parentElement!.offsetLeft;
    const parentCenter = (parentBox.x - relOffset) + parentBox.width / 2;
    const activeCenter = (box.x - relOffset) + box.width / 2;
    const delta = parentCenter - activeCenter;

    if (delta > 0)
      return;
   
    if (skipTransition)
      this.cellsContainer.nativeElement.style.transition = 'none';

    this.cellsContainer.nativeElement.style.transform = `translateX(${delta}px)`;

    if (skipTransition)
      requestAnimationFrame(() => {
        this.cellsContainer.nativeElement.style.transition = 'transform 0.2s ease-in-out';
      });
  }

  @HostListener('window:keydown', ['$event'])
  handleKeyDownEvent(event: KeyboardEvent) {
    if (event.key.length !== 1 || !event.key.match(/[0-9]/))
      return;

    this.inputService.set(event.key, true);
  }

  @HostListener('window:keyup', ['$event'])
  handleKeyUpEvent(event: KeyboardEvent) {
    if (event.key.length !== 1 || !event.key.match(/[0-9]/))
      return;

    this.inputService.set(event.key, false);

    if (this.inputService.isMultipleNumberKeysPressed())
      return;

    this.nextDigit(event.key);
  }

  @HostListener('window:resize', ['$event'])
  handleResizeEvent(_event: Event) {
    this.centerActiveCell(true);
  }

  private nextDigit(guess: string) {
    const poppedDigit = this.window[this.globalPosition];

    if (!poppedDigit)
      return;

    if (guess !== poppedDigit.answer)
      poppedDigit.status = 'wrong';
    else poppedDigit.status = 'correct';

    this.globalPosition++;
    this.history.push(poppedDigit);

    if (this.globalPosition - 1 >= this.window[this.window.length - 1].index)
      this.loadNewDigits(this.globalPosition + 1);
  }
}
