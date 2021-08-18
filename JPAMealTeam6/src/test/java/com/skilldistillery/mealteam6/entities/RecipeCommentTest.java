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

class RecipeCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private RecipeComment recipeComment;
	
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
		recipeComment = em.find(RecipeComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recipeComment = null;
	}
	
	@Test
	void test() {
//		| id | recipe_id | details         | user_id | date_created | recipe_comment_reply_id |
//		+----+-----------+-----------------+---------+--------------+-------------------------+
//		|  1 |         1 | THIS IS COOL!!! |       1 | NULL         |                    NULL |
		assertNotNull(recipeComment);
		assertEquals("THIS IS COOL!!!", recipeComment.getDetails());
		assertNull(recipeComment.getDateCreated());
		
	}

}
