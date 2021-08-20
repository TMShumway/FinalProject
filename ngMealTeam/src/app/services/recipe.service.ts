import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Recipe } from '../models/recipe';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class RecipeService {

  private url = environment.baseUrl + "api/recipes"

  constructor(private http: HttpClient, private authService: AuthService) { }

  public index(){
    return this.http.get<Recipe[]>(this.url, this.getHttpOptions())
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
}
