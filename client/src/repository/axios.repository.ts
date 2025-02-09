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

	async getAllInputs<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/input`);
		return response.data;
	}

	async getAllInputUnits<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/unit`);
		return response.data;
	}

	async getAllUnrepeated<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/unrepeated`);
		return response.data;
	}

	async getAllOrders<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/orders`);
		return response.data;
	}

	async getAllHistOrders<T>(domain: string): Promise<T[]> {
		const response = await axios.get<T[]>(`${import.meta.env.VITE_API_URL}/${domain}/history`);
		return response.data;
	}

	async getAllIncome<T>(domain: string, all: boolean, startDate: string, endDate: string): Promise<T[]> {
		const response = await axios.get<T[]>(
			`${import.meta.env.VITE_API_URL}/${domain}/ingreso?all=${all}&startDate=${startDate}&endDate=${endDate}`
		);
		return response.data;
	}

	async getAllBills<T>(domain: string, all: boolean, startDate: string, endDate: string): Promise<T[]> {
		const response = await axios.get<T[]>(
			`${import.meta.env.VITE_API_URL}/${domain}/egreso?all=${all}&startDate=${startDate}&endDate=${endDate}`
		);
		return response.data;
	}

	async getById<T>(domain: string, id: string | number): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/${id}`);
		return response.data;
	}

	async getAllInputsByProfileId<T>(domain: string, id: string | number): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/inputs/${id}`);
		return response.data;
	}

	async readInputsProfileByProfile<T>(domain: string, idCampo: string | number, idProfile: string | number): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/inputsprofile/${idCampo}/${idProfile}`);
		return response.data;
	}

	async getByExamId<T>(domain: string, id: string | number): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/exam/${id}`);
		return response.data;
	}

	async getByExamIdAndProfileId<T>(domain: string, idexam: string | number, idprofile: string | number): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/order/${idexam}/${idprofile}`);
		return response.data;
	}

	async getPaymentsByExamIdAndPaymentMethodId<T>(
		domain: string,
		idexam: string | number,
		idpayment_method: string | number
	): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/pay/${idexam}/${idpayment_method}`);
		return response.data;
	}

	async getByName<T>(domain: string, name: string): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/name/${name}`);
		return response.data;
	}

	async getByUnitName<T>(domain: string, name: string): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/name?name=${name}`);
		return response.data;
	}

	async getByReactiveAndProvider<T>(domain: string): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/provider`);
		return response.data;
	}

	async getByType<T>(domain: string, name: string): Promise<T> {
		const response = await axios.get<T>(`${import.meta.env.VITE_API_URL}/${domain}/type/${name}`);
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

	async createProfileInputs<T>(domain: string, data: T, inputs: T): Promise<T> {
		const requestData = {
			data,
			inputs,
		};
		const response = await axios.post<T>(`${import.meta.env.VITE_API_URL}/${domain}/inputs`, requestData);
		return response.data;
	}

	async update<T>(domain: string, id: string | number | undefined, data: T): Promise<T> {
		const response = await axios.put<T>(`${import.meta.env.VITE_API_URL}/${domain}/${id}`, data);
		return response.data;
	}

	async updateInputs<T>(domain: string, id: string | number | undefined, data: T): Promise<T> {
		const response = await axios.put<T>(`${import.meta.env.VITE_API_URL}/${domain}/input/${id}`, data);
		return response.data;
	}

	async updateInputsProfile<T>(domain: string, id: string | number | undefined, data: T): Promise<T> {
		const response = await axios.put<T>(`${import.meta.env.VITE_API_URL}/${domain}/profileinputs/${id}`, data);
		return response.data;
	}

	async delete(domain: string, id: string | number): Promise<void> {
		await axios.delete(`${import.meta.env.VITE_API_URL}/${domain}/${id}`);
	}

	async deleteInputs(domain: string, id: string | number): Promise<void> {
		await axios.delete(`${import.meta.env.VITE_API_URL}/${domain}/input/${id}`);
	}

	async deleteInputsProfile(domain: string, id: string | number): Promise<void> {
		await axios.delete(`${import.meta.env.VITE_API_URL}/${domain}/profileinputs/${id}`);
	}

	async deleteByExamIdAndProfileId(domain: string, idexam: string | number, idprofile: string | number): Promise<void> {
		await axios.delete(`${import.meta.env.VITE_API_URL}/${domain}/order/${idexam}/${idprofile}`);
	}
}

export const axiosRepository = new AxiosRepository();
