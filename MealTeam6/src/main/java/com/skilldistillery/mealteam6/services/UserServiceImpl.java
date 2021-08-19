package com.skilldistillery.mealteam6.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private PasswordEncoder encoder;
	
	
	@Override
	public List<User> index(){
		return userRepo.findAll();
	}
	

	@Override
	public User userByUsername(String username) {
		return userRepo.findByUsername(username);
	}
	
	
	

	@Override
	public User update(String name, int uid, User user) {	
		User managed = userRepo.findByUsername(name);
		if (managed != null) {
			if( name == user.getUsername()) {
				
				managed.setUsername(user.getUsername());
				if (user.getPassword() != null || user.getPassword().length() > 0) {
					managed.setPassword(encoder.encode(user.getPassword()));
				}
				managed.setEnabled(user.getEnabled());
				managed.setEmail(user.getEmail());
				managed.setRole(user.getRole());
				userRepo.saveAndFlush(managed);
			}
			else {
				managed = null;
			}
		}
		return managed;
	}
	
	@Override
	public boolean destroy(int uid) {
		boolean deleted = false;
		Optional<User> user = userRepo.findById(uid);
		if (user.isPresent()) {
			userRepo.deleteById(uid);
			deleted = true;
		}
		return deleted;
	}
	
}
