import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-admin-dashboard',
  templateUrl: './admin-dashboard.component.html',
  styleUrls: ['./admin-dashboard.component.css']
})
export class AdminDashboardComponent implements OnInit {

  allUsers: User[] = [];

  constructor(private userService: UserService) { }

  ngOnInit(): void {
  }


loadAllUsers() {
  // this.userService.().subscribe(
  //   data => { this.loggedInUser = data;
  //     // this.initializeArrays();
  //   },

  //   error => { console.error('Error retrieving user from userService: ' + error);}
  //   );
  }


}
