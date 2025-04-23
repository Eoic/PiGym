import { Component, inject } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators, AbstractControl } from '@angular/forms';
import { ButtonComponent } from '../../button/button.component';
import { FormComponent } from '../form/form.component';

@Component({
  selector: 'app-new-challenge',
  imports: [ReactiveFormsModule, ButtonComponent],
  templateUrl: './new-challenge.component.html',
  styleUrl: './new-challenge.component.scss',
})
export class NewChallengeComponent extends FormComponent {
  private formBuilder = inject(FormBuilder);

  challengeForm = this.formBuilder.group({
    // (control: AbstractControl) => Validators.minLength(3)(control)
    hintsAllowed: [''],
    startingDigit: [''],
    mistakesAllowed: [''],
    digitsToGuess: [''],
    timeLimit: [''],
    timePerDigit: [''],
  });

  onSubmit() {
    console.log('Submitted:', this.challengeForm.value);
  }
}
