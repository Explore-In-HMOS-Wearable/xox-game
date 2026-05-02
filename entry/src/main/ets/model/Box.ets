@Observed
export class Box{
  private static idCounter: number = 0;
  id: string
  value: string
  key: string

  constructor(value: string = '') {
    this.id = (++Box.idCounter).toString();
    this.value = value;
    this.key = `box_${Box.idCounter++}`;
  }

  static resetCounter(): void {
    Box.idCounter = 0;
  }
}
