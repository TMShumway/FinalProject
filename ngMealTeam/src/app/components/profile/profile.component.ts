import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { Recipe } from 'src/app/models/recipe';
import { User } from 'src/app/models/user';
import { PostService } from 'src/app/services/post.service';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
export class ProfileComponent implements OnInit {

  posts: Post[] = [];
  recipes: Recipe[] = [];
  postIsVisible: Boolean = true;
  editProfileIsVisible: Boolean = false;
  recipeIsVisible: Boolean = false;
  selected: Recipe | null = null;
  descriptionStatusTF: boolean[] = [];
  recipeStatusTF: boolean[] = [];
  commentStatusTF: boolean[] = [];
  // ratingStatusTF: boolean[] = [];
  postStatusTF: boolean[] = [];
  editUser = new User();


  constructor(private postService: PostService, private userService: UserService, private recipeService: RecipeService) { }


  ngOnInit(): void {
    this.loadUserPosts();
    this.loadUserRecipes();
    this.loadUser();
  }

  loadAllPosts() {
    this.postService.index().subscribe(
      data => { this.posts = data.reverse();},

      error => { console.error('Error retrieving posts from postService: ' + error);}
    );
  }

  loadUserPosts() {
    this.userService.indexPostsByUsername().subscribe(
      data => { this.posts = data;
      },

      error => { console.error('Error retrieving posts from userService: ' + error);}
    );
  }

  loadUserRecipes() {
    this.recipeService.indexByUsername().subscribe(
      data => { this.recipes = data;
        this.initializeArrays();
      },

      error => { console.error('Error retrieving user recipes from recipeService: ' + error);}
    );
  }

  loadUser() {
    this.userService.getUserByUsername().subscribe(
      data => { this.editUser = data;
        this.initializeArrays();
      },

      error => { console.error('Error retrieving user from userService: ' + error);}
    );
  }
  postHasImage(i: number) {
    if(this.posts[i].imageUrl === null){
      return false;
    } else {
      return true;
    }
  }

  showPostDiv() {
    this.recipeIsVisible = false;
    this.postIsVisible = true;
    this.editProfileIsVisible = false;

    this.loadUserPosts();
    return this.postIsVisible;
  }

  showEditProfileDiv() {
    this.editProfileIsVisible = true;
    this.postIsVisible = false;
    this.recipeIsVisible = false;

    // this.loadUserPosts();
    return this.editProfileIsVisible;
  }

  updateUser(user: User) {
    this.userService.updateUser(user).subscribe(
      data => {  },

      error => { console.error('Error retrieving user from userService: ' + error);}
    );
  }

//   this.todoService.update(todo).subscribe(
//     data => {
//       this.reload();
//     },
//     error => {
//       console.log(error);
//       console.log("error updating todo through service")
//     }
//   );
//   this.editTodo = null;
//   this.selected = null;
//   // this.todos = this.todoService.index();
// }

  showRecipeDiv() {
    this.postIsVisible = false;
    this.editProfileIsVisible = false;
    this.recipeIsVisible = true;
    this.loadUserRecipes();
    return this.recipeIsVisible;
  }

  getRatingAverage(i: number){
    let average = 0;
    for (let index = 0; index < this.recipes[i].ratings.length; index++) {
      average += this.recipes[i].ratings[index].starRating;
    }
    return average /= this.recipes[i].ratings.length;
  }

  checkNaN(n: number){
    return Number.isNaN(n);
  }

  initializeArrays() {
    for (let i = 0; i < this.recipes.length; i++) {
      this.descriptionStatusTF.push(true);
      this.recipeStatusTF.push(false);
      this.commentStatusTF.push(false);
      // this.ratingStatusTF.push(false);
      this.postStatusTF.push(false);
    }
  }


  descriptionStatus(index : number){
    this.descriptionStatusTF[index] = true;
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = false;
    // this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = false;
  }
  recipeStatus(index : number){
    this.descriptionStatusTF[index] = false;
    this.recipeStatusTF[index] = true;
    this.commentStatusTF[index] = false;
    // this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = false;
  }
  commentStatus(index : number){
    this.descriptionStatusTF[index] = false;
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = true;
    // this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = false;
  }
  ratingStatus(index : number){
    this.descriptionStatusTF[index] = false;
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = false;
    // this.ratingStatusTF[index] = true;
    this.postStatusTF[index] = false;
  }
  postStatus(index : number){
    this.descriptionStatusTF[index] = false;
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = false;
    // this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = true;
  }
}
