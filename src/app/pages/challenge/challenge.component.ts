import { Component } from '@angular/core';
import { ButtonComponent } from '../../components/button/button.component';
import { NewChallengeComponent } from '../../components/forms/new-challenge/new-challenge.component';

@Component({
  selector: 'app-challenge',
  imports: [ButtonComponent, NewChallengeComponent],
  templateUrl: './challenge.component.html',
  styleUrl: './challenge.component.scss',
})
export class ChallengeComponent {

}
