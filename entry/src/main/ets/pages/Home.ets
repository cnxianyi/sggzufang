import { getHomeDataApi } from '../API/home'
import { BasicDataSource, IColor, INavItem, IPlanItem, ITileItem } from '../model/home'
import SwiperLayout from '../views/home/SwiperLayout'
import NavLayout from '../views/home/NavLayout'
import TileLayout from '../views/home/TileLayout'
import PlanLayout from '../views/home/PlanLayout'
import AdPicture from '../views/home/AdPicture'
import RoomRecommend from '../components/roomRecommend/RoomRecommend'
import { getRoomRecommendDataApi } from '../API/roomRecommend'
import { IRoomRecommend } from '../model/roomRecommend'
import scrollTopBar from '../components/scrollTopBar/scrollTopBar'
import SearchBar from '../views/home/SearchBar'
import { getWindowTopHeight } from '../utils/responsive'


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

  @Builder
  Content() {
    Column() {
      SwiperLayout({ BannerData: this.BannerData })
        .height(211 - 36 + getWindowTopHeight())
        .width("100%")
      Column() {
        NavLayout({ NavList: this.NavData })

        TileLayout({ TileList: this.TileData, })

        PlanLayout({ PlanList: this.PlanData, })

        AdPicture({ AdPicture: this.AdPicture, })

        RoomRecommend({ roomData: this.RoomData })
      }
    }
  }

  // 创建装饰器时规定需要传入一个有bgColor和ftColor的对象
  @Builder
  navBuilder($$: IColor) {
    SearchBar({ bgColor: $$.bgColor, ftColor: $$.ftColor });
  }

  build() {

    Column() {
      scrollTopBar({
        // 绑定了上下文
        Content: () => {
          this.Content()
        },
        // 直接传递方法而不是结果，让子组件引用
        // 此时子组件能够自己传递参数
        navBuilder: this.navBuilder
      })
    }
  }
}


