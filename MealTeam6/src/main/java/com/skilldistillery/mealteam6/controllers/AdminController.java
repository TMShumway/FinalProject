package com.skilldistillery.mealteam6.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mealteam6.entities.Post;
import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.services.PostService;
import com.skilldistillery.mealteam6.services.RecipeService;
import com.skilldistillery.mealteam6.services.UserService;

@RestController
@CrossOrigin({"*", "http://localhost:1776"})
@RequestMapping(path = "api")
public class AdminController {
	
	@Autowired
	private UserService userService;

	@Autowired
	private RecipeService recipeService;
	
	@Autowired
	private PostService postService;
	
	@GetMapping("admin/users")
	public List<User> getAllUsers(HttpServletResponse res, Principal principal)
	{
		List<User> users = null;
		users = userService.index(principal.getName());
		if (users == null) {
			res.setStatus(404);
		}
		return users;
	}
	
	@GetMapping("/admin/recipes")
	private List<Recipe> index(HttpServletResponse res, Principal principal) {
		List<Recipe> recipes = null;
		recipes = recipeService.indexAdmin(principal.getName());
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}
	
	@GetMapping("admin/posts")
	public List<Post> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Post> posts = null;
		posts = postService.showAllPosts(principal.getName());  // How do we ensure a user is logged in?
		if(posts == null) {
			res.setStatus(404);
		}
		return posts;
	}
	
}
