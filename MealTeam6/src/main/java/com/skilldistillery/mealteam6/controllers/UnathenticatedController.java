package com.skilldistillery.mealteam6.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.services.RecipeService;

@RestController
@CrossOrigin({ "*", "http://localhost:1776" })
@RequestMapping("unauthenticated")
public class UnathenticatedController {

	@Autowired
	private RecipeService recipeService;
	
	@GetMapping("recipes")
	private List<Recipe> index(HttpServletResponse res) {
		List<Recipe> recipes = null;
		recipes = recipeService.index();
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}

	@GetMapping("search/title/{keyword}")
	private List<Recipe> indexTitleKeyword(HttpServletResponse res, @PathVariable String keyword) {
		List<Recipe> recipes = null;
		recipes = recipeService.indexByTitleKeyword(keyword);
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}

	@GetMapping("search/description/{keyword}")
	private List<Recipe> indexDescriptionKeyword(HttpServletResponse res, @PathVariable String keyword) {
		List<Recipe> recipes = null;
		recipes = recipeService.indexByDescriptionKeyword(keyword);
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}
	
}
