package com.skilldistillery.mealteam6.services;

import java.util.List;

import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.User;

public interface UserService {

	List<User> index();

	User userByUsername(String username);

	User updateUser(String name, int uid, User user);

	User userById(int uid);

	User addToUserRecipes(String username, Recipe recipe);
//	boolean destroy(int uid);


}
