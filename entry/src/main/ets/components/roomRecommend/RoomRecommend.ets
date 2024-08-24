import { BORDER_RADIUS, PADDING, PADDING_S } from '../../constants/size'
import { IRoomRecommend, IRoomRecommendItem, IRoomTags } from '../../model/roomRecommend'

@Component
export default struct RoomRecommend {
  @Prop roomData: IRoomRecommend[] = []

  aboutToAppear(): void {
    console.log(JSON.stringify(this.roomData))
  }

  build() {
    Column() {
      Column() {
        Row() {
          Row() {
            Text('周边房源')
              .fontSize(16)
              .fontWeight(700)
            Text('推荐')
              .fontSize(16)
              .fontWeight(700)
              .fontColor($r('app.color.primary'))
          }

          Row({ space: 6 }) {
            Text('更多推荐')
              .fontSize(12)
              .fontColor($r('app.color.gray_second'))

            Image($r('app.media.arrow_right'))
              .height(8)
              .width(4)
          }
        }

        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .height(44)
      }
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.start_window_background'))
      .margin({
        bottom: 16
      })
      .padding({
        top: 23,
        left: PADDING,
        right: PADDING
      })

      Grid() {

        ForEach(this.roomData, (item: IRoomRecommendItem) => {
          GridItem() {
            RoomItem(item.housePicture, item.address, item.rentPriceListing, item.rentPriceUnit, item.rentArea,
              item.houseTitle, item.tags)
          }
        },
          (item: IRoomRecommendItem) => item.id)

      }
      .padding({
        left: PADDING,
        right: PADDING
      })
      .columnsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)

    }
    .backgroundColor($r('app.color.bg_gray'))

  }
}

@Builder
function RoomItem(housePicture: string, address: string,
  listing: string, unit: string, area: string, title: string, tags: IRoomTags[]) {
  Column() {
    Stack({ alignContent: Alignment.BottomStart }) {
      Column() {
        Image(housePicture)
          .height('100%')
          .objectFit(ImageFit.Fill)
          .borderRadius({
            topLeft: BORDER_RADIUS,
            topRight: BORDER_RADIUS
          })
      }

      Column() {
        Row({ space: 6 }) {
          Image($r('app.media.location'))
            .width(12)
          Text(address)
            .fontSize(12)
            .fontColor($r('app.color.white'))
        }
      }
      .padding({
        left: 8,
        bottom: 6
      })

    }
    .height(120)
    .width('100%')


    Column() {
      Row() {
        Row() {
          Text('¥' + listing)
            .fontSize(16)
            .fontColor($r('app.color.roomOrange'))

          Text(unit.slice(unit.indexOf('/')))
            .fontSize(12)
            .fontColor($r('app.color.roomOrange'))
            .margin({
              top: 7
            })
        }

        Row() {
          Text(area + 'm²')
            .fontSize(10)
            .fontColor($r('app.color.gray'))
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({
        left: PADDING_S,
        right: PADDING_S
      })
    }
    .height(22)
    .margin({
      top: 11,
      bottom: 2
    })

    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(500)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }.margin({
      left: PADDING_S,
      right: PADDING_S,
    })


    Column() {
      Row({ space: 6 }) {
        ForEach(tags.slice(0, 2), (item: IRoomTags, index: number) => {
          Text(item.name)
            .fontSize(10)
            .fontWeight(500)
            .fontColor(index === 0 ? $r('app.color.white') : $r('app.color.roomGray'))
            .backgroundColor(index === 0 ? $r('app.color.roomGreen') : $r('app.color.bg_gray'))
            .padding({
              left: 6,
              right: 6
            })
            .borderRadius(2)
            .height(16)
        })
      }

    }
    .position({
      bottom: 12,
      left: 10
    })
  }
  .borderRadius(BORDER_RADIUS)
  .backgroundColor($r('app.color.start_window_background'))
  .height(211)
}