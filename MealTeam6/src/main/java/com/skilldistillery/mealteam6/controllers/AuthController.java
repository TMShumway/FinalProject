package com.skilldistillery.mealteam6.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.services.AuthService;

@RestController
@CrossOrigin({"*", "http://localhost:1776"})
public class AuthController {
	
	@Autowired
	private AuthService authService;
	
	
	@PostMapping("/register")
	public User register(@RequestBody User user, HttpServletResponse res) {

	    if (user == null) {
	        res.setStatus(400);
	    }

	    user = authService.register(user);

	    return user;
	}

	@GetMapping("/authenticate")
	public Principal authenticate(Principal principal) {
	    return principal;
	}
	
	
}
