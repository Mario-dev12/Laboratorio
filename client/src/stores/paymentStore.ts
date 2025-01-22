import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Payment } from "@/interfaces/interfaces";

export const paymentStore = defineStore("payment", {
	state: () => ({
		payment: [] as Payment[] | Payment,
	}),
	actions: {
		async fecthPayments() {
			const response = await axiosRepository.getAll<Payment>("payment");
			this.payment = response;
			return this.payment;
		},
		async createPayment(exam: Payment) {
			const response = await axiosRepository.create<Payment>("payment", exam);
			this.payment = response;
			return this.payment;
		},
		async updatePayment(id: string | number, data: Payment) {
			const response = await axiosRepository.update<Payment>("payment", id, data);
			this.payment = response;
			return this.payment;
		},
		async deletePayment(id: string | number) {
			await axiosRepository.delete("payment", id);
		},
	},
});
