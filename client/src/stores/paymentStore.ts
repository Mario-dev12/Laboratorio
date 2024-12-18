import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Payment } from "@/interfaces/interfaces";

export const paymentStore = defineStore("payment", {
	state: () => ({
		payments: [] as Payment[] | Payment,
	}),
	actions: {
		async fecthPayments() {
			const response = await axiosRepository.getAll<Payment>("payment_method");
			this.payments = response;
			return this.payments;
		},
		async fetchPaymentId(id: string | number) {
			const response = await axiosRepository.getById<Payment>("payment_method", id);
			this.payments = response;
			return this.payments;
		},
		async fetchPaymentByName(name: string) {
			const response = await axiosRepository.getByName<Payment>("payment_method", name);
			this.payments = response;
			return this.payments;
		},
		async createPayment(exam: Payment) {
			const response = await axiosRepository.create<Payment>("payment_method", exam);
			this.payments = response;
		},
		async updatePayment(id: string | number, data: Payment) {
			const response = await axiosRepository.update<Payment>("payment_method", id, data);
			this.payments = response;
		},
		async deletePayment(id: string | number) {
			await axiosRepository.delete("payment_method", id);
		},
	},
});
