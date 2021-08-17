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
  `user_id` INT NULL,
  `img_url` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  CONSTRAINT `fk_user_user1`
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
  `create_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe` ;

CREATE TABLE IF NOT EXISTS `recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rating` VARCHAR(45) NULL,
  `post_id` INT NOT NULL,
  `date_created` DATETIME NULL,
  `image_url` MEDIUMTEXT NULL,
  `user_id` INT NOT NULL,
  `description` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_post1_idx` (`post_id` ASC),
  INDEX `fk_recipe_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_recipe_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
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
-- Table `ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ingredient` ;

CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` INT NOT NULL,
  `ingredient_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
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
-- Table `user_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_recipe` ;

CREATE TABLE IF NOT EXISTS `user_recipe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rating` VARCHAR(45) NULL,
  `user_id` INT NULL,
  `recipe_id` INT NULL,
  `post_id` INT NULL,
  `description` MEDIUMTEXT NULL,
  `image_url` MEDIUMTEXT NULL,
  `recipe_has_categories_recipe_id` INT NOT NULL,
  `recipe_has_categories_categories_id` INT NOT NULL,
  `ingredients_has_recipe_ingredients_id` INT NOT NULL,
  `ingredients_has_recipe_recipe_id` INT NOT NULL,
  PRIMARY KEY (`id`, `recipe_has_categories_recipe_id`, `recipe_has_categories_categories_id`, `ingredients_has_recipe_ingredients_id`, `ingredients_has_recipe_recipe_id`),
  INDEX `fk_user_recipes_user1_idx` (`user_id` ASC),
  INDEX `fk_user_recipes_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_user_recipes_post1_idx` (`post_id` ASC),
  INDEX `fk_user_recipes_recipe_has_categories1_idx` (`recipe_has_categories_recipe_id` ASC, `recipe_has_categories_categories_id` ASC),
  INDEX `fk_user_recipes_ingredients_has_recipe1_idx` (`ingredients_has_recipe_ingredients_id` ASC, `ingredients_has_recipe_recipe_id` ASC),
  CONSTRAINT `fk_user_recipes_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_recipes_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_recipes_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_recipes_recipe_has_categories1`
    FOREIGN KEY (`recipe_has_categories_recipe_id` , `recipe_has_categories_categories_id`)
    REFERENCES `recipe_has_category` (`recipe_id` , `category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_recipes_ingredients_has_recipe1`
    FOREIGN KEY (`ingredients_has_recipe_ingredients_id` , `ingredients_has_recipe_recipe_id`)
    REFERENCES `ingredient_has_recipe` (`ingredient_id` , `recipe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL,
  `details` TEXT NULL,
  `create_date` DATETIME NULL,
  `post_id` INT NOT NULL,
  `recipe_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_post_idx` (`post_id` ASC),
  INDEX `fk_comments_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_comments_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comments_post`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restriction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restriction` ;

CREATE TABLE IF NOT EXISTS `restriction` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `alllergen` VARCHAR(45) NULL,
  `religious` VARCHAR(45) NULL,
  `recipe_id` INT NOT NULL,
  `user_recipe_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_restrictions_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_restrictions_user_recipes1_idx` (`user_recipe_id` ASC),
  CONSTRAINT `fk_restrictions_recipe1`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restrictions_user_recipes1`
    FOREIGN KEY (`user_recipe_id`)
    REFERENCES `user_recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `star_rating` TINYINT NULL,
  `recipe_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rating_recipe1_idx` (`recipe_id` ASC),
  INDEX `fk_rating_user1_idx` (`user_id` ASC),
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
-- Table `user_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_like` ;

CREATE TABLE IF NOT EXISTS `user_like` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `post_id` INT NULL,
  `comment_id` INT NULL,
  INDEX `fk_like_user1_idx` (`user_id` ASC),
  INDEX `fk_like_post1_idx` (`post_id` ASC),
  INDEX `fk_like_comments1_idx` (`comment_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_like_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_like_comments1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `comment` (`id`)
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `user_id`, `img_url`) VALUES (1, 'admin', NULL, '1', 'ADMIN', NULL, NULL, NULL, NULL);

COMMIT;

