import { http } from '../utils/http'
import { IRoomRecommend } from '../model/roomRecommend'

export const getRoomRecommendDataApi = (): Promise<IRoomRecommend[]> => {
  return http.get<IRoomRecommend[]>('/house/nearbyHouses')
}