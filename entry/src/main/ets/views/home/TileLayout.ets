import { BORDER_RADIUS, PADDING } from '../../constants/size'
import { ITileItem } from '../../model/home'

@Component
export default struct TitleLayout {
  @Prop TileList: ITileItem[] = []

  build() {
    Row() {
      ForEach(this.TileList, (item: ITileItem) => {
        TileItem(item.imageURL, item.title, item.sub_title);
      }, (item: ITileItem) => item.id + '');
    }
    .padding({
      top: 11,
      left: PADDING,
      right: PADDING
    })
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween); // 添加这行以实现 space-between 布局
  }
}

@Builder
function TileItem(url: string, title: string, sub_title: string) {
  Column() {
    Image(url)
      .height(57)
      .width(148)
      .borderRadius(BORDER_RADIUS)

    Row({ space: 5 }) {
      Text(title).fontSize(12)
      Text(sub_title).fontSize(10).fontColor($r('app.color.gray'))
    }.justifyContent(FlexAlign.Start).width('100%')
  }
  .width(148)
}