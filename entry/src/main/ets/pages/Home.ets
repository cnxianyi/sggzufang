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

  build() {
    Scroll() {

      Column() {
        Column() {
          Stack() {
            SwiperLayout({ BannerData: this.BannerData })

            SearchBar()
          }
          .alignContent(Alignment.Top)
        }
        .height(211 - 36)
        .width("100%")


        NavLayout({ NavList: this.NavData })

        TileLayout({ TileList: this.TileData })

        PlanLayout({ PlanList: this.PlanData })

        AdPicture({ AdPicture: this.AdPicture })

        RoomRecommend({ roomData: this.RoomData })

      }
    }
    .width("100%")
    .height("100%")
    .scrollBar(BarState.Off) // 关闭滚动条
    .align(Alignment.Top) // top显示
  }
}