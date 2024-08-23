import { http } from '../utils/http'
import type { IHomeData } from '../model/home'

export const getHomeDataApi = () => {
  return http.get<IHomeData>('/home/info')
}