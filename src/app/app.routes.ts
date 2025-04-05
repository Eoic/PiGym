import { Routes } from '@angular/router';
import { ChallengeComponent } from './challenge/challenge.component';
import { PracticeComponent } from './practice/practice.component';
import { ScoresComponent } from './scores/scores.component';
import { StatisticsComponent } from './statistics/statistics.component';
import { SettingsComponent } from './settings/settings.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';

export const routes: Routes = [
  {
    path: 'challenge',
    component: ChallengeComponent,
  },
  {
    path: 'practice',
    component: PracticeComponent,
  },
  {
    path: 'scores',
    component: ScoresComponent,
  },
  {
    path: 'statistics',
    component: StatisticsComponent,
  },
  {
    path: 'settings',
    component: SettingsComponent,
  },
  {
    path: '',
    redirectTo: '/challenge',
    pathMatch: 'full',
  },
  {
    path: '**',
    component: PageNotFoundComponent,
  }
];
