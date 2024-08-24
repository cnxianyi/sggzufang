export type IRoomRecommend = IRoomRecommendItem[];

export interface IRoomRecommendItem {
  id: string,
  housePicture: string,
  tags: IRoomTags[],
  houseTitle: string,
  address: string,
  rentPriceUnit: string,
  rentPriceListing: string,
  rentArea: string
}

export interface IRoomTags {
  name: string
}
