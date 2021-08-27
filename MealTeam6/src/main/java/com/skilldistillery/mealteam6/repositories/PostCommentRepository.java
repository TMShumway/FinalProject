package com.skilldistillery.mealteam6.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mealteam6.entities.PostComment;

public interface PostCommentRepository extends JpaRepository<PostComment, Integer> {

	
	
}
