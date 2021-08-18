package com.skilldistillery.mealteam6.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class RatingId implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Column(name = "recipe_id")
	private int recipeId;
	
	@Column(name = "user_id")
	private int userId;

	public int getRecipeId() {
		return recipeId;
	}

	public void setRecipeId(int recipeID) {
		this.recipeId = recipeID;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userID) {
		this.userId = userID;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + recipeId;
		result = prime * result + userId;
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
		RatingId other = (RatingId) obj;
		if (recipeId != other.recipeId)
			return false;
		if (userId != other.userId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "RatingId [recipeID=" + recipeId + ", userID=" + userId + "]";
	}
}
