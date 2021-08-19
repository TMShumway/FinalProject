package com.skilldistillery.mealteam6.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
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
	
	
	@GetMapping("users")
	public List<User> getAllUsers(
			HttpServletResponse res
			){
		List<User> users = userService.index();
		return users;
	}
	
//	@GetMapping("users/{uid}")
//	public User getUserByUsername(
//			@PathVariable int uid,
//			HttpServletResponse res
//			) {
//		User user = userService. 
//		return user;
//	}
	
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
		
		try {
			System.out.println(user);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(user.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			res.setStatus(400);
			return null;
		}
		return userService.update(principal.getName(), uid, user); 
	}
	
	
	@DeleteMapping("users/{uid}")
	public boolean delete(
			HttpServletRequest req, 
			HttpServletResponse res, 
			Principal principal,
			@PathVariable int uid
			) {
		return userService.destroy(uid);
	}

}
