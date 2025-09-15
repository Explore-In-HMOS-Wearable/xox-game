import { GameBox } from '../components/GameBox'

@Entry
@Component
struct Index {

  build() {
    Column(){
      GameBox()
    }
  }
}