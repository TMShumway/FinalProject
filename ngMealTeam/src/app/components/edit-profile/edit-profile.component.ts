import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-edit-profile',
  templateUrl: './edit-profile.component.html',
  styleUrls: ['./edit-profile.component.css']
})
export class EditProfileComponent implements OnInit {


  editUser = new User();

  constructor(private auth: AuthService,
    private router: Router) { }

  ngOnInit(): void {
  }

  update(){
    // this.auth.register(this.editUser).subscribe(
    //   (user) => {
    //     this.auth.login(this.editUser.username, this.editUser.password).subscribe(
    //       loggedInUser => {
    //         console.log('RegisterComponent.register(): user logged in.');
    //         this.router.navigateByUrl('/home');
    //       },
    //       (noJoy) => {
    //         console.log('RegisterComponent.register(): login failed.');
    //         console.log(noJoy);
    //         this.router.navigateByUrl('/registration');
    //       }
    //       );
    //     },
    //     (fail) => {
    //     console.log('RegisterComponent.register(): login failed.');
    //     console.log(fail);
    //     this.router.navigateByUrl('/home');

    //   }
    // )
  }
}
