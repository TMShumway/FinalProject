import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { User } from '../models/user';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AuthService } from './auth.service';
import { environment } from 'src/environments/environment';
import { Post } from '../models/post';
import { Recipe } from '../models/recipe';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  private url = environment.baseUrl + "api/admin";

  constructor(private http: HttpClient, private authService: AuthService) { }

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

  indexUsers(): Observable<User[]> {
      return this.http.get<User[]>(this.url + "/users", this.getHttpOptions())
        .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError("Error getting users in AdminService:" + err);
          })
        );
  }
  indexRecipes(): Observable<Recipe[]> {
      return this.http.get<Recipe[]>(this.url + "/recipes", this.getHttpOptions())
        .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError("Error getting recipes in AdminService:" + err);
          })
        );
  }
  indexPosts(): Observable<Post[]> {
      return this.http.get<Post[]>(this.url + "/posts", this.getHttpOptions())
        .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError("Error getting posts in AdminService:" + err);
          })
        );
  }

  disableUser(userId: number): Observable<User>{
    return this.http.put<User>(this.url + "/users/" + userId, {}, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error disabling user in AdminService:" + err);
      })
    );
  }
  disableRecipe(recipeId: number): Observable<Recipe>{
    return this.http.put<Recipe>(this.url + "/users/" + recipeId, {}, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error disabling user in AdminService:" + err);
      })
    );
  }
  disablePost(postId: number): Observable<Post>{
    return this.http.put<Post>(this.url + "/users/" + postId, {}, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError("Error disabling user in AdminService:" + err);
      })
    );
  }
}
