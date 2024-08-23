import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

const request = axios.create({
  baseURL: 'http://192.168.2.200:6060',
  timeout: 20000,
})

request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // config.headers.token = token;
    return config;
  }
)

request.interceptors.response.use(
  (response: AxiosResponse) => {
    if (response.data.code === 200) {
      return response.data.data;
    } else {
      return Promise.reject(response.data.message);
    }
  },
  (error: AxiosError) => {
    return Promise.reject(error.message);
  }
)

export default class Http {
  // 使用T来指定返回值类型
  get<T>(url: string, params?: Object) {
    return request.get<null, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: Object) {
    return request.post<null, T>(url, data)
  }

  put<T>(url: string, data?: Object) {
    return request.put<null, T>(url, data)
  }

  delete<T>(url: string, params?: Object) {
    return request.delete<null, T>(url, {
      params
    })
  }
};