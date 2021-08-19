package com.skilldistillery.mealteam6.services;

import java.util.List;

import com.skilldistillery.mealteam6.entities.User;

public interface UserService {

	List<User> index();

	User userByUsername(String username);

	User update(String name, int uid, User user);

	boolean destroy(int uid);

	
}
