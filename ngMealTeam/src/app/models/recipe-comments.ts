import { User } from "./user";

export class RecipeComments {
  id: number;
  details: string;
  dateCreated: string;
  user: User;

  constructor(
    id = 0,
    details = '',
    dateCreated = '',
    user = new User()
  ){
    this.id = id;
    this.details = details;
    this.dateCreated = dateCreated;
    this.user = user;
  }


}
