import { CommonModule } from '@angular/common';
import { Component, ElementRef, AfterViewInit, HostListener, ViewChild, ChangeDetectorRef } from '@angular/core';
import { PiService } from '../../pi.service';

interface Digit {
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
export class DigitBeltComponent implements AfterViewInit {
  @ViewChild('belt', { static: true, }) belt!: ElementRef<HTMLDivElement>;
  @ViewChild('cell', { static: false, }) cell!: ElementRef<HTMLElement>;

  constructor(private cdRef: ChangeDetectorRef, private piService: PiService) {}

  readonly FETCH_CHUNK_SIZE = 20;

  position = 0;
  window: Digit[] = [];

  ngOnInit() {
    this.piService.getDigits(1, this.FETCH_CHUNK_SIZE).subscribe({
      next: digits => {
        this.window = digits.split('').map((digit, index) => ({
          symbol: digit,
          answer: digit,
          status: 'default',
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
  
    this.cdRef.detectChanges();

    // setTimeout(() => {
    // const offset = this.getCellWidth() * this.BUFFER_CENTER;
    // this.belt.nativeElement.scrollLeft = offset;
    // });
  }

  @HostListener('window:keyup', ['$event'])
  handleKeyUpEvent(event: KeyboardEvent) {
    if (event.key.length !== 1 || !event.key.match(/[0-9]/))
      return;

    this.nextDigit(event.key);
  }

  private nextDigit(guess: string) {
    const poppedDigit = this.window[this.position];

    if (!poppedDigit)
      return;

    if (guess !== poppedDigit.answer)
      poppedDigit.status = 'wrong';
    else poppedDigit.status = 'correct';

    this.position++;
    // this.window.unshift(this.globalIndex - this.BUFFER_CENTER);

    const shift = this.getCellWidth();
    console.log(this.belt.nativeElement);
    this.belt.nativeElement.style.left = `${-shift * this.position}px`;
    // this.belt.nativeElement.scrollTo({
    //   left: this.belt.nativeElement.scrollLeft + shift,
    //   behavior: 'smooth',
    // });
  }

  private getCellWidth(): number {
    const cell = this.cell?.nativeElement;

    if (!cell)
      return 0;

    const style = getComputedStyle(cell);
    const width = cell.offsetWidth;
    const margin = parseFloat(style.marginLeft || '0') + parseFloat(style.marginRight || '0');

    return width + margin;
  }
}
