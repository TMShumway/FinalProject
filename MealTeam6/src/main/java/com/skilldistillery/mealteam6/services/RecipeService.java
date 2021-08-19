package com.skilldistillery.mealteam6.services;

import java.util.List;

import com.skilldistillery.mealteam6.entities.Recipe;

public interface RecipeService {

	List<Recipe> index();
	List<Recipe> indexByUsername(String username);
	Recipe show(int recipeId);
	Recipe createRecipe(Recipe recipe, String username);
	Recipe updateRecipe(Recipe recipe, int recipeId);
	
}
