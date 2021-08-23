package com.skilldistillery.mealteam6.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mealteam6.entities.RecipeImage;
import com.skilldistillery.mealteam6.entities.RecipeImageId;

public interface RecipeImageRepository extends JpaRepository<RecipeImage, RecipeImageId> {

}
