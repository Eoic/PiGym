import { Routes } from '@angular/router';
import { ChallengeComponent } from './pages/challenge/challenge.component';
import { PracticeComponent } from './pages/practice/practice.component';
import { ScoresComponent } from './pages/scores/scores.component';
import { StatisticsComponent } from './pages/statistics/statistics.component';
import { SettingsComponent } from './pages/settings/settings.component';
import { PageNotFoundComponent } from './pages/page-not-found/page-not-found.component';

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
