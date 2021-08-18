package com.skilldistillery.mealteam6.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class RecipeImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private RecipeImage recipeImage;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAMealTeam6");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		RecipeImageId rid = new RecipeImageId();
		rid.setRecipeId(1);
		rid.setUserId(1);
		recipeImage = em.find(RecipeImage.class, rid);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recipeImage = null;
	}

	@Test
	void test() {
		assertNotNull(recipeImage);
		assertEquals("https://unsplash.com/photos/Ucwd8w-JHwM", recipeImage.getImageUrl());
	}
}
