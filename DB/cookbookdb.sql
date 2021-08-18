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
  `role` VARCHAR(45) NULL,
  `enabled` TINYINT NULL DEFAULT 1,
  `date_created` DATETIME NULL,
  `image_url` VARCHAR(45) NULL,
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
  `recipe_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restrictions_recipe1_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_restrictions_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `star_rating` TINYINT NULL,
  `recipe_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_rating_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_rating_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`user_id`, `recipe_id`),
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
  `image_url` MEDIUMTEXT NULL,
  `date_created` DATETIME NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_recipe_img_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_recipe_image_user1_idx` (`user_id` ASC),
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (1, 'admin', NULL, 'admin@admintime.com', 'ADMIN', 1, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (2, 'user', 'user', 'user@usermail.com', 'USER', 1, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (3, 'frog', 'frog', 'frog@frogmail.com', 'FROG', 1, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (4, 'gorilla', 'gorilla', 'gorilla@gorilla.com', 'BANANA', 1, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `recipe_step`) VALUES (1, 'Spaghetti', 'And meatballs!', NULL, 1, NULL, NULL);
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `recipe_step`) VALUES (2, 'Pizza', 'with ONLY CHEESE', NULL, 1, NULL, NULL);
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `recipe_step`) VALUES (3, 'Ramen', 'SPICY', NULL, 2, NULL, NULL);
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `recipe_step`) VALUES (4, 'Gabagool', 'arrivederci', NULL, 3, NULL, NULL);
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `recipe_step`) VALUES (5, 'Birthday Cake', 'for the birthday', NULL, 4, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (1, 'Makin italian tonight!', 'spaghet', NULL, 1, 1, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (2, 'Went to OLIVE GARDEN', NULL, NULL, 1, NULL, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (3, 'HEllo', 'First post', NULL, 1, 2, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (4, 'Pizza time', NULL, NULL, 2, 1, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (5, 'Ramen is so great', NULL, NULL, 2, 4, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (6, 'Happy birthday!!!', NULL, NULL, 3, 5, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (7, NULL, NULL, NULL, 2, 3, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`) VALUES (8, NULL, NULL, NULL, 4, 5, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (1, 'you have a good opinion', NULL, 1, 1, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (2, 'you have a bad opinion', NULL, 1, 2, 1);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (3, 'i don\'t have any opinion', NULL, 1, 1, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (4, 'please die', NULL, 1, 3, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (5, 'wow, you are right', NULL, 2, 4, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (6, 'okay neat', NULL, 3, 3, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (7, 'stop it', NULL, 1, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `restriction`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (1, 'Gluten-Free', NULL, NULL);
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (2, 'Vegetarian', NULL, NULL);
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (3, 'Vegan', NULL, NULL);
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (4, 'Keto-friendly', NULL, NULL);
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (5, 'Diabetic', NULL, NULL);
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (6, 'Low Cholestrol ', NULL, NULL);
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (7, 'Nut-allergy', NULL, NULL);
INSERT INTO `restriction` (`id`, `name`, `description`, `recipe_id`) VALUES (8, 'Water-allergy', NULL, NULL);

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
INSERT INTO `rating` (`star_rating`, `recipe_id`, `user_id`) VALUES (5, 1, 1);
INSERT INTO `rating` (`star_rating`, `recipe_id`, `user_id`) VALUES (4, 1, 3);
INSERT INTO `rating` (`star_rating`, `recipe_id`, `user_id`) VALUES (3, 1, 2);
INSERT INTO `rating` (`star_rating`, `recipe_id`, `user_id`) VALUES (2, 2, 4);
INSERT INTO `rating` (`star_rating`, `recipe_id`, `user_id`) VALUES (1, 2, 1);

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
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (1, 1, 'THIS IS COOL!!!', 1, NULL, NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (2, 2, 'THIS SUCKS!!!', 2, NULL, NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (3, 1, 'Not bad. 10/10', 3, NULL, NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (4, 3, 'Gross.', 1, NULL, NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (5, 4, 'Nice!', 2, NULL, NULL);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (6, 5, 'Very GOOD', 3, NULL, 5);
INSERT INTO `recipe_comment` (`id`, `recipe_id`, `details`, `user_id`, `date_created`, `recipe_comment_reply_id`) VALUES (7, 2, 'YOU ARE WRONG!!!', 3, NULL, 2);

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
INSERT INTO `recipe_image` (`recipe_id`, `image_url`, `date_created`, `user_id`) VALUES (1, 'https://unsplash.com/photos/Ucwd8w-JHwM', NULL, 1);
INSERT INTO `recipe_image` (`recipe_id`, `image_url`, `date_created`, `user_id`) VALUES (2, 'https://unsplash.com/photos/MqT0asuoIcU', NULL, 2);
INSERT INTO `recipe_image` (`recipe_id`, `image_url`, `date_created`, `user_id`) VALUES (4, 'https://www.this-is-italy.com/wp-content/uploads/2019/12/Gabagool.jpg', NULL, 3);
INSERT INTO `recipe_image` (`recipe_id`, `image_url`, `date_created`, `user_id`) VALUES (3, 'https://unsplash.com/photos/WjdOYhgTGCM', NULL, 4);
INSERT INTO `recipe_image` (`recipe_id`, `image_url`, `date_created`, `user_id`) VALUES (5, 'https://unsplash.com/photos/d8s13D29QiE', NULL, 1);

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

COMMIT;

