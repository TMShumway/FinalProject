package com.skilldistillery.mealteam6.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Recipe {

/////////////// Fields ////////////////

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String description;
	@CreationTimestamp
	@Column(name = "date_created")
	private LocalDateTime dateCreated;
	private boolean published;	
	@Column(name = "recipe_step")
	private String recipeStep;

	@JsonIgnoreProperties("recipe")
	@OneToMany(mappedBy = "recipe")
	private List<RecipeImage> recipeImages;

	@JsonIgnoreProperties("user")
	@OneToMany(mappedBy = "recipe")
	private List<Rating> ratings;

	@OneToMany(mappedBy="recipe")
	private List<Post> posts;

	@OneToMany(mappedBy = "recipe")
	private List<RecipeComment> recipeComments;

	@ManyToMany(mappedBy = "recipes")
	private List<Category> categories;

	@ManyToMany(mappedBy = "recipes")
	private List<Ingredient> ingredients;

	@ManyToMany(mappedBy = "recipes")
	private List<Restriction> restrictions;

	
	@JsonIgnoreProperties(value = {"posts", "ratings", "postComments", "recipeComments", "recipeImages"})
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

/////////////// Methods ////////////////

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(LocalDateTime dateCreated) {
		this.dateCreated = dateCreated;
	}

	public boolean getPublished() {
		return published;
	}

	public void setPublished(boolean published) {
		this.published = published;
	}

	public List<RecipeImage> getRecipeImages() {
		return recipeImages;
	}

	public void setRecipeImages(List<RecipeImage> recipeImages) {
		this.recipeImages = recipeImages;
	}

	public List<Rating> getRatings() {
		return ratings;
	}

	public void setRatings(List<Rating> ratings) {
		this.ratings = ratings;
	}

	public List<Post> getPosts() {
		return posts;
	}
	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}
	
	public List<RecipeComment> getRecipeComments() {
		return recipeComments;
	}

	public void setRecipeComments(List<RecipeComment> recipeComments) {
		this.recipeComments = recipeComments;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public List<Ingredient> getIngredients() {
		return ingredients;
	}

	public void setIngredients(List<Ingredient> ingredients) {
		this.ingredients = ingredients;
	}

	public List<Restriction> getRestrictions() {
		return restrictions;
	}

	public void setRestrictions(List<Restriction> restrictions) {
		this.restrictions = restrictions;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRecipeStep() {
		return recipeStep;
	}

	public void setRecipeStep(String recipeStep) {
		this.recipeStep = recipeStep;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((categories == null) ? 0 : categories.hashCode());
		result = prime * result + ((dateCreated == null) ? 0 : dateCreated.hashCode());
		result = prime * result + ((description == null) ? 0 : description.hashCode());
		result = prime * result + id;
		result = prime * result + ((ingredients == null) ? 0 : ingredients.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((posts == null) ? 0 : posts.hashCode());
		result = prime * result + (published ? 1231 : 1237);
		result = prime * result + ((ratings == null) ? 0 : ratings.hashCode());
		result = prime * result + ((recipeComments == null) ? 0 : recipeComments.hashCode());
		result = prime * result + ((recipeImages == null) ? 0 : recipeImages.hashCode());
		result = prime * result + ((recipeStep == null) ? 0 : recipeStep.hashCode());
		result = prime * result + ((restrictions == null) ? 0 : restrictions.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
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
		Recipe other = (Recipe) obj;
		if (categories == null) {
			if (other.categories != null)
				return false;
		} else if (!categories.equals(other.categories))
			return false;
		if (dateCreated == null) {
			if (other.dateCreated != null)
				return false;
		} else if (!dateCreated.equals(other.dateCreated))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (id != other.id)
			return false;
		if (ingredients == null) {
			if (other.ingredients != null)
				return false;
		} else if (!ingredients.equals(other.ingredients))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (posts == null) {
			if (other.posts != null)
				return false;
		} else if (!posts.equals(other.posts))
			return false;
		if (published != other.published)
			return false;
		if (ratings == null) {
			if (other.ratings != null)
				return false;
		} else if (!ratings.equals(other.ratings))
			return false;
		if (recipeComments == null) {
			if (other.recipeComments != null)
				return false;
		} else if (!recipeComments.equals(other.recipeComments))
			return false;
		if (recipeImages == null) {
			if (other.recipeImages != null)
				return false;
		} else if (!recipeImages.equals(other.recipeImages))
			return false;
		if (recipeStep == null) {
			if (other.recipeStep != null)
				return false;
		} else if (!recipeStep.equals(other.recipeStep))
			return false;
		if (restrictions == null) {
			if (other.restrictions != null)
				return false;
		} else if (!restrictions.equals(other.restrictions))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

}
