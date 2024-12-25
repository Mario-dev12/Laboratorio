import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Reactive, ReactiveProvider } from "@/interfaces/interfaces";

export const reactiveStore = defineStore("reactive", {
	state: () => ({
		reactives: [] as Reactive[] | Reactive,
	}),
	actions: {
		async fecthReactives() {
			const response = await axiosRepository.getAll<Reactive>("reactive");
			this.reactives = response;
			return this.reactives;
		},
		async fecthQuantityReactives() {
			const response = await axiosRepository.getByTotalQuantity<Reactive>("reactive");
			this.reactives = response;
			return this.reactives;
		},
		async fetchReactiveById(id: string | number) {
			const response = await axiosRepository.getById<Reactive>("reactive", id);
			this.reactives = response;
			return this.reactives;
		},
		async fetchReactiveByName(name: string) {
			console.log(name);
			const response = await axiosRepository.getByName<Reactive>("reactive", name);
			this.reactives = response;
			return this.reactives;
		},
		async fetchReactiveByProvider() {
			const response = await axiosRepository.getByReactiveAndProvider<ReactiveProvider>("reactive");
			this.reactives = response;
			return this.reactives;
		},
		async createReactive(reactive: Reactive) {
			const response = await axiosRepository.create<Reactive>("reactive", reactive);
			this.reactives = response;
		},
		async updateReactive(id: string | number, data: Reactive) {
			const response = await axiosRepository.update<Reactive>("reactive", id, data);
			this.reactives = response;
		},
		async deleteReactive(id: string | number) {
			await axiosRepository.delete("reactive", id);
		},
	},
});
