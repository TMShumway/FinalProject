package com.skilldistillery.mealteam6.services;

import java.util.List;

import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.RecipeImage;

public interface RecipeService {

	List<Recipe> index();
	List<Recipe> indexByUsername(String username);
	Recipe show(int recipeId);
	Recipe createRecipe(Recipe recipe, String username, String imageUrl);
	Recipe updateRecipe(Recipe recipe, int recipeId);
	RecipeImage addImageToRecipe(Recipe recipe, String imageUrl) throws Exception;
	
}
