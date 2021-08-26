import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { Recipe } from 'src/app/models/recipe';
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
  allRecipes: Recipe[] = [];
  allPosts: Post[] = [];
  userStatusTF: boolean = true;
  recipeStatusTF: boolean = false;
  postStatusTF: boolean = false;


  constructor(private userService: UserService, private adminService: AdminService) { }

  ngOnInit(): void {
    this.loadUser();
    this.loadAllUsers();
    this.loadAllRecipes();
    this.loadAllPosts();
  }

  loadUser() {
    this.userService.getUserByUsername().subscribe(
      data => { this.loggedInUser = data;
      },
      error => { console.error('Error retrieving user from userService: ' + error);}
      );
  }

  loadAllUsers() {
    this.adminService.indexUsers().subscribe(
      data => { this.allUsers = data;
      },
      error => { console.error('Error retrieving user from adminService: ' + error);}
      );
  }

  loadAllRecipes() {
    this.adminService.indexRecipes().subscribe(
      data => { this.allRecipes = data;
      },
      error => { console.error('Error retrieving user from adminService: ' + error);}
      );
  }
  loadAllPosts() {
    this.adminService.indexPosts().subscribe(
      data => { this.allPosts = data;
      },
      error => { console.error('Error retrieving user from adminService: ' + error);}
      );
  }

  disableUser(userId: number, i: number){
    this.adminService.disableUser(userId).subscribe(
      data => {
        this.allUsers[i] = data;
      },
      error => { console.error('Error retrieving user from adminService: ' + error);}
      );
  }
  disableRecipe(recipeId: number, i: number){
    this.adminService.disableRecipe(recipeId).subscribe(
      data => {
        this.allRecipes[i] = data;
      },
      error => { console.error('Error retrieving recipe from adminService: ' + error);}
      );
  }
  disablePost(postId: number, i: number){
    this.adminService.disablePost(postId).subscribe(
      data => {
        this.allPosts[i] = data;
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
