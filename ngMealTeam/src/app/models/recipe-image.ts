
export class RecipeImage {

  id: number;
  imageUrl: string;
  dateCreated: string;

  constructor(
    id = 0,
    imageUrl = '',
    dateCreated = ''
  ){
    this.id = id;
    this.imageUrl = imageUrl;
    this.dateCreated = dateCreated;
  }
}
