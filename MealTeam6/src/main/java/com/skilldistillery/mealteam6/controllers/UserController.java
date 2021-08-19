package com.skilldistillery.mealteam6.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.services.UserService;

@RestController
@RequestMapping("api")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("users/{username}")
	public User getUserByUsername(
			@PathVariable String username,
			HttpServletResponse res
			) {
		User user = userService.userByUsername(username);
		return user;
	}
	
	//  PUT users/{uid}
	@PutMapping("users/{uid}")
	public User update(
			HttpServletRequest req, 
			HttpServletResponse res, 
			Principal principal,
			@PathVariable int uid, 
			@RequestBody User user) {
		return userService.update(principal.getName(), uid, user); 
	}

}
