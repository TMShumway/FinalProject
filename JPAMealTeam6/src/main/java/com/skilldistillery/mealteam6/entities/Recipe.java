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
	private Integer published;

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

	public int getPublished() {
		return published;
	}

	public void setPublished(int published) {
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

	public void setPublished(Integer published) {
		this.published = published;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	// @Override
//	public String toString() {
//		return "Recipe [id=" + id + ", name=" + name + ", description=" + description + ", dateCreated=" + dateCreated
//				+ ", published=" + published + ", recipeImages=" + recipeImages + ", ratings=" + ratings + ", posts="
//				+ posts + ", recipeComments=" + recipeComments + ", categories=" + categories + ", ingredients="
//				+ ingredients + ", restrictions=" + restrictions + "]";
//	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dateCreated == null) ? 0 : dateCreated.hashCode());
		result = prime * result + ((description == null) ? 0 : description.hashCode());
		result = prime * result + id;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + published;
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
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (published != other.published)
			return false;
		return true;
	}

}
