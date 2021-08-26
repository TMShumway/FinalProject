import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { User } from '../models/user';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AuthService } from './auth.service';
import { environment } from 'src/environments/environment';

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
      return this.http.get<User[]>(this.url + "users", this.getHttpOptions())
        .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError("Error getting posts in AdminService:" + err);
          })
        );
    }


}
