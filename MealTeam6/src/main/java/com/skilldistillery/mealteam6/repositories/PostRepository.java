package com.skilldistillery.mealteam6.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mealteam6.entities.Post;

public interface PostRepository extends JpaRepository<Post, Integer> {
	// SELECT * from POST 
	List<Post> findByDescriptionContainingIgnoreCaseOrTitleIgnoreCaseContaining(String keyword, String keyword1);
	List<Post> findByUser_Username(String username);
	List<Post> findByPublishedTrue();
	List<Post> findByUser_UsernameAndPublishedTrue(String username);
}
