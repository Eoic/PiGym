import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewChallengeComponent } from './new-challenge.component';

describe('NewChallengeComponent', () => {
  let component: NewChallengeComponent;
  let fixture: ComponentFixture<NewChallengeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewChallengeComponent],
    })
      .compileComponents();

    fixture = TestBed.createComponent(NewChallengeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
