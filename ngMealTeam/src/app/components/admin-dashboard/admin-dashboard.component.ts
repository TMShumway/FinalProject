import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { AdminService } from 'src/app/services/admin.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-admin-dashboard',
  templateUrl: './admin-dashboard.component.html',
  styleUrls: ['./admin-dashboard.component.css']
})
export class AdminDashboardComponent implements OnInit {

  loggedInUser: User = new User();
  allUsers: User[] = [];
  allRecipes: User[] = [];
  allPosts: User[] = [];
  userStatusTF: boolean = true;
  recipeStatusTF: boolean = false;
  postStatusTF: boolean = false;


  constructor(private userService: UserService, private adminService: AdminService) { }

  ngOnInit(): void {
    this.loadUser();
    this.loadAllUsers();
  }

  loadUser() {
    this.userService.getUserByUsername().subscribe(
      data => { this.loggedInUser = data;
        // this.initializeArrays();
      },
      error => { console.error('Error retrieving user from userService: ' + error);}
      );
  }

  loadAllUsers() {
    this.adminService.indexUsers().subscribe(
      data => { this.allUsers = data;
        // this.initializeArrays();
      },
      error => { console.error('Error retrieving user from adminService: ' + error);}
      );
  }

  // loadAllRecipes() {
  //   this.adminService.indexRecipes().subscribe(
  //     data => { this.allUsers = data;
  //       // this.initializeArrays();
  //     },
  //     error => { console.error('Error retrieving user from adminService: ' + error);}
  //     );
  // }
  // loadAllPosts() {
  //   this.adminService.indexPosts().subscribe(
  //     data => { this.allUsers = data;
  //       // this.initializeArrays();
  //     },
  //     error => { console.error('Error retrieving user from adminService: ' + error);}
  //     );
  // }

  disableUser(userId: number){
    this.adminService.disableUser(userId).subscribe(
      data => { this.loadAllUsers();
        // this.initializeArrays();
      },
      error => { console.error('Error retrieving user from adminService: ' + error);}
      );
  }


  userStatus(){
    this.userStatusTF = true;
    this.recipeStatusTF = false;
    this.postStatusTF = false;
  }

  recipeStatus(){
    this.userStatusTF = false;
    this.recipeStatusTF = true;
    this.postStatusTF = false;
  }

  postStatus(){
    this.userStatusTF = false;
    this.recipeStatusTF = false;
    this.postStatusTF = true;
  }

}
