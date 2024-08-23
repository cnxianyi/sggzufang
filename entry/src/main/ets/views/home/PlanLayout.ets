import { PADDING } from '../../constants/size'
import { IPlanItem } from '../../model/home'

@Component
export default struct PlanLayout {
  @Prop PlanList: IPlanItem[] = []

  build() {
    Row() {
      Grid() {

        ForEach(this.PlanList, (item: IPlanItem) => {
          GridItem() {
            Image(item.imageURL)
              .width('100%')
          }
        }, (item: IPlanItem) => item.id + '')

      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr')
      .columnsGap(5)

    }
    .padding({
      top: 18,
      left: PADDING,
      right: PADDING
    })
    .height(60 + 18)
    .width('100%')

  }
}