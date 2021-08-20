import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  newUser = new User();

  constructor(
    private auth: AuthService,
    private router: Router
    ) { }

  ngOnInit(): void {
  }

  register(): void{
    console.log(this.newUser);
    this.auth.register(this.newUser).subscribe(
          (user) => {
            console.log('RegisterComponent.register(): user registered.');
            this.auth.login(this.newUser.username, this.newUser.password).subscribe(
              loggedInUser => {
                console.log('RegisterComponent.register(): user logged in.');
                this.router.navigateByUrl('/home');
              },
              (noJoy) => {
                console.log('RegisterComponent.register(): login failed.');
                console.log(noJoy);
                this.router.navigateByUrl('/registration');
              }
              );
            },
            (fail) => {
            console.log('RegisterComponent.register(): login failed.');
            console.log(fail);
            this.router.navigateByUrl('/registration');

          }
        )

  }


}
