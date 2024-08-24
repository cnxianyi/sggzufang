/**
 *
 * lazy懒加载forEach
 * */
@Observed
export class BasicDataSource implements IDataSource {
  // 内部更新需要的数据
  private listeners: DataChangeListener[] = [];
  // 自己定义的数据
  private originDataArray: IBannerItem[] = [];

  /**
   * 将单个数据项添加到数据源中，并通知数据项添加。
   *
   * @param {IBannerItem} item 要添加到数据源中的数据项。
   */
  setData(item: IBannerItem) {
    this.originDataArray.push(item);
    this.notifyDataAdd(this.originDataArray.length - 1);
  }

  /**
   * 设置整个数据源为指定的数据列表，并通知数据源重新加载。
   *
   * @param {IBannerItem[]} itemList 用于替换当前数据源的完整数据列表。
   */
  setDataList(itemList: IBannerItem[]) {
    this.originDataArray = itemList;
    this.notifyDataReload();
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  public totalCount(): number {
    return this.originDataArray.length;
  }

  public getData(index: number): IBannerItem {
    return this.originDataArray[index];
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}


export interface IHomeData {
  bannerList: IBannerItem[] // banner
  navList: INavItem[] // nav
  tileList: ITileItem[] // tile
  planList: IPlanItem[] // plan
  adPicture: string // ad
}

export interface IBannerItem {
  id: number;
  name: string;
  imageURL: string;
}

export interface INavItem {
  id: number;
  title: string;
  imageURL: string;
}

export interface ITileItem {
  id: number;
  title: string;
  imageURL: string;
  sub_title: string;
}

export interface IPlanItem {
  id: number;
  imageURL: string;
}

export interface IColor {
  bgColor: string,
  ftColor: string
}