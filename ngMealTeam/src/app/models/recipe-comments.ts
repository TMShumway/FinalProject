import { User } from "./user";

export class RecipeComments {
  id: number;
  details: string;
  dateCreated: string;
  user: User;
  recipeComments: RecipeComments[];

  constructor(
    id = 0,
    details = '',
    dateCreated = '',
    user = new User(),
    recipeComments = []
  ){
    this.id = id;
    this.details = details;
    this.dateCreated = dateCreated;
    this.user = user;
    this.recipeComments = recipeComments;
  }


}
