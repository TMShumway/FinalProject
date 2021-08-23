import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { RegistrationComponent } from './components/registration/registration.component';
import { SplashpageComponent } from './components/splashpage/splashpage.component';
import { ProfileComponent } from './components/profile/profile.component';
import { AboutComponent } from './components/about/about.component';
import { UserRecipesComponent } from './components/user-recipes/user-recipes.component';
import { ContactComponent } from './components/contact/contact.component';
import { EditProfileComponent } from './components/edit-profile/edit-profile.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'welcome'},
  { path: 'home', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: 'contact', component: ContactComponent },
  { path: 'userRecipes', component: UserRecipesComponent },
  { path: 'login', component: LoginComponent},
  { path: 'welcome', component: SplashpageComponent},
  { path: 'register', component: RegistrationComponent},
  { path: 'profile', component: ProfileComponent},
  { path: 'update', component: EditProfileComponent}

];

@NgModule({
  imports: [RouterModule.forRoot(routes,{useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
