import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Reactive } from "@/interfaces/interfaces";

const reactiveStore = defineStore("exam", {
	state: () => ({
		reactives: [] as Reactive[] | Reactive,
	}),
	actions: {
		async fecthReactives() {
			const response = await axiosRepository.getAll<Reactive>("reactive");
			this.reactives = response;
		},
		async fetchReactiveById(id: string | number) {
			const response = await axiosRepository.getById<Reactive>("reactive", id);
			this.reactives = response;
		},
		async fetchReactiveByName(name: string) {
			const response = await axiosRepository.getByName<Reactive>("reactive", name);
			this.reactives = response;
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
