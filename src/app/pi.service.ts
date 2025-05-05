import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class PiService {
  private apiUrl = 'https://api.pi.delivery/v1/pi';

  constructor(private http: HttpClient) {}

  getDigits(start: number, numberOfDigits: number): Observable<string> {
    return this.http.get<{ content: string }>(
      `${this.apiUrl}?start=${start}&numberOfDigits=${numberOfDigits}`
    ).pipe(
      map(res => res.content)
    );
  }
}
