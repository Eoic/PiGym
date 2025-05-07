import { CommonModule } from '@angular/common';
import { Component, ElementRef, QueryList, AfterViewInit, HostListener, ViewChild, ChangeDetectorRef, AfterViewChecked, ViewChildren } from '@angular/core';
import { PiService } from '../../pi.service';

interface Digit {
  index: number;
  symbol: string;
  answer: string;
  status: 'default' | 'wrong' | 'correct' | 'active';
}

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

  constructor(private cdRef: ChangeDetectorRef, private piService: PiService) {}

  readonly FETCH_CHUNK_SIZE = 20;

  globalPosition = 0;
  activePosition = 0;
  window: Digit[] = [];

  ngOnInit() {
    this.piService.getDigits(1, this.FETCH_CHUNK_SIZE).subscribe({
      next: digits => {
        this.window = digits.split('').map((digit, index) => ({
          symbol: digit,
          answer: digit,
          status: 'default',
          index: this.globalPosition + index,
        }));
      },
      error: err => {
        console.error('Failed to fetch Pi digits', err);
      },
    });
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

    this.cellsContainer.nativeElement.style.transform = `translateX(${delta}px)`;
  }

  @HostListener('window:keyup', ['$event'])
  handleKeyUpEvent(event: KeyboardEvent) {
    if (event.key.length !== 1 || !event.key.match(/[0-9]/))
      return;

    this.nextDigit(event.key);
  }

  private nextDigit(guess: string) {
    const poppedDigit = this.window[this.globalPosition];

    if (!poppedDigit)
      return;

    if (guess !== poppedDigit.answer)
      poppedDigit.status = 'wrong';
    else poppedDigit.status = 'correct';

    // this.cells.get(this.globalPosition)?.nativeElement);

    this.globalPosition++;
    // console.log(this.belt.nativeElement.querySelector('.active'));
    // this.window.unshift(this.globalIndex - this.BUFFER_CENTER);

    // const shift = this.getCellWidth();
    // this.belt.nativeElement.style.left = `${-shift * this.position}px`;

    // this.belt.nativeElement.scrollTo({
    //   left: this.belt.nativeElement.scrollLeft + shift,
    //   behavior: 'smooth',
    // });
  }

  private getCellWidth(): number {
    // this.cells.
    // const cell = this.cell?.nativeElement;

    // if (!cell)
    //   return 0;

    // const style = getComputedStyle(cell);
    // const width = cell.offsetWidth;
    // const margin = parseFloat(style.marginLeft || '0') + parseFloat(style.marginRight || '0');

    // return width + margin;
    return 200;
  }
}
