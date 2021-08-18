package com.skilldistillery.mealteam6.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class RecipeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Recipe recipe;

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
		recipe = em.find(Recipe.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recipe = null;
	}

	@Test
	void test() {
		assertNotNull(recipe);
		assertEquals("Spaghetti", recipe.getName());
		assertEquals("And meatballs!", recipe.getDescription());
	}
	
	@Test
	void test_recipe_recipeImage_entity_mapping() {
		assertNotNull(recipe.getRecipeImages());
		assertEquals("https://unsplash.com/photos/Ucwd8w-JHwM",  recipe.getRecipeImages().get(0).getImageUrl());
		
	}
	@Test
	void test_recipe_rating_entity_mapping() {
		assertNotNull(recipe.getRatings());
		assertEquals(5, recipe.getRatings().get(0).getStarRating());
		
	}
	@Test
	void test_recipe_comment_entity_mapping() {
		assertNotNull(recipe.getRecipeComments());
		assertEquals("THIS IS COOL!!!", recipe.getRecipeComments().get(0).getDetails());
		
	}
	@Test
	void test_recipe_categories_entity_mapping() {
		assertNotNull(recipe.getCategories());
		assertEquals("Seafood", recipe.getCategories().get(0).getCategoryName());
		
	}
	@Test
	void test_recipe_ingredients_entity_mapping() {
		assertNotNull(recipe.getIngredients());
		assertEquals("eggs", recipe.getIngredients().get(0).getName());
		
	}
	@Test
	void test_recipe_restrictions_entity_mapping() {
		assertNotNull(recipe.getRestrictions());
		assertEquals("Gluten-Free", recipe.getRestrictions().get(0).getName());
		
	}
	
	
	
	
	
	
	
	

}
