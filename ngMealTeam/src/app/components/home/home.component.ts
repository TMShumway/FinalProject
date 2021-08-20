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

  constructor(private recipeService: RecipeService) { }

  ngOnInit(): void {
    this.loadAllRecipes();
  }

  loadAllRecipes() {
    this.recipeService.index().subscribe(
      data => { this.recipes = data;},

      error => { console.error('Error retrieving recipes from recipeService: ' + error);}
    );
  }
}
