import axios, { AxiosResponse, AxiosError } from "axios";

axios.interceptors.response.use(
	(response: AxiosResponse) => response,
	(error: AxiosError) => {
		console.error("Error in Axios Request:", error);
		return Promise.reject(error);
	}
);

class AxiosRepository {
	async getAll<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}`);
		return response.data;
	}

	async getById<T>(domain: string, id: string | number): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/${id}`);
		return response.data;
	}

	async getByName<T>(domain: string, name: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/name/${name}`);
		return response.data;
	}

	async getByUnitName<T>(domain: string, name: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/name?name=${name}`);
		return response.data;
	}

	async getByReactiveAndProvider<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/provider`);
		console.log("response", response.data);
		return response.data;
	}

	async getByType<T>(domain: string, name: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/type/${name}`);
		return response.data;
	}

	async getReactiveByProvider<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/provider`);
		return response.data;
	}

	async create<T>(domain: string, data: T): Promise<T> {
		const response = await axios.post<T>(`${import.meta.env.VITE_API_URL}/${domain}`, data);
		return response.data;
	}

	async update<T>(domain: string, id: string | number, data: T): Promise<T> {
		const response = await axios.put<T>(`${import.meta.env.VITE_API_URL}/${domain}/${id}`, data);
		return response.data;
	}

	async delete(domain: string, id: string | number): Promise<void> {
		await axios.delete(`${import.meta.env.VITE_API_URL}/${domain}/${id}`);
	}
}

export const axiosRepository = new AxiosRepository();
