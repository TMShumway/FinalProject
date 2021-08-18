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

class PostCommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private PostComment PostComment;
	
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
		PostComment = em.find(PostComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		PostComment = null;
	}
	
	@Test
	void test() {
//		| id | details                 | date_created | post_id | user_id | post_comment_reply_id |
//		+----+-------------------------+--------------+---------+---------+-----------------------+
//		|  1 | you have a good opinion | NULL         |       1 |       1 |                  NULL |
		assertNotNull(PostComment);
		assertEquals("you have a good opinion", PostComment.getDetails());
		assertEquals(1, PostComment.getId());
		assertNull(PostComment.getDateCreated());
		
	}


}
