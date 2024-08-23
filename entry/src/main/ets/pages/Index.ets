import Discover from './Discover'
import Home from "./Home"
import My from './My'
import See from './See'
import Service from './Service'


@Entry
@Component
struct Index {
  @State barIndex: number = 0

  // TabBar Builder
  @Builder
  tabBarBuilder(img: Resource, activeImg: Resource, text: string, index: number) {
    Column() {
      Image(this.barIndex === index ? activeImg : img)
        .width(28)
        .height(28)
      Text(text)
        .fontSize(10)
        .fontColor(this.barIndex === index ? $r('app.color.black') : '#A0A0A0')
    }
  }

  build() {
    // BarPosition.End 底部Bar
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Home()
      }
      // 配置 tabBar样式
      .tabBar(this.tabBarBuilder($r("app.media.tabbar_home"), $r("app.media.tabbar_home_active"), "首页", 0))

      TabContent() {
        See()
      }
      .tabBar(this.tabBarBuilder($r("app.media.tabbar_see"), $r("app.media.tabbar_see_active"), "想看", 1))

      TabContent() {
        Service()
      }
      .tabBar(this.tabBarBuilder($r("app.media.tabbar_service"), $r("app.media.tabbar_service_active"), "服务", 2))

      TabContent() {
        Discover()
      }
      .tabBar(this.tabBarBuilder($r("app.media.tabbar_discover"), $r("app.media.tabbar_discover_active"), "发现", 3))

      TabContent() {
        My()
      }
      .tabBar(this.tabBarBuilder($r("app.media.tabbar_my"), $r("app.media.tabbar_my_active"), "我的", 4))
    }
    // bar 高度
    .barHeight(50)
    // 关闭切换
    .scrollable(false)
    // 切换事件
    .onChange((index: number) => {
      this.barIndex = index
    })
  }
}