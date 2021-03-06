package com.skilldistillery.mealteam6.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mealteam6.entities.Post;
import com.skilldistillery.mealteam6.entities.PostComment;
import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.entities.User;
import com.skilldistillery.mealteam6.repositories.PostRepository;
import com.skilldistillery.mealteam6.repositories.UserRepository;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostRepository postRepo;

	@Autowired
	private UserRepository userRepo;
	
	@Override
	public List<Post> getPostByKeyWord(String keyword) {
		
		return postRepo.findByDescriptionContainingIgnoreCaseOrTitleIgnoreCaseContaining(keyword, keyword);
	}

	@Override
	public Post getPost(int id) {
		Optional<Post> optPost = postRepo.findById(id);
		if (optPost.isPresent()) {
			return optPost.get();
		}
		return null;
	}

	@Override
	public Post create(Post post) {
		return postRepo.saveAndFlush(post);
		
	}
	
	
	@Override
	public Post update(Post post) {
		Optional<Post> managed = postRepo.findById(post.getId());
		if (managed.isPresent()) {
			Post mp = managed.get();
			mp.setDateCreated(post.getDateCreated());
			mp.setDescription(post.getDescription());
			mp.setImageUrl(post.getImageUrl());
			mp.setTitle(post.getTitle());
			mp.setUser(post.getUser());
			
			return postRepo.saveAndFlush(mp);
		}
		return null;
	}

//	@Override
//	public boolean destroy(int id) {
//		Optional<Post> post = postRepo.findById(id);
//		if (post.isPresent()) {
//			Post mp = post.get();
//			postRepo.delete(mp);
//			return true;
//		}
//		return false;
//	}
	
	@Override
	public boolean destroy(int postId) {
		Post postToDelete = null;
		try {
			Optional<Post> postOptional = postRepo.findById(postId);
			if(postOptional.isPresent()) {
				postToDelete = postOptional.get();
				postToDelete.setPublished(false);
				postRepo.saveAndFlush(postToDelete);
			}
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public List<Post> showAllPosts(String username) {
		List<Post> posts = null;
		User user = userRepo.findByUsername(username);
		if(user.getRole().equals("ADMIN")) {
			try {
				posts = postRepo.findAll();
			} catch (Exception e) {
				posts = null;
			}
		}
		return posts;
	}

	@Override
	public List<Post> showAllPublishedPosts() {
		return postRepo.findByPublishedTrue();
	}
	
	

	@Override
	public List<Post> showPostsByUsername(String username) {
		List<Post> posts = null;
		try {
			posts = postRepo.findByUser_Username(username);
		} catch (Exception e) {
			posts = null;
		}
		return posts;
	}

	@Override
	public List<Post> findByUser_UsernameAndPublishedTrue(String username) {
		List<Post> posts = null;
		try {
			posts = postRepo.findByUser_UsernameAndPublishedTrue(username);
		} catch (Exception e) {
			posts = null;
		}
		return posts;
	}

	@Override
	public Post adminFlipPublished(int postId, String name) {
		Post post = null;
		if (userRepo.findByUsername(name).getRole().equals("ADMIN")) {
			try {
				Optional<Post> postO = postRepo.findById(postId);
				if(postO.isPresent()) {
					post = postO.get();
					post.setPublished(!post.getPublished());
					post = postRepo.saveAndFlush(post);
				}
			} catch (Exception e) {
				post = null;
			} 
		}
		return post;
	}

//	@Override
//	public Post addCommentToPost(int postId, PostComment comment, String username) {
//		Post post = null;
//		User user = null;
//		try {
//			user = userRepo.findByUsername(username);
//			Optional<Post> recipeOptional = postRepo.findById(postId);
//			if(recipeOptional.isPresent()) {
//				post = recipeOptional.get();
//				comment.set(post);
//				comment.setUser(user);
//				comment = recipeCommentRepo.saveAndFlush(comment);
//			}
//		} catch (Exception e) {
//			recipe = null;
//		}
//		return recipe;
//	}

}
