# Meal Team 6 (Final Project)

## Overview
Meal Team 6 is a place where foodies can connect with other foodies
over gastronomic events! Find new recipes, modify them to your taste,
and post updates to your profile or share your own recipes with our other users!

## How to Use
Upon opening Meal Team 6 you will be greeted with our splash page which
contains a rundown of some features of the site.
Along with information you will also be prompted to register or login an account.
As an unregistered user you will be able to browse the recipes stored in the site's database.
Upon creating an account you will have a user profile in which you can post updates,
view recipes you saved to your list as well as modify them to your taste or remove them completely. 

## REST Endpoints
Recipe Endpoints
| Return Type   | Route                 | Functionality                  |
|---------------|-----------------------|--------------------------------|
| `List<Recipe>`  |`GET api/recipes`        | Gets all recipes                 |
| `Recipe`        |`GET api/recipes/{recipeId}`   | Gets one recipe by id            |
| `Post`        |`POST api/recipes/{encodedURL}`       | Creates a new recipe             |
| `Put`        |`PUT api/recipes/{recipeId}/{imageURL}`   | Replaces an existing recipe by id|
| `void`        |`DELETE api/recipes/{recipeId}`| Deletes an existing recipe by id |

Post Endpoints
| Return Type   | Route                 | Functionality                  |
|---------------|-----------------------|--------------------------------|
| `List<Post>`  |`GET api/posts/published`        | Gets all published posts                 |
| `Post`        |`GET api/posts/{postId}`   | Gets one post by id            |
| `Post`        |`POST api/posts/`       | Creates a new post             |
| `Put`        |`PUT api/posts/`   | Update an existing post |
| `void`        |`DELETE api/posts/{postId}`| Deletes an existing post by id |

## Technologies Used
- Java
- JSON
- Angular
- HTML/CSS
- Bootstrap
- SQL/JPA
- REST APIs
- Test Driven Development
- Spring Boot
- Agile
- Git

## Lessons Learned (Pos/Neg)
