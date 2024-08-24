import { PADDING } from '../../constants/size'

@Component
export default struct SearchBar {
  @Prop bgColor: string = 'rgba(255, 255, 255, 0)'
  @Prop ftColor: string = 'rgb(255, 255, 255)'

  build() {
    Row() {
      Text("北京").fontSize(14)
        .margin({ right: 16 })
        .fontColor(this.ftColor)

      Row() {
        Image($r('app.media.search'))
          .imageStyles(18)

        TextInput({ placeholder: '公司/地铁/小区，马上搜索' })
          .fontSize(12)
          .placeholderFont({
            size: 12
          })
          .placeholderColor($r('app.color.gray'))
          .caretColor($r('app.color.gray'))
          .backgroundColor($r('app.color.white'))
          .layoutWeight(1)
          .height('100%')
          .stateStyles({
            // 状态样式
            pressed: textInputStyles // 按下状态的样式
          })

        Column() { // 竖线
        }.width(1).height(18).backgroundColor('#D7D7D7').margin({ left: 10 })

        Image($r("app.media.position")).imageStyles(18).margin({ left: 16 })


      }
      .layoutWeight(1)
      .height(38)
      .backgroundColor($r('app.color.white'))
      .padding({ left: PADDING, right: PADDING })
      .border({
        width: 1,
        radius: 52,
        color: '#D7D7D7'
      })

      // 图片需要通过 fillColor 修改颜色，只有 svg 图片能用
      Image($r("app.media.message")).imageStyles(24)
        .fillColor(this.ftColor)
        .margin({ left: 16 })
    }
    .backgroundColor(this.bgColor)
    .position({
      top: 0
    })
    .width('100%')
    .padding({
      left: PADDING,
      right: PADDING,
      top: 4,
      bottom: 4
    })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Extend(Image)
function imageStyles(size: number) {
  .width(size).height(size).objectFit(ImageFit.Fill)
}

@Styles
function textInputStyles() {
  .backgroundColor('#fff')
}