import { getHomeDataApi } from '../../API/home'
import { IColor, INavItem, IBannerItem, ITileItem, IPlanItem, BasicDataSource } from '../../model/home'
import SwiperLayout from '../../views/home/SwiperLayout'
import SearchBar from '../../views/home/SearchBar'
import NavLayout from '../../views/home/NavLayout'
import TileLayout from '../../views/home/TileLayout'
import PlanLayout from '../../views/home/PlanLayout'
import AdPicture from '../../views/home/AdPicture'
import RoomRecommend from '../../components/roomRecommend/RoomRecommend'
import { getRoomRecommendDataApi } from '../../API/roomRecommend'
import { IRoomRecommend } from '../../model/roomRecommend'
import { getWindowTopHeight } from '../../utils/responsive'
import { window } from '@kit.ArkUI'
import { rgbaToHex } from '../../utils/color'

@Component
export default struct Home {
  // 首页数据
  @State BannerData: BasicDataSource = new BasicDataSource() // 创建lazyForeach数据
  @State NavData: INavItem[] = []
  @State TileData: ITileItem[] = []
  @State PlanData: IPlanItem[] = []
  @State AdPicture: string = ''
  // 房源
  @State RoomData: IRoomRecommend[] = []
  // 滚动
  scrollY: number = 0
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State ftColor: string = 'rgb(255, 255, 255)'
  // builder
  @BuilderParam Content: () => void = this.defaultBuilder
  @BuilderParam navBuilder: ($$: IColor) => void = this.defaultBuilder
  // windows对象
  //windowClass?: window.Window
  windowClass = window.getLastWindow(getContext())
  getWindowClass = async (color: string) => {
    const windowClass = await window.getLastWindow(getContext())
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: color,
      navigationBarColor: color,
    })
  }

  @Builder
  defaultBuilder() {
  }

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
    this.getRoomData()
    this.getWindowClass(rgbaToHex(this.ftColor))
  }

  async getHomeData() {
    const res = await getHomeDataApi()
    this.BannerData.setDataList(res.bannerList)
    this.NavData = res.navList
    this.TileData = res.tileList
    this.PlanData = res.planList
    this.AdPicture = res.adPicture
  }

  async getRoomData() {
    const res = await getRoomRecommendDataApi()
    this.RoomData = res
  }

  onScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset
    let top = 10
    let end = 211 - 36 + getWindowTopHeight()

    if (this.scrollY < top) {
      // 恢复初始状态
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.ftColor = 'rgb(255, 255, 255)'
      this.getWindowClass(rgbaToHex(this.ftColor))

    } else if (this.scrollY < end) {
      let v = this.scrollY / (end - top)
      let b = v <= 1 ? v.toFixed(2) : '1'
      let f = v <= 1 ? (255 - 255 * v).toFixed() : '0'
      // 渐变中
      this.bgColor = `rgba(255, 255, 255, ${b})`
      this.ftColor = `rgb(${f} , ${f} , ${f} )`
      this.getWindowClass(rgbaToHex(this.ftColor))
    } else {
      // 完成渐变
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.ftColor = 'rgb(0 , 0 , 0)'
      this.getWindowClass(rgbaToHex(this.ftColor))
    }
  }

  build() {

    Stack() {
      Scroll() {
        Column() {
          // 渲染内容
          this.Content()
        }.align(Alignment.TopStart)
      }
      .onDidScroll(this.onScroll)
      .width("100%")
      .height("100%")
      .scrollBar(BarState.Off) // 关闭滚动条
      .align(Alignment.Top) // top显示

      // 包括状态栏部分
      Column() {
        this.navBuilder({
          bgColor: this.bgColor,
          ftColor: this.ftColor
        })
      }.padding({
        top: getWindowTopHeight(),
        left: 0
      })
      .backgroundColor(this.bgColor)
      .width('100%')
    }
    .alignContent(Alignment.Top)
  }
}