export class User {
  id: number;
  username: string;
  password: string;
  email: string;
  role: string;
  enabled: boolean;
  imgUrl: string;
  dateCreated: string;
  constructor(
    id = 0,
    username = '',
    password = '',
    email = '',
    role = '',
    enabled = false,
    imgUrl = '',
    dateCreated = '',
  ){
    this.id = id;
    this.username = username;
    this.password = password;
    this.email = email;
    this.role = role;
    this.enabled = enabled;
    this.imgUrl = imgUrl;
    this.dateCreated = dateCreated;
  }
}
