import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { PostComment } from 'src/app/models/post-comment';
import { Recipe } from 'src/app/models/recipe';
import { RecipeComments } from 'src/app/models/recipe-comments';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { PostService } from 'src/app/services/post.service';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
})
export class ProfileComponent implements OnInit {

  newPostComment: PostComment = new PostComment();
  newComment: RecipeComments = new RecipeComments();
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
  makeAPostIsVisible: Boolean = true;
  newPost = new Post();
  user: User = new User();


  constructor(private postService: PostService, private userService: UserService, private recipeService: RecipeService, private authService: AuthService) { }


  ngOnInit(): void {
    this.loadUser();
    this.loadUserPosts();
    this.loadUserRecipes();
  }

  // loadAllPosts() {
  //   this.postService.index().subscribe(
  //     data => { this.posts = data.reverse();},

  //     error => { console.error('Error retrieving posts from postService: ' + error);}
  //   );
  // }

  loadUserPosts() {
    this.postService.indexByUsernamePublishedTrue(this.user.username).subscribe(
      data => { this.posts = data.reverse();

      },

      error => { console.error('Error retrieving posts from postService: ' + error);}
    );
  }

  createNewPost(){
    this.newPost.user = this.user;
  this.postService.createPost(this.newPost).subscribe(

      data => { this.loadUserPosts();
                },

      err => { console.error('Observer error in homeComponent createNewPost(): ' + err) }
    );
    this.newPost = new Post();
  }

  deletFromMyPostList(post: Post){
    // this.loadUser();
    console.log(this.user?.username);
    if (this.user?.username == post.user.username){
      post.published = false;
      this.postService.destroyPost(post).subscribe(
        data => { this.loadUserPosts();  },
        err => { console.error('Observer error: ' + err) }
        );
      }
    }

  // createNewRecipe(){
  //   this.recipeService.create(this.newRecipe, this.rImageUrl).subscribe(
  //     data => { this.loadAllRecipes();
  //               this.createRecipeForm(); },

  //     err => { console.error('Observer error in homeComponent createNewRecipe(): ' + err) }
  //   );
  //   this.newRecipe = new Recipe();
  // }

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
        console.log("The password value is: " + data.password);
        this.editUser.password = '';
        this.initializeArrays();
        this.user = data;
      },

      error => { console.error('Error retrieving user from userService: ' + error);}
    );
  }
  postHasImage(i: number) {
    if(this.posts[i].imageUrl === null || this.posts[i].imageUrl === ''){
      return false;
    } else {
      return true;
    }
  }

  showPostDiv() {
    this.recipeIsVisible = false;
    this.postIsVisible = true;
    this.editProfileIsVisible = false;
    this.makeAPostIsVisible = true;
    this.loadUserPosts();
    return this.postIsVisible;
  }

  showMakePostDiv() {
    this.makeAPostIsVisible = true;
    // this.postIsVisible = true;
    this.editProfileIsVisible = false;
    this.postIsVisible = true;
    this.recipeIsVisible = true;

    // this.loadUserPosts();
    return this.makeAPostIsVisible;
  }

  showEditProfileDiv() {
    this.editProfileIsVisible = true;
    this.postIsVisible = false;
    this.recipeIsVisible = false;
    this.makeAPostIsVisible = false;

    // this.loadUserPosts();
    return this.editProfileIsVisible;
  }

  updateUser(user: User) {
    console.log('Entering updateUser from ProfileComponent, Username: ' + user.username + ' Password: ' + user.password);
    this.userService.updateUser(user).subscribe(
      data => {
      this.authService.logout();
      console.log('Username being passed to login function: ' + user.username + ' Password: ' + user.password);
      this.authService.login(user.username, user.password).subscribe(
       loggedIn => {
         console.log('Logged in')
       },
       failed => {
         console.error('Error logging back in.')
       }
      );
       },

      error => { console.error('Error retrieving user from userService: ' + error);}
    );
  }

  // addNewPostComment(p: Post, i: number){
  //   this.postService.addComment(p.id, this.newPostComment).subscribe(
  //     data => {
  //       this.newPostComment = new PostComment();
  //       this.posts[i] = data;
  //       // this.loadAllRecipes();
  //     },
  //     err => {
  //       console.error('Observer error in profileComponent addNewPostComment(): ' + err)
  //     }
  //   );
  // }

  // reload() {
  //   this.todoService.index().subscribe(
  //     data => {
  //       this.todos = data;
  //     },
  //     err => {
  //       console.log("Error retreiving todos from service")
  //     }
  //   );
  // }

  showRecipeDiv() {
    this.postIsVisible = false;
    this.editProfileIsVisible = false;
    this.recipeIsVisible = true;
    this.makeAPostIsVisible = true;

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

  addNewComment(r: Recipe, i: number){
    this.recipeService.addComment(r.id, this.newComment).subscribe(
      data => {
        this.newComment = new RecipeComments();
        this.recipes[i] = data;
        // this.loadAllRecipes();
      },
      err => {
        console.error('Observer error in homeComponent AddNewComment(): ' + err)
      }
    );
  }
}
