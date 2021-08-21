import { Ratings } from "./ratings";
import { RecipeComments } from "./recipe-comments";
import { User } from "./user";

export class Recipe {
  id: number;
  name: string;
  description: string;
  dateCreated: string;
  published: boolean;
  user: User;
  recipeComments: RecipeComments[];
  ratings: Ratings[];

  constructor(
    id = 0,
    name = '',
    description = '',
    dateCreated = '',
    published = false,
    user = new User(),
    recipeComments = [],
    ratings = []
    ){
    this.id = id;
    this.name = name;
    this.description = description;
    this.dateCreated = dateCreated;
    this.published = published;
    this.user = user;
    this.recipeComments = recipeComments;
    this.ratings = ratings;
  }
}
