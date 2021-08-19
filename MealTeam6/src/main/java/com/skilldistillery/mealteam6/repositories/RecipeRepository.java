package com.skilldistillery.mealteam6.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mealteam6.entities.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Integer> {

	// Find Recipes created by a specific user
	List<Recipe> findByUser_Username(String username);
	
}