package com.skilldistillery.mealteam6.services;

import java.util.List;

import com.skilldistillery.mealteam6.entities.Rating;
import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.RecipeComment;
import com.skilldistillery.mealteam6.entities.RecipeImage;

public interface RecipeService {

	List<Recipe> index();
	List<Recipe> indexAdmin(String username);
	List<Recipe> indexByUsername(String username);
	Recipe show(int recipeId);
	Recipe createRecipe(Recipe recipe, String username, String imageUrl);
//	Recipe updateRecipe(Recipe recipe, int recipeId);
	RecipeImage addImageToRecipe(Recipe recipe, String imageUrl) throws Exception;
	boolean deleteRecipe(int recipeId);
	Recipe createRecipe(Recipe recipe, String username);
	List<Recipe> indexByTitleKeyword(String keyword);
	List<Recipe> indexByDescriptionKeyword(String keyword);
	Recipe updateRecipe(Recipe recipe, int recipeId, String imageUrl);
	Rating addRatingToRecipe(Recipe recipe, String username, int starRating);
	Recipe addCommentToRecipe(int recipeId, RecipeComment comment, String username);
	
}
