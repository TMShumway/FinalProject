package com.skilldistillery.mealteam6.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.skilldistillery.mealteam6.entities.Rating;
import com.skilldistillery.mealteam6.entities.RatingId;

public interface RatingRepository extends JpaRepository<Rating, RatingId>{

}
