package com.skilldistillery.mealteam6.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String username;
	private String password;
	private Boolean enabled;
	private String email;
	private String role;
	@CreationTimestamp
	@Column(name="date_created")
	private LocalDateTime dateCreated;
	@Column(name="image_url")
	private String imgUrl;
	@JsonIgnoreProperties("user")
	@OneToMany(mappedBy="user")
	private List<Post> posts;
	@JsonIgnoreProperties("user")
	@OneToMany(mappedBy="user")
	private List<Rating> ratings;
	@JsonIgnoreProperties("user")
	@OneToMany(mappedBy="user")
	private List<PostComment> postComments;
	@JsonIgnoreProperties("user")
	@OneToMany(mappedBy="user")
	private List<RecipeComment> recipeComments;
//	@JsonIgnoreProperties("user")
//	@OneToMany(mappedBy="user")
//	private List<RecipeImage> recipeImages;
	
//	@OneToMany
//	@JsonIgnoreProperties("followedUsers")
//	private List<User> followedUsers;
//	
//	@OneToMany
//	@JsonIgnoreProperties("usersFollowingMe")
//	private List<User> usersFollowingMe;
//	
	@OneToMany(mappedBy = "user")
	private List<Recipe> recipes;
	
	//TODO: Other user fields
	
	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}

	public List<PostComment> getPostComments() {
		return postComments;
	}

	public void setPostComments(List<PostComment> postComments) {
		this.postComments = postComments;
	}

	public List<RecipeComment> getRecipeComments() {
		return recipeComments;
	}

	public void setRecipeComments(List<RecipeComment> recipeComments) {
		this.recipeComments = recipeComments;
	}
	
	public void addRecipeToRecipes(Recipe recipe) {
		this.recipes.add(recipe);
	}

//	public List<RecipeImage> getRecipeImages() {
//		return recipeImages;
//	}
//
//	public void setRecipeImages(List<RecipeImage> recipeImages) {
//		this.recipeImages = recipeImages;
//	}

//	public List<User> getFollowedUsers() {
//		return followedUsers;
//	}
//
//	public void setFollowedUsers(List<User> followedUsers) {
//		this.followedUsers = followedUsers;
//	}
//
//	public List<User> getUsersFollowingMe() {
//		return usersFollowingMe;
//	}
//
//	public void setUsersFollowingMe(List<User> usersFollowingMe) {
//		this.usersFollowingMe = usersFollowingMe;
//	}

	public List<Recipe> getRecipes() {
		return recipes;
	}

	public void setRecipes(List<Recipe> recipes) {
		this.recipes = recipes;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public LocalDateTime getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(LocalDateTime dateCreated) {
		this.dateCreated = dateCreated;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	

}
