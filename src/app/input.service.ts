import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class InputService {
  private inputs: Map<string, boolean> = new Map();

  set(key: string, value: boolean) {
    this.inputs.set(key, value);
  }

  get(key: string) {
    return this.inputs.get(key);
  }

  isMultipleNumberKeysPressed(): boolean {
    let isNumPressed = false;

    for (let i = 0; i < 9; i++)  {
      if (!this.inputs.get(i.toString()))
        continue;

      if (isNumPressed)
        break;

      isNumPressed = true;
    }

    return isNumPressed;
  }
}
