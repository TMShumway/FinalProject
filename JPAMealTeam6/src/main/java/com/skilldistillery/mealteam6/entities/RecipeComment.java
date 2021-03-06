package com.skilldistillery.mealteam6.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonIncludeProperties;

@Entity
@Table(name="recipe_comment")
public class RecipeComment {
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String details;
	
	@CreationTimestamp
	@Column(name="date_created")
	private LocalDateTime dateCreated;

	@ManyToOne
	@JsonIgnoreProperties("recipeComments")
	@JoinColumn(name = "recipe_id")
	private Recipe recipe;
	
//	@OneToMany
//	@JoinColumn(name = "recipe_comment_reply_id")
//	private List<RecipeComment> recipeComments;
	
	@ManyToOne
//	@JsonIgnoreProperties(value = {"posts"})
	@JsonIncludeProperties({"id", "username", "dateCreated"})
	@JoinColumn(name = "user_id")
	private User user;
	
	@ManyToMany
	@JoinTable(name = "recipe_comment_like",
			   joinColumns = @JoinColumn(name = "recipe_comment_id"),
			   inverseJoinColumns = @JoinColumn(name = "user_id")
			  )
	private List<User> userLikes;
	///////////////////// Methods
	public RecipeComment() {}
	
	public RecipeComment(int id, String details, LocalDateTime dateCreated) {
		super();
		this.id = id;
		this.details = details;
		this.dateCreated = dateCreated;
	}

	public Recipe getRecipe() {
		return recipe;
	}
	
	public void setRecipe(Recipe recipe) {
		this.recipe = recipe;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getDetails() {
		return details;
	}
	
	public void setDetails(String details) {
		this.details = details;
	}
	
	public LocalDateTime getDateCreated() {
		return dateCreated;
	}
	
	public void setDateCreated(LocalDateTime dateCreated) {
		this.dateCreated = dateCreated;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dateCreated == null) ? 0 : dateCreated.hashCode());
		result = prime * result + ((details == null) ? 0 : details.hashCode());
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
		RecipeComment other = (RecipeComment) obj;
		if (dateCreated == null) {
			if (other.dateCreated != null)
				return false;
		} else if (!dateCreated.equals(other.dateCreated))
			return false;
		if (details == null) {
			if (other.details != null)
				return false;
		} else if (!details.equals(other.details))
			return false;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "RecipeComment [id=" + id + ", details=" + details + ", dateCreated=" + dateCreated + "]";
	}
	
	
}
