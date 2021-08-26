package com.skilldistillery.mealteam6.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mealteam6.entities.RecipeComment;

public interface RecipeCommentRepository extends JpaRepository<RecipeComment, Integer> {

}
