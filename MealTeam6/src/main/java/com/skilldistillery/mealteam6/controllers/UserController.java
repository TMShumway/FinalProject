package com.skilldistillery.mealteam6.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mealteam6.entities.Post;
import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.services.PostService;
import com.skilldistillery.mealteam6.services.UserService;

@RestController
@CrossOrigin({ "*", "http://localhost:1776" })
@RequestMapping("api")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PostService postService;
	
	@GetMapping("users")
	public List<User> getAllUsers(HttpServletResponse res, Principal principal)
	{
		List<User> users = null;
		users = userService.index();
		if (users == null) {
			res.setStatus(404);
		}
		return users;
	}
	
	@GetMapping("users/{uid}")
	public User getUserByUsername(
			@PathVariable int uid,
			Principal principal,
			HttpServletResponse res
			) {
		User user = null;
		user = userService.userById(uid); 
		if(user == null) {
			res.setStatus(404);
		}
		return user;
	}
	
	@GetMapping("users/usernames/{username}")
	public User getUserByUsername(
			@PathVariable String username,
			Principal principal,
			HttpServletResponse res
			) {
		User user = null;
		user = userService.userByUsername(username);
		if(user == null) {
			res.setStatus(404);
		}
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
		
		System.out.println("*******" + user.getUsername());
		try {
			user = userService.updateUser(principal.getName(), uid, user); 
			System.out.println(user);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(user.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
			user = null;
		}
		return user; 
	}
	
	
	@GetMapping("posts/username")
	private List<Post> indexByUsername(HttpServletResponse res, Principal principal) {
		List<Post> posts = null;
		posts = postService.showPostsByUsername(principal.getName());
		if (posts == null) {
			res.setStatus(404);
		}
		return posts;
	}
	
//	@DeleteMapping("users/{uid}")
//	public boolean delete(
//			HttpServletRequest req, 
//			HttpServletResponse res, 
//			Principal principal,
//			@PathVariable int uid
//			) {
//		return userService.destroy(uid);
//	}

}
