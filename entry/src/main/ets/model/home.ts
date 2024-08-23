export interface IHomeData {
  bannerList: IBannerItem[] // banner
  navList: INavItem[] // nav
  tileList: ITileItem[] // tile
  planList: IPlanItem[] // plan
  adPicture: string // ad
}

export type IBannerItem = {
  id: number
  name: string
  imageURL: string
}

export type INavItem = {
  id: number
  title: string
  imageURL: string
}

export type ITileItem = {
  id: number
  title: string
  imageURL: string
  sub_title: string
}

export type IPlanItem = {
  id: number
  imageURL: string
}
