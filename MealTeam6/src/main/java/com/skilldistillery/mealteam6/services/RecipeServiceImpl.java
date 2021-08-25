package com.skilldistillery.mealteam6.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.RecipeImage;
import com.skilldistillery.mealteam6.entities.RecipeImageId;
import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.repositories.RecipeImageRepository;
import com.skilldistillery.mealteam6.repositories.RecipeRepository;
import com.skilldistillery.mealteam6.repositories.UserRepository;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	private RecipeRepository recipeRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private RecipeImageRepository recipeImageRepo;
	
	
	// Return all recipes
	@Override
	public List<Recipe> index() {
		List<Recipe> recipes;
		try {
			recipes = recipeRepo.findByPublishedTrueAndPersonalFalse();
		} catch (Exception e) {
			recipes = null;
		}
		return recipes;
	}

	// Return all recipes by Username
	@Override
	public List<Recipe> indexByUsername(String username) {
		List<Recipe> recipes;
		try {
			recipes = recipeRepo.findByPublishedTrueAndPersonalTrueAndUser_Username(username);
		} catch (Exception e) {
			recipes = null;
		}
		return recipes;
	}

	// Return all recipes by keyword search
	@Override
	public List<Recipe> indexByKeyword(String keyword) {
		List<Recipe> recipes;
		try {
			recipes = recipeRepo.findByPublishedTrueAndPersonalFalseAndNameContainsOrDescriptionContains(keyword, keyword);
		} catch (Exception e) {
			recipes = null;
		}
		return recipes;
	}

	// Return one recipe by recipe Id
	@Override
	public Recipe show(int recipeId) {
		Optional<Recipe> recipeOptional = recipeRepo.findById(recipeId);
		Recipe recipe = null;

		if (recipeOptional.isPresent()) {
			recipe = recipeOptional.get();
		}
		return recipe;
	}

	// Create a recipe
	@Override
	public Recipe createRecipe(Recipe recipe, String username, String imageUrl) {
		
		try {
			User user = userRepo.findByUsername(username);
			recipe.setUser(user);
			recipeRepo.save(recipe);
			List <RecipeImage> rImages = new ArrayList<>();
			rImages.add(addImageToRecipe(recipe, imageUrl));
			recipe.setRecipeImages(rImages);
			recipeRepo.saveAndFlush(recipe);
		} catch (Exception e) {
			recipe = null;
		}
		return recipe;
	}

	@Override
	public RecipeImage addImageToRecipe(Recipe recipe, String imageUrl) throws Exception {
		RecipeImageId rId = new RecipeImageId(recipe.getId(), recipe.getUser().getId());
		RecipeImage rImage = new RecipeImage();
		rImage.setId(rId);
		rImage.setImageUrl(imageUrl);
		rImage.setRecipe(recipe);
		return recipeImageRepo.saveAndFlush(rImage);
	}

	// Update a recipe
	@Override
	public Recipe updateRecipe(Recipe recipe, int recipeId, String imageUrl) {
		Recipe managedRecipe = null;
		try {
			Optional<Recipe> recipeOptional = recipeRepo.findById(recipeId);
			if(recipeOptional.isPresent()) {
				managedRecipe = recipeOptional.get();
				managedRecipe.setName(recipe.getName());
				managedRecipe.setDescription(recipe.getDescription());
				managedRecipe.getRecipeImages().get(0).setImageUrl(imageUrl);
				managedRecipe.setRecipeStep(recipe.getRecipeStep());
				recipeRepo.saveAndFlush(managedRecipe);
				// TODO: How will we update other relational mappings?
			}
		} catch (Exception e) {
			managedRecipe = null;		
		}
		return managedRecipe;
	}
	
	@Override
	public boolean deleteRecipe(int recipeId) {
		Recipe recipeToDelete = null;
		try {
			Optional<Recipe> recipeOptional = recipeRepo.findById(recipeId);
			if(recipeOptional.isPresent()) {
				recipeToDelete = recipeOptional.get();
				recipeToDelete.setPublished(false);
				recipeRepo.saveAndFlush(recipeToDelete);
			}
		} catch (Exception e) {
			return false;
		}
		return true;
	}
	
	// Create a recipe
		@Override
		public Recipe createRecipe(Recipe recipe, String username) {
			try {
				User user = userRepo.findByUsername(username);
				recipe.setUser(user);
				recipe.setPersonal(true);
				recipeRepo.save(recipe);
				List <RecipeImage> rImages = new ArrayList<>();
				rImages.add(addImageToRecipe(recipe, recipe.getRecipeImages().get(0).getImageUrl()));
				recipe.setRecipeImages(rImages);
				recipeRepo.saveAndFlush(recipe);
			} catch (Exception e) {
				recipe = null;
			}
			return recipe;
		}
			
}
