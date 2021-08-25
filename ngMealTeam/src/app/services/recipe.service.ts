import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Ratings } from '../models/ratings';
import { Recipe } from '../models/recipe';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class RecipeService {

  private url = environment.baseUrl + "api/recipes"

  constructor(private http: HttpClient, private authService: AuthService) { }

  public index() : Observable<Recipe[]>{
    return this.http.get<Recipe[]>(this.url, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting recipes in RecipeService:" + err);
        })
      );
  }

  public indexUnauthenticated() : Observable<Recipe[]>{
    return this.http.get<Recipe[]>(environment.baseUrl + "unauthenticated/recipes")
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting recipes in RecipeService:" + err);
        })
      );
  }

  public indexByTitleKeywordUnauthenticated(keyword: string) : Observable<Recipe[]>{
    return this.http.get<Recipe[]>(environment.baseUrl + "unauthenticated/search/title/" + keyword)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting recipes in RecipeService:" + err);
        })
      );
  }

  public indexByDescriptionKeywordUnauthenticated(keyword: string) : Observable<Recipe[]>{
    return this.http.get<Recipe[]>(environment.baseUrl + "unauthenticated/search/description/" + keyword)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting recipes in RecipeService:" + err);
        })
      );
  }

  public indexByUsername() : Observable<Recipe[]>{
    return this.http.get<Recipe[]>(this.url + "/username", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting recipes in RecipeService:" + err);
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

  public create(recipe: Recipe, rImageUrl: string){
    rImageUrl = btoa(rImageUrl);
    return this.http.post<Recipe>(this.url + "/" + rImageUrl, recipe, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error creating recipe: ' + err);
        })
      );
  }

  public delete(recipe: Recipe){
    return this.http.delete<Recipe>(this.url + "/" + recipe.id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error creating recipe: ' + err);
      })
      );
  }

  public edit(recipe: Recipe, rImageUrl: string){
    rImageUrl = btoa(rImageUrl);
    return this.http.put<Recipe>(this.url + "/" + recipe.id + "/" + rImageUrl, recipe, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error creating recipe: ' + err);
        })
      );
  }

  public addRating(recipe:Recipe, newRating: number, username: String){
    return this.http.post<Ratings>(this.url + "/" + newRating + "/" + username, recipe, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error creating rating: '+ err);
      })
    );
  }

}
