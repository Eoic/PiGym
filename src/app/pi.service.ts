import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class PiService {
  private apiUrl = 'https://api.pi.delivery/v1/pi';

  constructor(private http: HttpClient) {}

  cacheKey(start: number, numDigits: number): string {
    return `pi-range_${start}_${numDigits}`;
  }

  getDigits(start: number, numDigits: number): Observable<string> {
    const cachedDigits = localStorage.getItem(this.cacheKey(start, numDigits));

    if (cachedDigits) 
      return new Observable<string>((observer) => {
        observer.next(cachedDigits);
        observer.complete();
      });

    return this.http.get<{ content: string }>(
      `${this.apiUrl}?start=${start}&numberOfDigits=${numDigits}`
    ).pipe(map((response) => { 
      localStorage.setItem(this.cacheKey(start, numDigits), response.content);   
      return response.content;
    }));
  }
}
