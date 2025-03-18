import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Order } from "@/interfaces/interfaces";

export const orderStore = defineStore("order", {
	state: () => ({
		order: [] as Order[] | Order | Partial<Order>,
	}),
	actions: {
		async fecthOrders() {
			const response = await axiosRepository.getAll<Order>("order");
			this.order = response;
			return this.order;
		},
		async fecthOrderByExamId(id: string | number) {
			const response = await axiosRepository.getByExamId<Order>("order", id);
			this.order = response;
			return this.order;
		},
		async fecthOrderByExamIdAndProfileId(idexam: string | number, idprofile: string | number) {
			const response = await axiosRepository.getByExamIdAndProfileId<Order[]>("order", idexam, idprofile);
			this.order = response;
			return this.order;
		},
		async fecthOrdersDay(today: boolean, date: string) {
			const response = await axiosRepository.getAllOrders<Order>("order", today, date);
			this.order = response;
			return this.order;
		},
		async fecthHistOrdersDay() {
			const response = await axiosRepository.getAllHistOrders<Order>("order");
			this.order = response;
			return this.order;
		},
		async createOrder(exam: Partial<Order>) {
			const response = await axiosRepository.create<Partial<Order>>("order", exam);
			this.order = response;
			return this.order;
		},
		async updateOrder(id: string | number, data: Order) {
			const response = await axiosRepository.update<Order>("order", id, data);
			this.order = response;
			return this.order;
		},
		async updateStatusOrder(id: string | number, data: any) {
			const response = await axiosRepository.updateStatusOrder<Order>("order", id, data);
			this.order = response;
			return this.order;
		},
		async deleteOrder(id: string | number) {
			await axiosRepository.delete("order", id);
		},
		async deleteOrderByExamIdAndProfileId(idexam: string | number, idprofile: string | number) {
			await axiosRepository.deleteByExamIdAndProfileId("order", idexam, idprofile);
		},
	},
});
