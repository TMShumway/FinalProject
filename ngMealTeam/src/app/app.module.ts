import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { HomeComponent } from './components/home/home.component';
import { SplashpageComponent } from './components/splashpage/splashpage.component';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthService } from './services/auth.service';
import { RegistrationComponent } from './components/registration/registration.component';
import { NavigationComponent } from './components/navigation/navigation.component';
import { ProfileComponent } from './components/profile/profile.component';
import { AboutComponent } from './components/about/about.component';
import { ContactComponent } from './components/contact/contact.component';
import { UserRecipesComponent } from './components/user-recipes/user-recipes.component';
import { RecipeFormModalComponent } from './components/recipe-form-modal/recipe-form-modal.component';
import { PostFormComponent } from './components/post-form/post-form.component';
import { EditProfileComponent } from './components/edit-profile/edit-profile.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NonauthenticatedFeedComponent } from './components/nonauthenticated-feed/nonauthenticated-feed.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    LogoutComponent,
    HomeComponent,
    SplashpageComponent,
    NavigationComponent,
    RegistrationComponent,
    ProfileComponent,
    AboutComponent,
    ContactComponent,
    UserRecipesComponent,
    RecipeFormModalComponent,
    PostFormComponent,
    EditProfileComponent,
    NonauthenticatedFeedComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    CommonModule,
    NgbModule
  ],
  providers: [
    AuthService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
