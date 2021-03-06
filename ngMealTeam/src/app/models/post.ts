import { PostComment } from "./post-comment";
import { User } from "./user";

export class Post {
  id: number;
  title: string;
  description: string;
  dateCreated: string;
  imageUrl: string;
  hasImage: boolean;
  user: User;
  published: boolean;
  postComments: PostComment[];

  constructor(
    id = 0,
    title = '',
    description = '',
    dateCreated = '',
    imageUrl = '',
    hasImage = false,
    user = new User(),
    published = true,
    postComments = []
    ){
    this.id = id;
    this.title = title;
    this.description = description;
    this.dateCreated = dateCreated;
    this.imageUrl = imageUrl;
    this.hasImage = hasImage;
    this.user = user;
    this.published = published;
    this.postComments = postComments;
  }
}
