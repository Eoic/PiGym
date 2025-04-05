import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewPracticeComponent } from './new-practice.component';

describe('NewPracticeComponent', () => {
  let component: NewPracticeComponent;
  let fixture: ComponentFixture<NewPracticeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewPracticeComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(NewPracticeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
