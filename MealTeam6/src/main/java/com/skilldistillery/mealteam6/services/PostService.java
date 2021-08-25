package com.skilldistillery.mealteam6.services;

import java.util.List;

import com.skilldistillery.mealteam6.entities.Post;

public interface PostService {
	
	public List<Post> getPostByKeyWord(String keyword);
	public Post getPost(int id);
	public Post create(Post post);
	public Post update(Post post);
	public boolean destroy(int id);
	public List<Post> showAllPosts();
	public List<Post> showPostsByUsername(String username);
	public List<Post> showAllPublishedPosts();
	public List<Post> findByUser_UsernameAndPublishedTrue(String username);
	
}
