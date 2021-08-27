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
  `published` TINYINT NULL DEFAULT 1,
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
  `id` INT NOT NULL AUTO_INCREMENT,
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
  `id` INT NOT NULL AUTO_INCREMENT,
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `enabled`, `date_created`, `image_url`) VALUES (10, 'Sam25', '$2a$10$14nbBeWuJKdz7VHakEEp9.5CVAl0GEAZpAXogQQL.VOTUkT.nltPS', 'Sam25@gmail.com', 'Standard', 1, '2021-07-20T21:46:28', 'https://i.ibb.co/M251D2D/louis-hansel-v3-Ol-BE6-fh-U-unsplash.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (1, 'Mom’s Homemade Spaghetti', 'Easy weeknight friendly spaghetti and meat sauce that’s made completely from scratch', '2021-07-20T21:46:28', 1, 1, 0, 'In a large heavy bottomed stock pot over medium high heat, cook the ground beef until browned, about 5-7 minutes, stirring occasionally. Drain the rendered fat and add the meat back to the pot.\nAdd the chopped onion, celery and garlic and cook until the vegetables soften, about 5-7 more minutes.\nAdd the rest of the ingredients (except the spaghtti noodles and Parmesan), stir, and bring to a boil. Reduce the heat to simmer, stir and cover with a lid, and cook for at least three hours on medium low heat, stirring occasionally.\nCook the spaghetti according to the package directions in generously salted water. Drain and mix into the spaghetti sauce.\nServe with grated or ground Parmesan cheese and chopped fresh parsley if desired.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (2, 'Pizza', 'This easy pizza dough recipe is great for beginners and produces a soft homemade pizza crust. Skip the pizza delivery because you only need 6 basic ingredients to begin!', '2021-07-20T21:46:28', 1, 1, 0, 'In large bowl, dissolve yeast and sugar in water; let stand for 5 minutes. Add oil and salt. Stir in flour, 1 cup at a time, until a soft dough forms.\nTurn onto a floured surface; knead until smooth and elastic, 2-3 minutes. Place in a greased bowl, turning once to grease the top. Cover and let rise in a warm place until doubled, about 45 minutes. Meanwhile, cook beef and onion over medium heat until beef is no longer pink, breaking meat into crumbles; drain.\nPunch down dough; divide in half. Press each half into a greased 12-in. pizza pan. Combine the tomato sauce, oregano and basil; spread over each crust. Top with beef mixture, green pepper and cheese.\nBake at 400° for 25-30 minutes or until crust is lightly browned.\n');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (3, 'Ramen', 'Fresh vegetables? Quick and easy homemade broth? A soft-boiled egg and a pile of our favorite curly-cue packaged ramen noodles that remind us of college? That’s this homemade ramen.', '2021-07-20T21:46:28', 2, 1, 0, 'Place eggs in a large saucepan and cover with cold water by 1 inch. Bring to a boil and cook for 1 minute. Cover eggs with a tight-fitting lid and remove from heat; set aside for 8-10 minutes. Drain well and let cool before peeling and halving.\nHeat olive oil in a large stockpot or Dutch oven over medium heat. Add garlic and ginger, and cook, stirring frequently, until fragrant, about 1-2 minutes.\nWhisk in chicken broth, mushrooms, soy sauce and 3 cups water.\nBring to a boil; reduce heat and simmer until mushrooms have softened, about 10 minutes. Stir in Yaki-Soba until loosened and cooked through, about 2-3 minutes.\nStir in spinach, Narutomaki, carrot and chives until the spinach begins to wilt, about 2 minutes.\nServe immediately, garnished with eggs.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (4, 'Gabagool', 'Succulent, superbly seasoned and flavorful, this baked version of Capicola will take your Italian subs, sandwiches, pizza and snacking to a new level!\n\n', '2021-07-20T21:46:28', 3, 1, 0, 'Preheat the oven to 250 degrees F.  Fill a pan up with water and place it on the middle rack of the oven.  This will create humidity as the coppa cooks to keep the coppa moist.  Place the coppa on a roasting pan fitted with a wire rack and place the pan on the top rack of the oven.  Cook the coppa for 1 hour, then turn the coppa over so the bottom side is up and bake it for another hour or until the internal temperature reaches 145-150 degrees F.  Don’t overcook or the meat will be dry.\n\nBE PATIENT, IT’S NOT READY TO EAT YET!  Remove the coppa, place it on a plate and refrigerate uncovered for 4 hours.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (5, 'Birthday Cake', 'With its outstanding vanilla flavor, pillowy soft crumb, and creamy vanilla buttercream, this is truly the best vanilla cake I’ve ever had.', '2021-07-20T21:46:28', 4, 1, 0, 'Preheat oven to 350°F (177°C). Grease three 9-inch cake pans, line with parchment paper, then grease the parchment paper. Parchment paper helps the cakes seamlessly release from the pans.\nMake the cake: Whisk the cake flour, salt, baking powder, and baking soda together. Set aside.\nUsing a handheld or stand mixer fitted with a paddle or whisk attachment, beat the butter and sugar together on high speed until smooth and creamy, about 3 minutes. Scrape down the sides and up the bottom of the bowl with a rubber spatula as needed. Beat in the 3 eggs, 2 egg whites, and vanilla extract on high speed until combined, about 2 minutes. (Mixture will look curdled as a result of the egg liquid and solid butter combining.) Scrape down the sides and up the bottom of the bowl as needed. With the mixer on low speed, add the dry ingredients just until combined. With the mixer still running on low, pour in the buttermilk and mix just until combined. You may need to whisk it all by hand to make sure there are no lumps at the bottom of the bowl. The batter will be slightly thick.\nPour batter evenly into cake pans. Weigh them to ensure accuracy, if desired. Bake for around 23-26 minutes or until the cakes are baked through. To test for doneness, insert a toothpick into the center of the cake. If it comes out clean, it’s done. Allow cakes to cool completely in the pans set on a wire rack. The cakes must be completely cool before frosting and assembling.\nMake the frosting: In a large bowl using a hand-held mixer or stand mixer fitted with a whisk or paddle attachment, beat the butter on medium speed until creamy, about 2 minutes. Add confectioners’ sugar, milk, vanilla extract, and salt with the mixer running on low. Increase to high speed and beat for 2 minutes. Add more confectioners’ sugar if frosting is too thin, more milk if frosting is too thick, or an extra pinch of salt if frosting is too sweet.\nAssemble and decorate: Using a large serrated knife, slice a thin layer off the tops of the cakes to create a flat surface. Discard (or crumble over ice cream!). Place 1 cake layer on your cake stand, cake turntable, or serving plate. Evenly cover the top with about 1 and 1/2 cups of frosting. Top with 2nd cake layer and evenly cover the top with about 1 and 1/2 cups of frosting. Top with the third cake layer. Spread the remaining frosting all over the top and sides. I use and recommend an icing spatula to apply the frosting.\nRefrigerate cake for at least 1 hour before slicing. This helps the cake hold its shape when cutting.\nCover leftover cake tightly and store in the refrigerator for up to 5 days.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (6, 'Chicken Alfredo', 'Homemade alfredo on a weeknight? Yes! ', '2021-07-20T21:46:28', 2, 0, 1, 'Boil a pot of water:\nPut a large pot of water on the stove and bring to a boil. Salt liberally.\n\nStart the sauce:\nAdd the butter, cream, salt, black pepper, and nutmeg to small or medium-sized sauce pan. Heat over medium-low heat until the butter melts and the mixture comes to a slight simmer. Then turn heat down to low and simmer the sauce, stirring regularly to prevent scalding, until the sauce thickens slightly, enough to coat the back of a spoon easily.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (7, 'Apple Pie', 'Grandma\'s secret recipe', '2021-07-20T21:46:28', 6, 0, 1, '\nHeat oven to 425°F. Place 1 pie crust in ungreased 9-inch glass pie plate. Press firmly against side and bottom.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (8, 'Thai Curry', 'Hits the spot', '2021-07-20T21:46:28', 6, 1, 0, 'Take out a large skillet and add to it the chicken, peppers, and onions. Drizzle with oil and turn the burner up to medium high heat. Stir everything around and cook for 6-8 minutes, cooking chicken just through. \n');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (9, 'Fried Tofu', 'Best air-fried', '2021-07-20T21:46:28', 6, 1, 0, 'Place two paper towels on a plate then place the entire block of tofu (drained from its packaging liquid) onto the plate. Place two more paper towels on top of the tofu then put a heavy item on top. Not TOO heavy that it would completely crush the tofu but heavy enough that it can squeeze out liquid.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (10, 'Guacamole', 'Dipping advised', '2021-07-20T21:46:28', 6, 1, 0, 'In a medium bowl, mash together the avocados, lime juice, and salt. Mix in onion, cilantro, tomatoes, and garlic. Stir in cayenne pepper. Refrigerate 1 hour for best flavor, or serve immediately.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (11, 'Burrito Bowl', 'Chipotle secret', '2021-07-20T21:46:28', 1, 1, 0, 'Make the Marinade: Place the onion, garlic, adobo sauce, olive oil, chile powder, cumin, oregano, salt, and pepper into a food processor or blender and process until smooth. Pour the marinade into a 1-cup measuring cup and add enough water to reach to 1 cup.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (12, 'Fried Chicken', 'If you want a crazy delicious chicken recipe, then it has to be this recipe for The Best Southern Fried Chicken. Crispy, flavorful and absolutely divine!', '2021-07-20T21:46:28', 6, 1, 0, 'Place the chicken in a large bowl. Sprinkle on top of the chicken: 2 teaspoon salt, garlic powder, and onion powder then toss to coat the chicken in the spices.\nAdd the buttermilk and hot sauce to bowl, stir until everything is combined. Cover with plastic wrap and let marinate in the fridge for at least 2 hours, but it’s best if you can let it sit overnight.\nIn a medium-sized bowl, whisk together the flour, cornstarch, 2 teaspoon salt and black pepper. Set aside.\nFill up a deep fryer (deep cast iron skillet or dutch oven) with peanut oil (or neutral frying oil of your choice) and preheat to 350°F.\nTaking the chicken pieces one at a time, let the excess buttermilk drip off. Coat in the flour mixture, make sure the chicken is well coated. Shake off any excess.\nCarefully add the piece of chicken to the deep fryer and continue with the next piece. Don\'t add more than three or four pieces at at time. You will need to fry in batches so you do not overcrowd the fryer. Fry until golden brown, turning every few minutes.\nChicken is done when golden brown and the internal temperature reaches 165°F. Depending on the size of the chicken, dark meat can take about 12-14 minutes and white meat takes 8-10 minutes (these are estimates - use a meat thermometer for accurate doneness)\nWhen the chicken is done frying, place it on a paper towel lined sheet tray and immediately sprinkle a little flaked salt on top. Continue with the rest of the chicken pieces.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (13, 'Mac and Cheese', 'This baked mac and cheese is a family favorite recipe', '2021-07-20T21:46:28', 6, 1, 0, 'Preheat oven to 325 degrees F and grease a 3 qt baking dish (9x13\").  Set aside.\nBring a large pot of salted water to a boil.  When boiling, add dried pasta and cook 1 minute less than the package directs for al dente.  Drain and drizzle with a little bit of olive oil to keep from sticking.\nWhile water is coming up to a boil, grate cheeses and toss together to mix, then divide into three piles.  Approximately 3 cups for the sauce, 1 1/2 cups for the inner layer, and 1 1/2 cups for the topping.\nMelt butter in a large saucepan over MED heat.  Sprinkle in flour and whisk to combine.  Mixture will look like very wet sand.  Cook for approximately 1 minute, whisking often.  Slowly pour in about 2 cups or so of the milk/half and half, while whisking constantly, until smooth.  Slowly pour in the remaining milk/half and half, while whisking constantly, until combined and smooth.\nContinue to heat over MED heat, whisking very often, until thickened to a very thick consistency.  It should almost be the consistency of a semi thinned out condensed soup.\nRemove from the heat and stir in spices and 1 1/2 cups of the cheeses, stirring to melt and combine.  Stir in another 1 1/2 cups of cheese, and stir until completely melted and smooth.\nIn a large mixing bowl, combine drained pasta with cheese sauce, stirring to combine fully.  Pour half of the pasta mixture into the prepared baking dish.  Top with 1 1/2 cups of grated cheeses, then top that with the remaining pasta mixture.\nSprinkle the top with the last 1 1/2 cups of cheese and bake for 15 minutes, until cheesy is bubbly and lightly golden brown.  ');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (14, 'Burger', 'Thick or thin, made on the grill or stovetop, this is the best and easiest all-purpose recipe for perfect hamburger patties every time! ', '2021-07-20T21:46:28', 8, 1, 0, 'Set out a large mixing bowl. Add in the ground beef, crushed crackers, egg, Worcestershire sauce, milk, salt, garlic powder, onion powder, and pepper. Mix by hand until the meat mixture is very smooth.\nPress the meat down in the bowl, into an even disk. Use a knife to cut and divide the hamburger patty mixture into 6 – 1/3 pound grill or skillet patties, or 12 thin griddle patties.\nSet out a baking sheet, lined with wax paper or foil, to hold the patties. One at a time, gather the patty mix and press firmly into patties. Shape them just slightly larger than the buns you plan to use, to account for shrinkage during cooking. Set the patties on the baking sheet. Use a spoon to press a dent in the center of each patty so they don\'t puff up as they cook. If you need to stack the patties separate them with a sheet of wax paper.\nPreheat the grill or a skillet to medium heat. (Approximately 350-400 degrees F.)\nFor thick patties: Grill or fry the patties for 3-4 minutes per side.\nFor thin patties: Cook on the griddle for 2 minutes per side.\nStack the hot patties on hamburgers buns, and top with your favorite hamburgers toppings. Serve warm.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (15, 'Yellow Curry', 'Better-than-takeout yellow curry is EASY and ready in 25 minutes!!', '2021-07-20T21:46:28', 9, 1, 0, 'To a large skillet, add the oil, onion, and sauté over medium-high heat until the onion begins to soften about 5 minutes; stir intermittently.\nAdd the chicken and cook for about 5 minutes, or until chicken is done; flip and stir often to ensure even cooking.\nAdd the garlic, turmeric, ginger, coriander, and cook for about 1 minute, or until fragrant; stir frequently.\nAdd the curry paste, coconut milk, carrots, and stir to combine. Reduce the heat to medium, and allow mixture to gently boil for about 5 minutes, or until liquid volume has reduced as much as desired and thickens slightly.\nAdd the spinach, pepper, and stir until the spinach has wilted.\nTaste the curry and add the optional but recommended lime juice (brightens the flavor of the dish), cilantro, optional light brown sugar (balances the heat), optional salt (I did not add any because the curry paste has salt in it), and add extra of any of the spices already used or more curry paste, if desired and to taste.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (16, 'Homemade Poptarts', 'These homemade strawberry pop tarts made with strawberry preserves and flaky pastry are so much better than store-bought!', '2021-07-20T21:46:28', 5, 1, 0, 'Combine the flour, salt, and sugar in a bowl. Add the cubed butter and cut into the dry ingredients with a pastry cutter, fork, or your fingers. Continue until the mixture resembles coarse sand and the butter is the size of small peas. Add the cold water a tablespoon at a time, mixing until the dough comes together into a ball. Divide into two and form each into a disk. Wrap in plastic wrap and chill in the fridge for at least 30 minutes.\nMeanwhile, prepare the preserves if making from scratch. Preheat oven to 375°F.\nRemove one disk of dough and place on a lightly floured surface. Roll out into a large rectangle about to about 1/8th inch thick. Trim so edges are straight. Cut into 8 5x3-inch rectangles. Repeat with second disk. Gather trimmed dough scraps together and re-roll as needed.\nSpoon 1 1/2 tablespoons of the preserves onto the pastry squares and cover with the remaining pastry squares. Press all edges together with your fingers to seal, then use a fork to double seal. Use a toothpick to poke holes in the tops of the pastries. Place on sheet pans lined with parchment paper or silicone baking mats.\nBake the pop tarts until golden, about 25-30 minutes.\nCool completely on a wire rack.\nTo make the frosting, whisk together powdered sugar and heavy cream to make a thick but pour-able consistency. To make the frosting pink, add a spoonful of remaining strawberry preserves.\nSpread over cooled pop tarts and sprinkle with rainbow sprinkles. Frosting should set up in about 20 minutes, or more quickly if chilled in the fridge.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (17, 'Simple Sushi', 'This Easy Vegan Sushi recipe is perfect for beginners, is made with simple ingredients and tastes SO so good. You’re going to find yourself craving this recipe ALL of the time.', '2021-07-20T21:46:28', 7, 1, 0, 'Cook your rice according to package instructions. Once done, place in a large bowl in the fridge to cool down.\nMake the sauce by whisking together the soy sauce, maple syrup, cornstarch, ginger, garlic, and water. Set aside.\nIn a large non-stick skillet, heat 1 tablespoon of oil over medium heat. Once hot, add in the tofu and saute for 5 minutes untouched. Once it has formed a nice crust, flip and cook for a few more minutes on each side, about 12 minutes total. Add in the sauce and cook for a few more minutes, tossing often, so that the sauce can thicken. Stir to ensure the tofu is evenly coated in the sauce. Remove from heat and set aside.\nOnce rice is cooled down, mix in the rice vinegar and white wine vinegar and set aside.\nAssemble the sushi by placing a nori sheet on a sushi mat*. Spread 2/3 cup of the cooked rice over the nori sheet, leaving about 2/3 of an inch clean on one end (see video).  Top with some of the cucumber, 2 pieces of the tofu, carrots, and 2 slices of avocado. Roll the nori sheet over top of the fillings and continue to gently and *tightly* roll the sheet until it’s all the way rolled up. Repeat will the remaining ingredients (I end up with 5-6 rolls depending on how I filled them).\nSlice into 1 inch pieces and ENJOY! I LOVE mine with a little sliced ginger and a touch of soy sauce.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (18, 'Fried Tofu', 'Best air-fried', '2021-07-20T21:46:28', 10, 1, 1, 'Place two paper towels on a plate then place the entire block of tofu (drained from its packaging liquid) onto the plate. Place two more paper towels on top of the tofu then put a heavy item on top. Not TOO heavy that it would completely crush the tofu but heavy enough that it can squeeze out liquid.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (19, 'Burrito Bowl', 'Chipotle secret', '2021-07-20T21:46:28', 10, 1, 1, 'Make the Marinade: Place the onion, garlic, adobo sauce, olive oil, chile powder, cumin, oregano, salt, and pepper into a food processor or blender and process until smooth. Pour the marinade into a 1-cup measuring cup and add enough water to reach to 1 cup.');
INSERT INTO `recipe` (`id`, `name`, `description`, `date_created`, `user_id`, `published`, `personal`, `recipe_step`) VALUES (20, 'Pizza', 'This easy pizza dough recipe is great for beginners and produces a soft homemade pizza crust. Skip the pizza delivery because you only need 6 basic ingredients to begin!', '2021-07-20T21:46:28', 10, 1, 1, 'In large bowl, dissolve yeast and sugar in water; let stand for 5 minutes. Add oil and salt. Stir in flour, 1 cup at a time, until a soft dough forms.\nTurn onto a floured surface; knead until smooth and elastic, 2-3 minutes. Place in a greased bowl, turning once to grease the top. Cover and let rise in a warm place until doubled, about 45 minutes. Meanwhile, cook beef and onion over medium heat until beef is no longer pink, breaking meat into crumbles; drain.\nPunch down dough; divide in half. Press each half into a greased 12-in. pizza pan. Combine the tomato sauce, oregano and basil; spread over each crust. Top with beef mixture, green pepper and cheese.\nBake at 400° for 25-30 minutes or until crust is lightly browned.\n');

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (1, 'Making italian tonight!', 'Spaghetti time!', NULL, 6, NULL, 'https://images.unsplash.com/photo-1609582848349-215e8bf397d3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (2, 'Went to OLIVE GARDEN', 'IT WAS AWFUL. I\'ll make my own alfredo next time', NULL, 1, NULL, NULL, 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (3, 'Hello All!', 'First post', NULL, 1, 2, NULL, 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (4, 'Pizza time', 'preheating the oven right now!', NULL, 2, 1, 'https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1225&q=80', 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (5, 'Ramen is so great', 'I tried out this recipe and it was awesome!', NULL, 6, 3, 'https://images.unsplash.com/photo-1526318896980-cf78c088247c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFtZW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (6, 'Happy birthday!!!', 'This was an awesome recipe. They loved it!', NULL, 3, 5, 'https://images.unsplash.com/photo-1455732063391-5f50f4df1854?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1350&q=80', 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (7, 'This website is great!', 'can\'t wait to try it all', NULL, 10, 3, 'https://pbs.twimg.com/media/DmR3LlsU4AAj7Ls.jpg', 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (8, 'This is my post!', 'Leave a comment!', NULL, 10, 5, NULL, 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (9, 'I LOVE CHIPOTLE', 'I found a great burrito recipe', NULL, 1, 11, NULL, 1);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (10, 'Gonna make some ramen tonight', 'Hopefully I don\'t burn anything', NULL, 10, NULL, NULL, NULL);
INSERT INTO `post` (`id`, `title`, `description`, `date_created`, `user_id`, `recipe_id`, `image_url`, `published`) VALUES (11, 'That poptart recipe looks pretty good...', NULL, NULL, 10, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `cookbookdb`;
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (1, 'you have a good opinion', '2021-07-20T21:46:28', 1, 1, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (2, 'you have a bad opinion', '2021-07-20T21:46:28', 1, 2, 1);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (3, 'i don\'t have any opinion', '2021-07-20T21:46:28', 1, 1, NULL);
INSERT INTO `post_comment` (`id`, `details`, `date_created`, `post_id`, `user_id`, `post_comment_reply_id`) VALUES (4, '', '2021-07-20T21:46:28', 1, 3, NULL);
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
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (3, 3, 5);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (4, 4, 5);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (5, 5, 4);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (6, 6, 3);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (7, 7, 2);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (12, 8, 2);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (13, 9, 5);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (14, 1, 4);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (15, 2, 3);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (16, 3, 3);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (17, 4, 4);
INSERT INTO `rating` (`recipe_id`, `user_id`, `star_rating`) VALUES (10, 10, 4);

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
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (9, 10, 'https://www.tablefortwoblog.com/wp-content/uploads/2018/09/pan-fried-spicy-garlic-tofu-recipe-photos-tablefortwoblog-4.jpg.webp', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (10, 10, 'https://images.unsplash.com/photo-1600728256404-aaa448921ad9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3VhY2Ftb2xlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (6, 10, 'https://images.unsplash.com/photo-1546549032-9571cd6b27df?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1234&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (7, 10, 'https://images.unsplash.com/photo-1572383672419-ab35444a6934?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (11, 1, 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/copycat-chipotle-chicken-horizontal-1531452615.jpg?crop=1xw:1xh;center,top&resize=768:*', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (12, 10, 'https://tmbidigitalassetsazure.blob.core.windows.net/rms3-prod/attachments/37/1200x1200/Crispy-Fried-Chicken_EXPS_FRBZ19_6445_C01_31_3b.jpg', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (13, 10, 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-190918-creamy-stovetop-0267-portrait-pf-1569524272.jpg?crop=1xw:1xh;center,top&resize=480:*', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (14, 4, 'https://storcpdkenticomedia.blob.core.windows.net/media/recipemanagementsystem/media/recipe-media-files/recipes/retail/x17/2019_df_retail_butter-burger_20912_760x580.jpg?ext=.jpg', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (15, 3, 'https://i2.wp.com/lifemadesimplebakes.com/wp-content/uploads/2018/11/Yellow-Coconut-Curry.jpg', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (16, 8, 'https://i2.wp.com/completelydelicious.com/wp-content/uploads/2019/05/homemade-strawberry-pop-tarts-4-660x880.jpg', '2021-07-20T21:46:28');
INSERT INTO `recipe_image` (`recipe_id`, `user_id`, `image_url`, `date_created`) VALUES (17, 7, 'https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/01/a0001909/img/basic/a0001909_main.jpg', '2021-07-20T21:46:28');

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

