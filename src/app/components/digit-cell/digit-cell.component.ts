import { Input, ViewEncapsulation } from '@angular/core';
import { Component } from '@angular/core';

@Component({
  selector: 'app-digit-cell',
  imports: [],
  templateUrl: './digit-cell.component.html',
  styleUrl: './digit-cell.component.scss',
  encapsulation: ViewEncapsulation.Emulated,
  // encapsulation: ViewEncapsulation.None,
})
export class DigitCellComponent {
  @Input() digit: string = '?';
  @Input() status: 'default' | 'wrong' | 'correct' | 'active' = 'default';
}
