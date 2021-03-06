package com.skilldistillery.mealteam6.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mealteam6.entities.Post;
import com.skilldistillery.mealteam6.entities.PostComment;
import com.skilldistillery.mealteam6.entities.Recipe;
import com.skilldistillery.mealteam6.services.PostService;

@RestController
@CrossOrigin({ "*", "http://localhost:1776" })
@RequestMapping("api")
public class PostController {

	@Autowired
	private PostService postService;

	@PostMapping("posts")
	public Post create(HttpServletRequest req, HttpServletResponse res, @RequestBody Post post, Principal principal) {
		return postService.create(post);
	}

	@PutMapping("posts")
	public Post update(HttpServletRequest req, HttpServletResponse res, @RequestBody Post post, Principal principal) {
		
		try {
			post = postService.update(post);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(post.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			post = null;
			res.setStatus(400);
		}

		return post;
	}

//	@DeleteMapping("posts/{id}")
//	public void delete(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
//		try {
//			boolean deleted = postService.destroy(id);
//			if (deleted) {
//				res.setStatus(204);
//			} else {
//				res.setStatus(404);
//			}
//		} catch (Exception e) {
//			res.setStatus(400);
//		}
//	}
	
	@DeleteMapping("posts/{postId}")
    public void unPublishPost(@PathVariable int postId, HttpServletResponse res, Principal Principal) {
    	boolean deleted = false;
    	deleted = postService.destroy(postId);
    	if (deleted) {
			res.setStatus(204);
		} else {
			res.setStatus(403);
		}
    	
    }
	
	@GetMapping("posts/{id}")
	public Post showPost(@PathVariable int id, HttpServletRequest req, HttpServletResponse res) {
		Post post = postService.getPost(id);
		if (post == null) {
			System.out.println("////////////////  in showPost()");
			res.setStatus(404);
		} else {
			res.setStatus(201);
			System.out.println("?????????????????????????????????????????????" + post.getUser().getRecipeComments());

		}
		return post;
	}

//	@GetMapping("posts")
//	public List<Post> index(HttpServletRequest req, HttpServletResponse res, Principal principal) {
//		List<Post> posts = null;
//		posts = postService.showAllPosts();  // How do we ensure a user is logged in?
//		if(posts == null) {
//			res.setStatus(404);
//		} else {
//			res.setStatus(200);  // 200 or 201?
//		}
//		return posts;
//	}
	
//	@GetMapping("posts/published")
//	public List<Post> indexByPublishedTrue(HttpServletRequest req, HttpServletResponse res, Principal principal) {
//		List<Post> posts = null;
//		posts = postService.showAllPublishedPosts();  // How do we ensure a user is logged in?
//		if(posts == null) {
//			res.setStatus(404);
//		} else {
//			res.setStatus(200);  // 200 or 201?
//		}
//		return posts;
//	}

	@GetMapping("posts/published")
	public List<Post> indexByUsernameAndPublishedTrue(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Post> posts = null;
		posts = postService.findByUser_UsernameAndPublishedTrue(principal.getName());  // How do we ensure a user is logged in?
		if(posts == null) {
			res.setStatus(404);
		} else {
			res.setStatus(200);  // 200 or 201?
		}
		return posts;
	}
	
//	@PostMapping("posts/add/comment/new/{postId}")
//    public Post createPostComment(HttpServletRequest req, HttpServletResponse res, @PathVariable int postId,
//    		                       @RequestBody PostComment comment, Principal principal) {
//    	Post post = null;
//    	try {
//    		post = postService.addCommentToPost(postId, comment, principal.getName());
//    		res.setStatus(201);
//    	} catch (Exception e) {
//    		res.setStatus(400);
//    		post = null;
//    	}
//    	return post;
//    }
}
