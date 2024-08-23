import { PADDING } from '../../constants/size'
import { INavItem, IBannerItem, ITileItem, IPlanItem, BasicDataSource } from '../../model/home'


@Component
export default struct NavLayout {
  @Prop NavList: INavItem[] = []

  build() {
    Column() {
      Grid() {
        ForEach(this.NavList, (item: INavItem) => {
          GridItem() {
            GridItemBuilder(item.imageURL, item.title)
          }
        }, (item: INavItem) => item.id + '')
      }
      .columnsTemplate('1fr 1fr 1fr 1fr') // 一行四个
      .rowsTemplate('1fr 1fr') // 一列两个
      .rowsGap(14) // 行间距
      .columnsGap(33) // 列间距
    }
    .height(170)
    .margin({
      top: 24,
      left: PADDING,
      right: PADDING,
      bottom: 11
    })
  }
}

@Builder
function GridItemBuilder(url: string, txt: string) {
  Column() {
    Image(url)
      .width(58)
      .height(58)
    Text(txt)
      .fontSize(12)
      .fontColor($r('app.color.black'))
      .fontWeight(500)
  }
}