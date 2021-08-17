package com.skilldistillery.mealteam6.services;

import com.skilldistillery.mealteam6.entities.User;

public interface UserService {

	User userByUsername(String username);
	
}
