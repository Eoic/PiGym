import { Component, ElementRef, AfterViewInit, HostListener, ViewChild, ChangeDetectorRef } from '@angular/core';

@Component({
  selector: 'app-digit-belt',
  imports: [],
  templateUrl: './digit-belt.component.html',
  styleUrl: './digit-belt.component.scss',
})
export class DigitBeltComponent implements AfterViewInit {
  @ViewChild('belt', { static: true, }) belt!: ElementRef<HTMLDivElement>;
  @ViewChild('cellRef', { static: false, }) cellRef!: ElementRef<HTMLElement>;

  constructor(private cdRef: ChangeDetectorRef) {}

  readonly VISIBLE_CELLS = 5;
  readonly BUFFER_CENTER = Math.floor(this.VISIBLE_CELLS / 2);

  window: number[] = [];

  globalIndex = 0;

  ngAfterViewInit() {
    // for (let i = -this.BUFFER_CENTER; i <= this.BUFFER_CENTER; i++) 
    //   this.window.push(this.globalIndex + 1);
   
    // console.log('Initialized...');
    // this.belt.nativeElement.scrollLeft = this.BUFFER_CENTER * this.CELL_WIDTH;

    for (let i = -this.BUFFER_CENTER; i <= this.BUFFER_CENTER; i++) 
      this.window.push(this.globalIndex + i);
  

    // trigger manual check so Angular is in sync
    this.cdRef.detectChanges();

    // optionally measure and scroll after a tick
    setTimeout(() => {
      const offset = this.getCellWidth() * this.BUFFER_CENTER;
      this.belt.nativeElement.scrollLeft = offset;
    });
  }

  @HostListener('window:keydown', ['$event'])
  handleKeyboardEvent(event: KeyboardEvent) {
    if (event.key === 'Enter')
      this.shiftLeft();
    else if (event.key.length === 1 && event.key.match(/[0-9]/)) 
      console.log(`Digit ${event.key} pressed`);
  }

  private shiftLeft() {
    this.window.pop();
    this.globalIndex--;
    this.window.unshift(this.globalIndex - this.BUFFER_CENTER);

    const shift = this.getCellWidth();
    this.belt.nativeElement.scrollLeft += shift;
    this.belt.nativeElement.scrollTo({
      left: this.belt.nativeElement.scrollLeft + shift,
      behavior: 'smooth',
    });
  }

  private getCellWidth(): number {
    const cell = this.cellRef?.nativeElement;

    if (!cell)
      return 0;

    const style = getComputedStyle(cell);
    const width = cell.offsetWidth;
    const margin = parseFloat(style.marginLeft || '0') + parseFloat(style.marginRight || '0');

    return width + margin;
  }
}
