import axios, { AxiosResponse, AxiosError } from 'axios'; 

const API_URL = 'http://localhost:600/api'; 
  
axios.interceptors.response.use(  
    (response: AxiosResponse) => response,  
    (error: AxiosError) => {  
      // Aquí puedes manejar el error como desees  
      console.error('Error in Axios Request:', error);  
      return Promise.reject(error);  
    }  
); 

class AxiosRepository {   
  async getAll<T>(domain: string): Promise<T[]> {  
    const response = await axios.get<T[]>(`${API_URL}/${domain}`);  
    return response.data;  
  }  

  async getById<T>(domain: string, id: string | number): Promise<T> {  
    const response = await axios.get<T>(`${API_URL}/${domain}/${id}`);  
    return response.data;  
  }  

  async getByName<T>(domain: string, name: string): Promise<T[]> {  
    const response = await axios.get<T[]>(`${API_URL}/${domain}`, {  
      params: { name }  
    });  
    return response.data;  
  }  

  async create<T>(domain: string, data: T): Promise<T> {  
    const response = await axios.post<T>(`${API_URL}/${domain}`, data);  
    return response.data;  
  }  
 
  async update<T>(domain: string, id: string | number, data: T): Promise<T> {  
    const response = await axios.put<T>(`${API_URL}/${domain}/${id}`, data);  
    return response.data;  
  }  
 
  async delete(domain: string, id: string | number): Promise<void> {  
    await axios.delete(`${API_URL}/${domain}/${id}`);  
  }  
}  

export const axiosRepository = new AxiosRepository();