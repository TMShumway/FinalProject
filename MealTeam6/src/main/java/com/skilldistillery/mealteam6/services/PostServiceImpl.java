package com.skilldistillery.mealteam6.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mealteam6.entities.Post;
import com.skilldistillery.mealteam6.repositories.PostRepository;

@Service
public class PostServiceImpl implements PostService {

	@Autowired
	private PostRepository postRepo;
	
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

	@Override
	public boolean destroy(int id) {
		Optional<Post> post = postRepo.findById(id);
		if (post.isPresent()) {
			Post mp = post.get();
			postRepo.delete(mp);
			return true;
		}
		return false;
	}

	@Override
	public List<Post> showAllPosts() {
		return postRepo.findAll();
	}

}
