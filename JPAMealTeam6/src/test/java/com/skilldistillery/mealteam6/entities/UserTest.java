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

class UserTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
	
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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	@Test
	void test_post_to_user_mapping() {
		assertEquals(3, user.getPosts().size());
	}
	
//	@Test
//	void test_user_to_ratings_mapping() {
//		assertEquals(2, user.getRatings().size());
//	}
	
	@Test
	void test_user_to_post_comment_mapping() {
		assertEquals(3, user.getPostComments().size());
	}

	@Test
	void test_user_to_recipe_comment_mapping() {
//		| id | recipe_id | details         | user_id | date_created | recipe_comment_reply_id |
//		+----+-----------+-----------------+---------+--------------+-------------------------+
//		|  1 |         1 | THIS IS COOL!!! |       1 | NULL         |                    NULL |
//		|  4 |         3 | Gross.          |       1 | NULL         |                    NULL |
		assertEquals(2, user.getRecipeComments().size());
	}

	@Test
	void test_user_to_recipe_image_mapping() {

		assertEquals(2, user.getRecipeComments().size());
	}
}
