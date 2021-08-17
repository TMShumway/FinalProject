package com.skilldistillery.mealteam6.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mealteam6.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	User findByUsername(String username);

}
