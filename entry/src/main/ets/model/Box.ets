let boxIdCounter = 0;

@Observed
export class Box{
  id: string
  value: string

  constructor(value: string = '') {
    this.id = (++boxIdCounter).toString();
    this.value = value;
  }
}
