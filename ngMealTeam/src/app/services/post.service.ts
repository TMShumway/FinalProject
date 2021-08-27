import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Post } from '../models/post';
import { PostComment } from '../models/post-comment';
import { Recipe } from '../models/recipe';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PostService {

  private url = environment.baseUrl + "api/posts"

  constructor(private http: HttpClient, private authService: AuthService) { }

  public index(){
    return this.http.get<Post[]>(this.url, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting posts in PostService:" + err);
        })
      );
  }
  // public indexPublishedTrue(){
  //   return this.http.get<Post[]>(this.url + "/published", this.getHttpOptions())
  //     .pipe(
  //       catchError((err: any) => {
  //         console.log(err);
  //         return throwError("Error getting posts in PostService:" + err);
  //       })
  //     );
  // }

  public indexByUsernamePublishedTrue(username: String){
    return this.http.get<Post[]>(this.url + "/published" , this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError("Error getting user posts in PostService:" + err);
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

  public createPost(post: Post){
    return this.http.post<Post>(this.url, post, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Error creating post: ' + err);
        })
      );
  }

  public destroyPost(post: Post){
    return this.http.delete<Post>(this.url + "/" + post.id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error destroying post: ' + err);
      })
      );
  }

  // addComment(id: number, newComment: PostComment): Observable<Post> {
  //   return this.http.post<Post>(this.url + "/add/comment/new/" + id ,newComment , this.getHttpOptions())
  //   .pipe(
  //     catchError((err: any) => {
  //       console.log(err);
  //       return throwError('Error adding comment to post: '+ err);
  //     })
  //   );
  // }
}
