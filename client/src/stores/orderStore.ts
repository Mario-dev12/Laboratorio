import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Order } from "@/interfaces/interfaces";

export const orderStore = defineStore("order", {
	state: () => ({
		order: [] as Order[] | Order,
	}),
	actions: {
		async fecthOrders() {
			const response = await axiosRepository.getAll<Order>("order");
			this.order = response;
			return this.order;
		},
		async fecthOrdersDay() {
			const response = await axiosRepository.getAllOrders<Order>("order");
			this.order = response;
			return this.order;
		},
		async fecthHistOrdersDay() {
			const response = await axiosRepository.getAllHistOrders<Order>("order");
			this.order = response;
			return this.order;
		},
		async createOrder(exam: Order) {
			const response = await axiosRepository.create<Order>("order", exam);
			this.order = response;
			return this.order;
		},
		async updateOrder(id: string | number, data: Order) {
			const response = await axiosRepository.update<Order>("order", id, data);
			this.order = response;
			return this.order;
		},
		async deleteOrder(id: string | number) {
			await axiosRepository.delete("order", id);
		},
	},
});
