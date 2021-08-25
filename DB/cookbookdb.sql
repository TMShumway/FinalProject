-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cookbookdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cookbookdb` ;

-- -----------------------------------------------------
-- Schema cookbookdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cookbookdb` DEFAULT CHARACTER SET utf8 ;
USE `cookbookdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NULL,
  `email` VARCHAR(100) NOT NULL,
  `role` VARCHAR(45) NULL DEFAULT 'Standard',
  `enabled` TINYINT NULL DEFAULT 1,
  `date_created` DATETIME NULL,
  `image_url` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe` ;

CREATE TABLE IF NOT EXISTS `recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` MEDIUMTEXT NULL,
  `date_created` DATETIME NULL,
  `user_id` INT NOT NULL,
  `published` TINYINT NULL,
  `personal` TINYINT NULL,
  `recipe_step` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post` ;

CREATE TABLE IF NOT EXISTS `post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `date_created` DATETIME NULL,
  `user_id` INT NOT NULL,
  `recipe_id` INT NULL,
  `image_url` MEDIUMTEXT NULL,
  `published` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  INDEX `fk_post_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post_comment` ;

CREATE TABLE IF NOT EXISTS `post_comment` (
  `id` INT NOT NULL,
  `details` TEXT NULL,
  `date_created` DATETIME NULL,
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `post_comment_reply_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_post_idx` (`post_id` ASC),
  INDEX `fk_comments_user1_idx` (`user_id` ASC),
  INDEX `fk_post_comment_post_comment1_idx` (`post_comment_reply_id` ASC),
  CONSTRAINT `fk_comments_post`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_comment_post_comment1`
    FOREIGN KEY (`post_comment_reply_id`)
    REFERENCES `post_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restriction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restriction` ;

CREATE TABLE IF NOT EXISTS `restriction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL,
  `category_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ingredient` ;

CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` INT NOT NULL,
  `ingredient_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_has_category` ;

CREATE TABLE IF NOT EXISTS `recipe_has_category` (
  `recipe_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`recipe_id`, `category_id`),
  INDEX `fk_recipe_has_categories_categories1_idx` (`category_id` ASC),
  INDEX `fk_recipe_has_categories_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_recipe_has_categories_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_has_categories_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ingredient_has_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ingredient_has_recipe` ;

CREATE TABLE IF NOT EXISTS `ingredient_has_recipe` (
  `ingredient_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`ingredient_id`, `recipe_id`),
  INDEX `fk_ingredients_has_recipe_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_ingredients_has_recipe_ingredients1_idx` (`ingredient_id` ASC),
  CONSTRAINT `fk_ingredients_has_recipe_ingredients1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredients_has_recipe_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `recipe_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `star_rating` TINYINT NULL,
  INDEX `fk_rating_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_rating_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`recipe_id`, `user_id`),
  CONSTRAINT `fk_rating_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post_comment_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post_comment_like` ;

