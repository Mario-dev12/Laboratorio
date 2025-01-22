import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Payment_Method } from "@/interfaces/interfaces";

export const payment_MethodStore = defineStore("payment_Methods", {
	state: () => ({
		payment_Methods: [] as Payment_Method[] | Payment_Method,
	}),
	actions: {
		async fecthPayments() {
			const response = await axiosRepository.getAll<Payment_Method>("payment_method");
			this.payment_Methods = response;
			return this.payment_Methods;
		},
		async fetchPaymentId(id: string | number) {
			const response = await axiosRepository.getById<Payment_Method>("payment_method", id);
			this.payment_Methods = response;
			return this.payment_Methods;
		},
		async fetchPaymentByName(name: string) {
			const response = await axiosRepository.getByName<Payment_Method>("payment_method", name);
			this.payment_Methods = response;
			return this.payment_Methods;
		},
		async createPayment(exam: Payment_Method) {
			const response = await axiosRepository.create<Payment_Method>("payment_method", exam);
			this.payment_Methods = response;
			return this.payment_Methods;
		},
		async updatePayment(id: string | number, data: Payment_Method) {
			const response = await axiosRepository.update<Payment_Method>("payment_method", id, data);
			this.payment_Methods = response;
			return this.payment_Methods;
		},
		async deletePayment(id: string | number) {
			await axiosRepository.delete("payment_method", id);
		},
	},
});
