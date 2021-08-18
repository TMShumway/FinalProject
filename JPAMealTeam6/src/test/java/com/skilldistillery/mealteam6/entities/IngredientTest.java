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

class IngredientTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Ingredient ingredient;

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
		ingredient = em.find(Ingredient.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		ingredient = null;
	}

	@Test
	void test() {
		assertNotNull(ingredient);
		assertEquals("eggs", ingredient.getName());
	}

}
