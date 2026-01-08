import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Provider } from "@/interfaces/interfaces";

export const providerStore = defineStore("provider", {
	state: () => ({
		providers: [] as Provider[] | Provider,
	}),
	actions: {
		async fecthProviders() {
			const response = await axiosRepository.getAll<Provider>("providers");
			this.providers = response;
			return this.providers;
		},
		async fetchProviderById(id: string | number) {
			const response = await axiosRepository.getById<Provider>("providers", id);
			this.providers = response;
			return this.providers;
		},
		async fetchProviderByName(name: string) {
			const response = await axiosRepository.getByName<Provider>("providers", name);
			this.providers = response;
			return this.providers;
		},
		async createProvider(provider: Provider) {
			const response = await axiosRepository.create<Provider>("providers", provider);
			this.providers = response;
			return this.providers;
		},
		async updateProvider(id: string | number, data: Provider) {
			const response = await axiosRepository.update<Provider>("providers", id, data);
			this.providers = response;
			return this.providers;
		},
		async deleteProvider(id: string | number) {
			await axiosRepository.delete("providers", id);
		},
	},
});
