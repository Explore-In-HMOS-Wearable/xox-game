import { Box } from '../model/Box';
import { Utils } from '../Utils';

@Component
export struct GameBox{
  @State boxes: Box[] = Utils.generateBoxes()
  @State @Watch('checkWin') pen: string = 'X';
  @State winner: string = '';
  @State isShow: boolean = false;

  checkWin() {
    const boxes = this.boxes;

    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];

    let winner = '';
    let hasWinner = false;

    for (let i = 0; i < winPatterns.length; i++) {
      const a = winPatterns[i][0];
      const b = winPatterns[i][1];
      const c = winPatterns[i][2];

      if (
        boxes[a].value !== '' &&
          boxes[a].value === boxes[b].value &&
          boxes[a].value === boxes[c].value
      ) {
        winner = boxes[a].value;
        hasWinner = true;
        break;
      }
    }

    if (hasWinner) {
      this.winner = winner;
      this.isShow = true;
      return;
    }

    let isDraw = true;
    for (let i = 0; i < boxes.length; i++) {
      if (boxes[i].value === '') {
        isDraw = false;
        break;
      }
    }

    if (isDraw) {
      this.refresh();
    }
  }
  refresh(){
    this.pen = 'X';
    this.boxes = Utils.generateBoxes()
    this.winner = '';
    this.isShow = false;
  }

  @Builder
  ShowResult(){
    Column(){
      Text(`${this.winner} is winner!`).fontSize(24).fontWeight(FontWeight.Bold).padding(8).fontColor(Utils.generateColor(this.winner))
      Button('Restart')
        .backgroundColor(Color.White)
        .fontColor(Utils.generateColor(this.winner))
        .borderColor(Utils.generateColor(this.winner))
        .borderWidth(1)
        .fontSize(24)
        .onClick(() => {
        this.refresh()
      })
    }
  }

  build() {
    RelativeContainer() {
      Column() {
        GridRow({ columns: 3 }) {
          ForEach(this.boxes, (item:Box) => {
            GridCol() {
              Row() {
                Text(item.value)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Utils.generateColor(item.value))
                  .fontSize(28)
              }.onClick(() =>{
                if (!item.value && !this.winner) {
                  const index = this.boxes.indexOf(item)
                  this.boxes[index] = new Box(this.pen)
                  this.pen = this.pen === 'X' ? 'O' : 'X';
                }
              })
              .height('33%').width('33%').justifyContent(FlexAlign.Center)
            }.border( { 'color': Color.Gray, 'width': 1 })
          }, (item: Box) => item.id)
        }
        .width('100%').height('100%')
      }.bindSheet(this.isShow, this.ShowResult(), {height: '50%', onDisappear: () => this.refresh(), showClose:false})
      .justifyContent(FlexAlign.Center)
      .border( { 'color': Color.Gray, 'width': 2 })
      .width('70%')
      .height('70%')
      .margin('15%')
    }
    .height('100%')
    .width('100%')
  }
}