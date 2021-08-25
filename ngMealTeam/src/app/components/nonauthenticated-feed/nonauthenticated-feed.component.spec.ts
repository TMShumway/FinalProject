import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NonauthenticatedFeedComponent } from './nonauthenticated-feed.component';

describe('NonauthenticatedFeedComponent', () => {
  let component: NonauthenticatedFeedComponent;
  let fixture: ComponentFixture<NonauthenticatedFeedComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NonauthenticatedFeedComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NonauthenticatedFeedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
