import { PADDING, SHADOW_RADIUS } from '../../constants/size'

@Component
export default struct AdPicture {
  @Prop AdPicture: string = ''

  build() {
    Column() {
      Image(this.AdPicture)
        .width('100%')
        .objectFit(ImageFit.Cover)

        .shadow({
          offsetX: 0,
          offsetY: 0,
          radius: SHADOW_RADIUS,
          color: '#10000000'
        })
    }
    .margin({
      top: 10,
      left: PADDING,
      right: PADDING
    })
  }
}