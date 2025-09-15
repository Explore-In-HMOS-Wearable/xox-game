import { Box } from "./model/Box";

export class Utils{

   static generateBoxes(): Box[] {
    const list: Box[] = [];
    for (let index = 0; index < 9; index++) {
      list.push(new Box( ''))
    }
    return list;
  }
   static generateColor(value: string): ResourceColor{
    if (value == 'X') {
      return Color.Blue

    }
    else {
      return Color.Red
    }
  }


}
