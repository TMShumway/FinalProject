import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-splashpage',
  templateUrl: './splashpage.component.html',
  styleUrls: ['./splashpage.component.css']
})
export class SplashpageComponent implements OnInit {

  constructor(private auth: AuthService) { }

  ngOnInit(): void {
  }


  loggedIn(): boolean{
    return this.auth.checkLogin();
  }
}
