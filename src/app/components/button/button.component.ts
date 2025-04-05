import { Component, EventEmitter, Input, Output } from '@angular/core';

@Component({
  selector: 'app-button',
  imports: [],
  templateUrl: './button.component.html',
  styleUrl: './button.component.scss',
})
export class ButtonComponent {
  @Input() type: string = 'button';
  @Input() isLoadin: boolean = false;
  @Input() isDisabled: boolean = false;
  @Input() loadingText: string = 'Loading...';
  @Input() variant: 'primary' | 'success' | 'alert' | 'danger' = 'primary';

  @Output() click = new EventEmitter<MouseEvent>();

  onClick(_event: MouseEvent) {
    console.log('Button clicked!');
  }
}
