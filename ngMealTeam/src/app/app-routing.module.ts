import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { RegistrationComponent } from './components/registration/registration.component';
import { SplashpageComponent } from './components/splashpage/splashpage.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'welcome'},
  { path: 'home', component: HomeComponent },
  { path: 'login', component: LoginComponent},
  { path: 'welcome', component: SplashpageComponent},
  { path: 'register', component: RegistrationComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes,{useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
