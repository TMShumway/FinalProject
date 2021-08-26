package com.skilldistillery.mealteam6.controllers;

import java.security.Principal;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mealteam6.entities.Rating;
import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.RecipeComment;
import com.skilldistillery.mealteam6.services.RecipeService;

@RestController
@CrossOrigin({ "*", "http://localhost:1776" })
@RequestMapping(path = "api")
public class RecipeController {

	@Autowired
	private RecipeService recipeService;

	@GetMapping("recipes")
	private List<Recipe> index(HttpServletResponse res, Principal principal) {
		List<Recipe> recipes = null;
		recipes = recipeService.index();
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}
	
	//Get recipes by username with PathVariable username
	@GetMapping("recipes/usernames/{username}")
	private List<Recipe> indexByUsername(HttpServletResponse res, Principal principal, @PathVariable String username) {
		List<Recipe> recipes = null;
		recipes = recipeService.indexByUsername(username);
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}

	//Get recipes by username from logged in user	
	@GetMapping("recipes/username")
	private List<Recipe> indexByUsername(HttpServletResponse res, Principal principal) {
		List<Recipe> recipes = null;
		recipes = recipeService.indexByUsername(principal.getName());
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}

	@GetMapping("recipes/{recipeId}")
	public Recipe show(HttpServletRequest req, HttpServletResponse res, @PathVariable int recipeId,
			Principal principal) {
		Recipe recipe = recipeService.show(recipeId);
		if (recipe == null) {
			res.setStatus(404);
		} else {
			res.setStatus(201);
		}
		return recipe;
	}

	@PostMapping("recipes/{encodedUrl}")
	public Recipe create(HttpServletRequest req, HttpServletResponse res, @RequestBody Recipe recipe, Principal principal, @PathVariable byte[] encodedUrl) {
		String imageUrl = new String(Base64.getDecoder().decode(encodedUrl));
		try {
			recipe = recipeService.createRecipe(recipe, principal.getName(), imageUrl);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(recipe.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			res.setStatus(400);
			recipe = null;
		}
		return recipe;
	}

	@PostMapping("recipes/userlist")
	public Recipe create(HttpServletRequest req, HttpServletResponse res, @RequestBody Recipe recipe, Principal principal) {
		try {
			recipe.setId(0);
			recipe = recipeService.createRecipe(recipe, principal.getName());
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(recipe.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			res.setStatus(400);
			recipe = null;
		}
		return recipe;
	}
	
    @PutMapping("recipes/{recipeId}/{imageUrl}")
	public Recipe update(HttpServletRequest req, HttpServletResponse res, @PathVariable int recipeId, @PathVariable byte[] imageUrl, @RequestBody Recipe recipe, Principal principal) {
		try {
			String decodedUrl = new String(Base64.getDecoder().decode(imageUrl));
			recipe = recipeService.updateRecipe(recipe, recipeId, decodedUrl);
			
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(recipe.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			res.setStatus(400);
			recipe = null;
		}	
		return recipe;
	}
    
    @DeleteMapping("recipes/{recipeId}")
    public void unPublishRecipe(
    		@PathVariable int recipeId, 
    		HttpServletResponse res, 
    		Principal Principal) {
    	boolean deleted = false;
    	deleted = recipeService.deleteRecipe(recipeId);
    	if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(403);
		}
    	
    }
    
    @PostMapping("recipes/{rating}/{username}")
    public Recipe createRating(HttpServletRequest req, HttpServletResponse res, @PathVariable String username, @PathVariable int rating, @RequestBody Recipe recipe, Principal principal) {
    	Rating newRating = null;
    	try {
			newRating = recipeService.addRatingToRecipe(recipe, username, rating);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(recipe.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			res.setStatus(400);
			recipe = null;
		}
		return recipe;
	}

    @PostMapping("recipes/add/comment/new/{recipeId}")
    public Recipe createRecipeComment(HttpServletRequest req, HttpServletResponse res, @PathVariable int recipeId, @RequestBody RecipeComment comment, Principal principal) {
    	Recipe recipe = null;
    	try {
    		recipe = recipeService.addCommentToRecipe(recipeId, comment, principal.getName());
    		res.setStatus(201);
    	} catch (Exception e) {
    		res.setStatus(400);
    		recipe = null;
    	}
    	return recipe;
    }
    
}

