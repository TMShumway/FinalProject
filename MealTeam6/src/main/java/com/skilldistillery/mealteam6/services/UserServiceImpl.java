package com.skilldistillery.mealteam6.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public List<User> index(String username){
		List<User> users = null;
		User user = userRepo.findByUsername(username);
		if (user.getRole().equals("ADMIN")) {
			try {
				users = userRepo.findAll();
			} catch (Exception e) {
				users = null;
			} 
		}
		return users;
	}

	@Override
	public User userById(int uid) {
		Optional<User> user = userRepo.findById(uid);
		if(user.isPresent()) {
			return user.get();
		}
		return null;
	}
	
	@Override
	public User userByUsername(String username) {
		User user;
		try {
			user = userRepo.findByUsername(username); 
		} catch(Exception e){
			user = null;
		}
		return user;
	}

	@Override
	public User updateUser(String name, int uid, User user) {	
		System.out.println(name);
//		User managed = userRepo.findByUsername(name);
		Optional<User> managed = userRepo.findById(uid);
		User updatedUser = null;
//		System.out.println(managed.getEmail());
		if (managed.isPresent()) {
			updatedUser = managed.get();
//			System.out.println("managed != null" + updatedUser.getUsername());
			System.out.println(user);
			System.out.println(user.getPassword());
			System.out.println(updatedUser);
			System.out.println(updatedUser.getPassword());
			if( name.equals(updatedUser.getUsername())) {
				System.out.println("Success");
				updatedUser.setUsername(user.getUsername());
				if (user.getPassword() != null && user.getPassword().length() > 0) {
					updatedUser.setPassword(encoder.encode(user.getPassword()));
				}
				updatedUser.setEnabled(user.getEnabled());
				updatedUser.setImgUrl(user.getImgUrl());
				updatedUser.setEmail(user.getEmail());
				updatedUser.setRole(user.getRole());
				userRepo.saveAndFlush(updatedUser);
			}
			else {
				updatedUser = null;
			}
		}
		return updatedUser;
	}
	
	@Override
	public User addToUserRecipes(String username, Recipe recipe) {
		User user = null;
		try {
//			recipe.setId(0);
			user = userRepo.findByUsername(username);
			user.addRecipeToRecipes(recipe);
			userRepo.saveAndFlush(user);
		} catch (Exception e) {
			user = null;
		}
		return user;	
	}

	@Override
	public User adminFlipEnabled(int userId, String name) {
		User user = null;
		if (userRepo.findByUsername(name).getRole().equals("ADMIN")) {
			try {
				Optional<User> userO = userRepo.findById(userId);
				if(userO.isPresent()) {
					user = userO.get();
					user.setEnabled(!user.getEnabled());
					user = userRepo.saveAndFlush(user);
				}
			} catch (Exception e) {
				user = null;
			} 
		}
		return user;
	}
	
//	@Override
//	public boolean destroy(int uid) {
//		boolean deleted = false;
//		Optional<User> user = userRepo.findById(uid);
//		if (user.isPresent()) {
//			userRepo.deleteById(uid);
//			deleted = true;
//		}
//		return deleted;
//	}

}
