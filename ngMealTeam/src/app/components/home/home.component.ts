import { Component, OnInit } from '@angular/core';
import { Recipe } from 'src/app/models/recipe';
import { RecipeComments } from 'src/app/models/recipe-comments';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  newComment: RecipeComments = new RecipeComments();
  recipes: Recipe[] = [];
  newRecipe: Recipe = new Recipe();
  editRecipe: Recipe[] = [];
  rImageUrl: string = '';
  userRating: number[] = [];
  averageRating: number[] = [];
  searchTitle: string = '';
  searchDescription: string = '';

  // recipeImages:
  // Posts
  // Comments
  loggedInUser: User = new User();
  selected: Recipe | null = null;
  descriptionStatusTF: boolean[] = [];
  recipeStatusTF: boolean[] = [];
  commentStatusTF: boolean[] = [];
  editRecipeTF: boolean[] = [];
  postStatusTF: boolean[] = [];
  createRecipeTF: boolean = false;

  constructor(private recipeService: RecipeService, private userService: UserService) { }



  ngOnInit(): void {
    this.loadUser();
    this.loadAllRecipes();
  }

  selectTab(recipeId: number){

  }


  loadAllRecipes() {
    this.recipeService.index().subscribe(
      data => {

        this.recipes = data.reverse();
        this.initializeArrays();

      },

      error => { console.error('Error retrieving recipes from recipeService: ' + error);}
    );
  }

  initializeArrays() {
    this.userRating = [];
    this.descriptionStatusTF = [];
    this.recipeStatusTF = [];
    this.commentStatusTF = [];
    this.editRecipeTF = [];
    this.postStatusTF = [];
    this.editRecipe = [];
    for (let i = 0; i < this.recipes.length; i++) {
      //recipe rating average
      this.getRatingAverage(i);
      this.descriptionStatusTF.push(true);
      this.recipeStatusTF.push(false);
      this.commentStatusTF.push(false);
      // this.ratingStatusTF.push(false);
      this.postStatusTF.push(false);
      this.editRecipeTF.push(false);
      this.editRecipe[i] = Object.assign({}, this.recipes[i]);
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
  // ratingStatus(index : number){
  //   this.descriptionStatusTF[index] = false;
  //   this.recipeStatusTF[index] = false;
  //   this.commentStatusTF[index] = false;
  //   // this.ratingStatusTF[index] = true;
  //   this.postStatusTF[index] = false;
  // }
  postStatus(index : number){
    this.descriptionStatusTF[index] = false;
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = false;
    // this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = true;
  }

  getRatingAverage(recipeIndex: number){
    let average = 0;

    for (let index = 0; index < this.recipes[recipeIndex].ratings.length; index++) {
      average += this.recipes[recipeIndex].ratings[index].starRating;
    }
    this.userRating[recipeIndex] = average /= this.recipes[recipeIndex].ratings.length;
  }

  checkNaN(n: number){
    return Number.isNaN(n);
  }

  createRecipeForm(){
    this.createRecipeTF = !this.createRecipeTF;
  }

  createNewRecipe(){
    this.recipeService.create(this.newRecipe, this.rImageUrl).subscribe(
      data => { this.loadAllRecipes();
                this.createRecipeForm(); },

      err => { console.error('Observer error in homeComponent createNewRecipe(): ' + err) }
    );
    this.newRecipe = new Recipe();
  }

  addToMyRecipeList(recipe: Recipe){
    // delete recipe["id"];
    // recipe.id = 0;
    this.userService.addRecipeToUserList(recipe).subscribe(
      data => {
        this.loadAllRecipes();
      }, //Display success or failure message

      err => { console.error('Observer error: ' + err) }
      );
  }

loadUser() {
  this.userService.getUserByUsername().subscribe(
    data => { this.loggedInUser = data;
      // this.initializeArrays();
    },

    error => { console.error('Error retrieving user from userService: ' + error);}
    );
  }

  checkUserMatches(recipe: Recipe){
    return this.loggedInUser.username === recipe.user.username;
  }

  deletefromMyRecipeList(recipe: Recipe){
    // this.loadUser();
    console.log(this.loggedInUser?.username);
    if (this.loggedInUser?.username == recipe.user.username){
      recipe.published = false;
      this.recipeService.delete(recipe).subscribe(
        data => { this.loadAllRecipes();  },
        err => { console.error('Observer error: ' + err) }
        );
      }
    }
  //   // this.loadUser();
  //   this.recipeService.edit(recipe, recipe.recipeImages[0].imageUrl).subscribe(
  //     data => { this.loadAllRecipes();  },
  //     err => { console.error('Observer error: ' + err) }
  //     );
  //   }
  // }

  editMyRecipe(index: number){
    if (this.loggedInUser?.username == this.editRecipe[index].user.username){
      this.recipeService.edit(this.editRecipe[index], this.editRecipe[index].recipeImages[0].imageUrl).subscribe(
        data => { this.loadAllRecipes();
          },
          err => { console.error('Observer error in homeComponent createNewRecipe(): ' + err) }
          );
          this.newRecipe = new Recipe();
        }
  }

  addRating(recipe: Recipe, ratingIndex: number){
    console.log("/////////////////" + ratingIndex + "///////////////////////////////////////");

     this.recipeService.addRating(recipe, this.userRating[ratingIndex], this.loggedInUser.username).subscribe(
       data => {
         this.loadAllRecipes();
       },
       err => {
         console.error('Observer error in homeComponent sendRating(): ' + err)
       }
     );
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

  searchRecipesByTitle(){
    this.recipeService.indexByTitleKeywordUnauthenticated(this.searchTitle).subscribe(
      data => {
        this.recipes = data.reverse();
        this.initializeArrays();
      },
      error => { console.error('Error retrieving recipes from recipeService: ' + error);}
    );
  }

  searchRecipesByDescription(){
    this.recipeService.indexByDescriptionKeywordUnauthenticated(this.searchDescription).subscribe(
      data => {
        this.recipes = data.reverse();
        this.initializeArrays();
      },
      error => { console.error('Error retrieving recipes from recipeService: ' + error);}
    );
  }

  resetSearchParameters(){
    this.searchDescription = '';
    this.searchTitle = '';
    this.loadAllRecipes();
  }

}
