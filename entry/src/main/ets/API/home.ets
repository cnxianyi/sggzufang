import { http } from '../utils/http'
import { IHomeData } from '../model/home'

export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info')
}