CREATE TABLE IF NOT EXISTS `post_comment_like` (
  `user_id` INT NOT NULL,
  `post_comment_id` INT NOT NULL,
  INDEX `fk_like_user1_idx` (`user_id` ASC),
  INDEX `fk_like_comments1_idx` (`post_comment_id` ASC),
  PRIMARY KEY (`post_comment_id`, `user_id`),
  CONSTRAINT `fk_like_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_comments1`
    FOREIGN KEY (`post_comment_id`)
    REFERENCES `post_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_comment` ;

CREATE TABLE IF NOT EXISTS `recipe_comment` (
  `id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  `details` MEDIUMTEXT NULL,
  `user_id` INT NOT NULL,
  `date_created` DATETIME NULL,
  `recipe_comment_reply_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_comment_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_recipe_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_recipe_comment_recipe_comment1_idx` (`recipe_comment_reply_id` ASC),
  CONSTRAINT `fk_recipe_comment_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_comment_recipe_comment1`
    FOREIGN KEY (`recipe_comment_reply_id`)
    REFERENCES `recipe_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post_like` ;

CREATE TABLE IF NOT EXISTS `post_like` (
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_post_like_post1_idx` (`post_id` ASC),
  INDEX `fk_post_like_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`user_id`, `post_id`),
  CONSTRAINT `fk_post_like_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_like_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_comment_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_comment_like` ;

CREATE TABLE IF NOT EXISTS `recipe_comment_like` (
  `user_id` INT NOT NULL,
  `recipe_comment_id` INT NOT NULL,
  INDEX `fk_like_user1_idx` (`user_id` ASC),
  INDEX `fk_user_like_recipe_comment1_idx` (`recipe_comment_id` ASC),
  PRIMARY KEY (`recipe_comment_id`, `user_id`),
  CONSTRAINT `fk_like_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_like_recipe_comment10`
    FOREIGN KEY (`recipe_comment_id`)
    REFERENCES `recipe_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_image` ;

CREATE TABLE IF NOT EXISTS `recipe_image` (
  `recipe_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `image_url` MEDIUMTEXT NULL,
  `date_created` DATETIME NULL,
  INDEX `fk_recipe_img_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_recipe_image_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`recipe_id`, `user_id`),
  CONSTRAINT `fk_recipe_img_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_image_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_user` ;

CREATE TABLE IF NOT EXISTS `favorite_user` (
  `user_id` INT NOT NULL,
  `favorite_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `favorite_id`),
  INDEX `fk_user_has_user_user2_idx` (`favorite_id` ASC),
  INDEX `fk_user_has_user_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`favorite_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restriction_has_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restriction_has_recipe` ;

CREATE TABLE IF NOT EXISTS `restriction_has_recipe` (
  `restriction_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  PRIMARY KEY (`restriction_id`, `recipe_id`),
  INDEX `fk_restriction_has_recipe_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_restriction_has_recipe_restriction1_idx` (`restriction_id` ASC),
  CONSTRAINT `fk_restriction_has_recipe_restriction1`
    FOREIGN KEY (`restriction_id`)
    REFERENCES `restriction` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restriction_has_recipe_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS cookbookdb;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'cookbookdb' IDENTIFIED BY 'cookbook';

GRANT SELECT, INSERT, TRIGGER ON TABLE * TO 'cookbookdb';
SET SQL_MODE = '';
DROP USER IF EXISTS cookuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'cookuser'@'localhost' IDENTIFIED BY 'cookuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'cookuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (1, 'admin', '$2a$10$1YP2Iq4TE4bGpQ2mgZTGW.tptntXukJgcy3QzP73Fty1RzRateu0S', 'admin@admintime.com', 'ADMIN', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (2, 'user', '$2a$10$ApoO08F/FvYOcDbNLOiseeB84aHM5t2t81gE0MxGNLUfCJ1HdFKWG', 'user@usermail.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (3, 'frog', '$2a$10$Zn.dWCUX0lN8P8nSq/9pR.IsZxV/uLG7aHOycvZ0CNLQ1kJlK1r0S', 'frog@frogmail.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (4, 'gorilla', '$2a$10$WCEJ51E9FTO5ICDqbJiY.u06xg4gpQy/xc5DJPgsZIin.q1L0Obz.', 'gorilla@gorilla.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (5, 'bob', '$2a$10$f94xmW.KSbWFStTG60OemewIZJ8StNhLwgP1O/5CKiDTpGL1ehu1W', 'bob@bobmail.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (6, 'dog', '$2a$10$OqodcqQ4Of07oE6zb7jbFu.AVwqMx7xp9rALNFOV19ptJO1Zxm6wO', 'dog@dogmail.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (7, 'cat', '$2a$10$fEM8BBl7DoD8r/nqNiB.guay4g2fhAeCvNHH46dwIl7ZIqB5naFmy', 'cat@dogmail.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (8, 'monkey', '$2a$10$GfVjEDxcgpMoG.9d9mmIz.qMEm0wTYwePVnel5bphkiY0TvtCK.Aa', 'monkey@yahoo.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (9, 'tiger', '$2a$10$2yslWBqkIP1EUD2pfoX.KuQ6rm6dqEE1QMpXaNQlNKibB8cvnyNiG', 'tiger@tigersdirect.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://www.clipartmax.com/png/full/140-1401578_chef-with-hat-comments-cozinheiro-icon-png.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (1, 'Spaghetti', 'Easy weeknight friendly spaghetti and meat sauce that’s made completely from scratch', '2021-07-20T21:46:28', 1, 1, 0, 'MAKE SAUCE\nHeat the oil in a large pot over medium-high heat (we use a Dutch oven). Add the meat and cook until browned, about 8 minutes. As the meat cooks, use a wooden spoon to break it up into smaller crumbles.\n\nAdd the onions and cook, stirring every once and a while, until softened, about 5 minutes.\n\nStir in the garlic, tomato paste, oregano, and red pepper flakes and cook, stirring continuously for about 1 minute.\n\nPour in the water and use a wooden spoon to scrape up any bits of meat or onion stuck to the bottom of the pot. Stir in the tomatoes, 3/4 teaspoon of salt, and a generous pinch of black pepper. Bring the sauce to a low simmer. Cook, uncovered, at a low simmer for 25 minutes. As it cooks, stir and taste the sauce a few times so you can adjust the seasoning accordingly (see notes for suggestions).\n\nCOOK SPAGHETTI\nAbout 15 minutes before the sauce is finished cooking, bring a large pot of salted water to the boil then cook pasta according to package directions, but check for doneness a minute or two before the suggested cooking time.\n\nTO FINISH\nTake the sauce off of the heat, and then stir in the basil. Toss in the cooked pasta, and then leave for a minute so that the pasta absorbs some of the sauce. Toss again, and then serve with parmesan sprinkled on top');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (2, 'Pizza', 'This easy pizza dough recipe is great for beginners and produces a soft homemade pizza crust. Skip the pizza delivery because you only need 6 basic ingredients to begin!', '2021-07-20T21:46:28', 1, 1, 0, '1. Preheat the oven to 450');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (3, 'Ramen', 'EXTRA SPICY', '2021-07-20T21:46:28', 2, 1, 0, '1. Boil water');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (4, 'Gabagool', 'arrivederci', '2021-07-20T21:46:28', 3, 1, 0, '1. Go to the store');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (5, 'Birthday Cake', 'for the birthday', '2021-07-20T21:46:28', 4, 1, 0, '1. Preheat the oven to 350');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (6, 'Chicken Alfredo', 'Homemade alfredo on a weeknight? Yes! ', '2021-07-20T21:46:28', 2, 0, 1, 'Boil a pot of water:\nPut a large pot of water on the stove and bring to a boil. Salt liberally.\n\nStart the sauce:\nAdd the butter, cream, salt, black pepper, and nutmeg to small or medium-sized sauce pan. Heat over medium-low heat until the butter melts and the mixture comes to a slight simmer. Then turn heat down to low and simmer the sauce, stirring regularly to prevent scalding, until the sauce thickens slightly, enough to coat the back of a spoon easily.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (7, 'Apple Pie', 'Grandma\'s recipe', '2021-07-20T21:46:28', 6, 0, 1, '\nHeat oven to 425°F. Place 1 pie crust in ungreased 9-inch glass pie plate. Press firmly against side and bottom.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (8, 'Thai Curry', 'Hits the spot', '2021-07-20T21:46:28', 6, 1, 0, 'Take out a large skillet and add to it the chicken, peppers, and onions. Drizzle with oil and turn the burner up to medium high heat. Stir everything around and cook for 6-8 minutes, cooking chicken just through. \n');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (9, 'Fried Tofu', 'Best air-fried', '2021-07-20T21:46:28', 6, 1, 1, 'Place two paper towels on a plate then place the entire block of tofu (drained from its packaging liquid) onto the plate. Place two more paper towels on top of the tofu then put a heavy item on top. Not TOO heavy that it would completely crush the tofu but heavy enough that it can squeeze out liquid.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (10, 'Guacamole', 'Dippin advised', '2021-07-20T21:46:28', 6, 1, 0, 'In a medium bowl, mash together the avocados, lime juice, and salt. Mix in onion, cilantro, tomatoes, and garlic. Stir in cayenne pepper. Refrigerate 1 hour for best flavor, or serve immediately.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (11, 'Burrito', 'Chipotle secret', '2021-07-20T21:46:28', 1, 1, 0, 'Make the Marinade: Place the onion, garlic, adobo sauce, olive oil, chile powder, cumin, oregano, salt, and pepper into a food processor or blender and process until smooth. Pour the marinade into a 1-cup measuring cup and add enough water to reach to 1 cup.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (1, 'Making italian tonight!', 'spaghetti time', NULL, 6, NULL, 'https://images.unsplash.com/photo-1609582848349-215e8bf397d3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (2, 'Went to OLIVE GARDEN', 'IT WAS AWFUL. I\'ll make my own alfredo next time', NULL, 1, NULL, NULL, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (3, 'Hello All!', 'First post', NULL, 1, 2, NULL, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (4, 'Pizza time', 'makin da pizza-pie', NULL, 2, 1, 'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1225&q=80', NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (5, 'Ramen is so great', 'I tried out this recipe and it was awesome!', NULL, 6, 3, 'https://images.unsplash.com/photo-1526318896980-cf78c088247c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFtZW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (6, 'Happy birthday!!!', 'This was an awesome recipe. They loved it!', NULL, 3, 5, 'https://images.unsplash.com/photo-1455732063391-5f50f4df1854?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1350&q=80', NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (7, 'This website is great!', 'can\'t wait to try it all', NULL, 6, 3, 'https://pbs.twimg.com/media/DmR3LlsU4AAj7Ls.jpg', NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (8, 'This is my post!', 'STAY AWAY', NULL, 6, 5, NULL, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (9, 'I LOVE CHIPOTLE', 'perfect', NULL, 1, 11, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (1, 'you have a good opinion', '2021-07-20T21:46:28', 1, 1, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (2, 'you have a bad opinion', '2021-07-20T21:46:28', 1, 2, 1);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (3, 'i don\'t have any opinion', '2021-07-20T21:46:28', 1, 1, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (4, 'please die', '2021-07-20T21:46:28', 1, 3, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (5, 'wow, you are right', '2021-07-20T21:46:28', 2, 4, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (6, 'okay neat', '2021-07-20T21:46:28', 3, 3, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (7, 'stop it', '2021-07-20T21:46:28', 1, 1, 2);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (8, 'NO.', '2021-07-20T21:46:28', 1, 3, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restriction`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (1, 'Gluten-Free', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (2, 'Vegetarian', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (3, 'Vegan', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (4, 'Keto-friendly', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (5, 'Diabetic', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (6, 'Low Cholestrol ', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (7, 'Nut-allergy', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (8, 'Water-allergy', NULL);
INSERT INTO `restriction` (`id`, `name`, `description`) VALUES (9, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `category` (`id`, `category_name`) VALUES (1, 'Seafood');
INSERT INTO `category` (`id`, `category_name`) VALUES (2, 'Pasta');
INSERT INTO `category` (`id`, `category_name`) VALUES (3, 'Breakfast');
INSERT INTO `category` (`id`, `category_name`) VALUES (4, 'Soup');
INSERT INTO `category` (`id`, `category_name`) VALUES (5, 'Dinner');
INSERT INTO `category` (`id`, `category_name`) VALUES (6, 'Lunch');
INSERT INTO `category` (`id`, `category_name`) VALUES (7, 'BBQ');
INSERT INTO `category` (`id`, `category_name`) VALUES (8, 'Drinks');
INSERT INTO `category` (`id`, `category_name`) VALUES (9, 'Dessert');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (1, 'eggs');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (2, 'milk');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (3, 'butter');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (4, 'cheese');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (5, 'chicken');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (6, 'beef');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (7, 'spinach');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (8, 'sugar');
INSERT INTO `ingredient` (`id`, `ingredient_name`) VALUES (9, 'tofu');

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_has_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (1, 1);
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (1, 2);
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (1, 3);
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (1, 4);
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (2, 6);
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (3, 1);
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (3, 7);
INSERT INTO `recipe_has_category` (`recipe_id`, `category_id`) VALUES (5, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ingredient_has_recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (2, 5);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (2, 2);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (1, 5);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (1, 2);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (5, 3);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (6, 3);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (7, 3);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (4, 1);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (2, 1);
INSERT INTO `ingredient_has_recipe` (`ingredient_id`, `recipe_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (1, 1, 5);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (1, 3, 4);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (1, 2, 3);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (2, 4, 2);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (2, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post_comment_like`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (1, 1);
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (1, 2);
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (1, 3);
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (2, 1);
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (2, 3);
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (2, 2);
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (3, 1);
INSERT INTO `post_comment_like` (`user_id`, `post_comment_id`) VALUES (4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (1, 1, 'THIS IS COOL!!!', 1, '2021-07-20T21:46:28', NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (2, 2, 'THIS SUCKS!!!', 2, '2021-07-20T21:46:28', NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (3, 1, 'Not bad. 10/10', 3, '2021-07-20T21:46:28', NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (4, 3, 'Gross.', 1, '2021-07-20T21:46:28', NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (5, 4, 'Nice!', 2, '2021-07-20T21:46:28', NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (6, 5, 'Very GOOD', 3, '2021-07-20T21:46:28', 5);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (7, 2, 'YOU ARE WRONG!!!', 3, '2021-07-20T21:46:28', 2);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (8, 1, 'Reply 1', 1, '2021-07-20T21:46:28', 1);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (9, 1, 'reply 2!!', 5, '2021-07-20T21:46:28', 8);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (10, 1, 'Shut up!', 6, '2021-07-20T21:46:28', 9);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (11, 1, 'Nice!', 7, '2021-07-20T21:46:28', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post_like`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (1, 1);
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (2, 1);
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (1, 2);
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (1, 3);
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (2, 4);
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (3, 3);
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (3, 4);
INSERT INTO `post_like` (`post_id`, `user_id`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_comment_like`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `recipe_comment_like` (`user_id`, `recipe_comment_id`) VALUES (1, 1);
INSERT INTO `recipe_comment_like` (`user_id`, `recipe_comment_id`) VALUES (1, 2);
INSERT INTO `recipe_comment_like` (`user_id`, `recipe_comment_id`) VALUES (1, 3);
INSERT INTO `recipe_comment_like` (`user_id`, `recipe_comment_id`) VALUES (2, 2);
INSERT INTO `recipe_comment_like` (`user_id`, `recipe_comment_id`) VALUES (2, 3);
INSERT INTO `recipe_comment_like` (`user_id`, `recipe_comment_id`) VALUES (1, 4);
INSERT INTO `recipe_comment_like` (`user_id`, `recipe_comment_id`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (1, 1, 'https://images.unsplash.com/photo-1589227365533-cee630bd59bd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (2, 2, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=714&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (4, 3, 'https://www.this-is-italy.com/wp-content/uploads/2019/12/Gabagool.jpg', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (3, 4, 'https://images.unsplash.com/photo-1618889482923-38250401a84e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1350&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (5, 1, 'https://images.unsplash.com/photo-1545696563-af8f6ec2295a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1264&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (8, 6, 'https://www.thespruceeats.com/thmb/d0UnpGxaVl1EyG-5_w3lVQLnYtY=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/thai-red-curry-with-chicken-recipe-3217262-hero-01-1099358354ca43b89d2c7cc3409a079b.jpg', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (9, 6, 'https://www.tablefortwoblog.com/wp-content/uploads/2018/09/pan-fried-spicy-garlic-tofu-recipe-photos-tablefortwoblog-4.jpg.webp', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (10, 6, 'https://images.unsplash.com/photo-1600728256404-aaa448921ad9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3VhY2Ftb2xlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (6, 6, 'https://images.unsplash.com/photo-1546549032-9571cd6b27df?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1234&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (7, 6, 'https://images.unsplash.com/photo-1572383672419-ab35444a6934?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (11, 1, 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/copycat-chipotle-chicken-horizontal-1531452615.jpg?crop=1xw:1xh;center,top&resize=768:*', '2021-07-20T21:46:28');

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (1, 2);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (2, 1);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (3, 4);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (4, 2);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (5, 3);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (6, 4);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (7, 5);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (1, 3);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (1, 4);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (1, 5);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (1, 6);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (2, 3);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (2, 4);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (2, 5);
INSERT INTO `favorite_user` (`user_id`, `favorite_id`) VALUES (2, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restriction_has_recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `restriction_has_recipe` (`restriction_id`, `recipe_id`) VALUES (1, 1);
INSERT INTO `restriction_has_recipe` (`restriction_id`, `recipe_id`) VALUES (2, 2);
INSERT INTO `restriction_has_recipe` (`restriction_id`, `recipe_id`) VALUES (3, 3);
INSERT INTO `restriction_has_recipe` (`restriction_id`, `recipe_id`) VALUES (3, 4);
INSERT INTO `restriction_has_recipe` (`restriction_id`, `recipe_id`) VALUES (4, 5);
INSERT INTO `restriction_has_recipe` (`restriction_id`, `recipe_id`) VALUES (8, 5);

COMMIT;

