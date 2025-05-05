import { ComponentFixture, TestBed } from '@angular/core/testing';
import { DigitBeltComponent } from './digit-belt.component';

describe('DigitBeltComponent', () => {
  let component: DigitBeltComponent;
  let fixture: ComponentFixture<DigitBeltComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DigitBeltComponent],
    })
      .compileComponents();

    fixture = TestBed.createComponent(DigitBeltComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
