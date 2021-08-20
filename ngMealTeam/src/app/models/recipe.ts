import { User } from "./user";

export class Recipe {
  id: number;
  name: string;
  description: string;
  dateCreated: string;
  published: boolean;
  user: User;

  constructor(
    id = 0,
    name = '',
    description = '',
    dateCreated = '',
    published = false,
    user = new User()
    ){
    this.id = id;
    this.name = name;
    this.description = description;
    this.dateCreated = dateCreated;
    this.published = published;
    this.user = user;
  }
}
