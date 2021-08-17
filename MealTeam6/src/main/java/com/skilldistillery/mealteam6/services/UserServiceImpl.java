package com.skilldistillery.mealteam6.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Override
	public User userByUsername(String username) {
		return userRepo.findByUsername(username);
	}
	
}
