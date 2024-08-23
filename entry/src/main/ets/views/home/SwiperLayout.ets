import { BasicDataSource, IBannerItem } from '../../model/home'


@Component
export default struct swiperLayout {
  @ObjectLink BannerData: BasicDataSource

  aboutToAppear(): void {
    this.BannerData
  }

  build() {
    Column() {
      Swiper() {
        LazyForEach(this.BannerData, (item: IBannerItem) => {
          Image(item.imageURL)
            .width("100%").height("100%")
            .objectFit(ImageFit.Fill) // 配置填充
        }, (item: IBannerItem) => {
          return item.id + '' // 唯一键值需要为字符串
        })
      }
      .autoPlay(true)
      .interval(3000) // 间隔
      .indicator( // 设置小圆点样式
        new DotIndicator()
          .color($r('app.color.swiperIndicator'))
          .selectedColor($r('app.color.swiperIndicatorSelect'))
      )
    }
  }
}