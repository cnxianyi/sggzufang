import { getHomeDataApi } from '../API/home'
import { INavItem, IBannerItem, ITileItem, IPlanItem, BasicDataSource } from '../model/home'
import SwiperLayout from '../views/home/SwiperLayout'
import SearchBar from '../views/home/SearchBar'
import NavLayout from '../views/home/NavLayout'
import TileLayout from '../views/home/TileLayout'
import PlanLayout from '../views/home/PlanLayout'
import AdPicture from '../views/home/AdPicture'
import RoomRecommend from '../components/roomRecommend/RoomRecommend'
import { getRoomRecommendDataApi } from '../API/roomRecommend'
import { IRoomRecommend } from '../model/roomRecommend'

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

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
    this.getRoomData()
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
    console.log(JSON.stringify(res))
    this.RoomData = res
  }

  onScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset
    let top = 10
    let end = 211 - 36

    if (this.scrollY < top) {
      // 恢复初始状态
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.ftColor = 'rgb(255, 255, 255)'
    } else if (this.scrollY < end) {
      let v = this.scrollY / (end - top)
      let b = v <= 1 ? v.toFixed(2) : '1'
      let f = v <= 1 ? (255 - 255 * v).toFixed() : '0'
      // 渐变中
      this.bgColor = `rgba(255, 255, 255, ${b})`
      this.ftColor = `rgb(${f} , ${f} , ${f} )`
    } else {
      // 完成渐变
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.ftColor = 'rgb(0 , 0 , 0)'
    }
  }

  build() {

    Stack() {
      Scroll() {
        Column() {
          SwiperLayout({ BannerData: this.BannerData })
            .height(211 - 36)
            .width("100%")
          Column() {
            NavLayout({ NavList: this.NavData })

            TileLayout({ TileList: this.TileData })

            PlanLayout({ PlanList: this.PlanData })

            AdPicture({ AdPicture: this.AdPicture })

            RoomRecommend({ roomData: this.RoomData })
          }
        }
      }
      .onDidScroll(this.onScroll)
      .width("100%")
      .height("100%")
      .scrollBar(BarState.Off) // 关闭滚动条
      .align(Alignment.Top) // top显示

      SearchBar({
        bgColor: this.bgColor,
        ftColor: this.ftColor
      })
    }
    .alignContent(Alignment.Top)

  }
}