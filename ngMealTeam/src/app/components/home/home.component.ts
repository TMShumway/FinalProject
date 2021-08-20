import { Component, OnInit } from '@angular/core';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from 'src/app/services/recipe.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  recipes: Recipe[] = [];

  // recipeImages:
  // Posts
  // Comments
  selected: Recipe | null = null;
  recipeStatusTF: boolean[] = [];
  commentStatusTF: boolean[] = [];
  ratingStatusTF: boolean[] = [];
  postStatusTF: boolean[] = [];

  constructor(private recipeService: RecipeService) { }

  ngOnInit(): void {
    this.loadAllRecipes();
  }

  selectTab(recipeId: number){

  }


  loadAllRecipes() {
    this.recipeService.index().subscribe(
      data => {
        this.recipes = data;
        this.initializeArrays();

      },

      error => { console.error('Error retrieving recipes from recipeService: ' + error);}
    );
  }

  initializeArrays() {
    for (let i = 0; i < this.recipes.length; i++) {
      this.recipeStatusTF.push(true);
      this.commentStatusTF.push(false);
      this.ratingStatusTF.push(false);
      this.postStatusTF.push(false);
    }
  }


  recipeStatus(index : number){
    this.recipeStatusTF[index] = true;
    this.commentStatusTF[index] = false;
    this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = false;
  }
  commentStatus(index : number){
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = true;
    this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = false;
  }
  ratingStatus(index : number){
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = false;
    this.ratingStatusTF[index] = true;
    this.postStatusTF[index] = false;
  }
  postStatus(index : number){
    this.recipeStatusTF[index] = false;
    this.commentStatusTF[index] = false;
    this.ratingStatusTF[index] = false;
    this.postStatusTF[index] = true;
  }




}

