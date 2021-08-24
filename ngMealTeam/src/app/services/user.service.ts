import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { throwError } from 'rxjs';
import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Post } from '../models/post';
import { Recipe } from '../models/recipe';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private url = environment.baseUrl + "api/users";

  constructor(private http: HttpClient, private authService: AuthService) { }

  public indexPostsByUsername() : Observable<Post[]>{
    return this.http.get<Post[]>(environment.baseUrl + "api/posts/username", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting recipes in RecipeService:" + err);
        })
      );
  }

  public addRecipeToUserList(recipe: Recipe){
    return this.http.put<Recipe>(this.url + "/recipe", recipe, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error adding recipe to user\'s list: ' + err)
        })
      );
  }

  getHttpOptions(){
    const credentials = this.authService.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': `Basic ${credentials}`
      })
    };
  return httpOptions;
  }

}
