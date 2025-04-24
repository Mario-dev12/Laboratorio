import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Income, Bill } from "@/interfaces/interfaces";

export const boxStore = defineStore("box", {
	state: () => ({
		income: [] as Income[] | Income,
        bills: [] as Bill[] | Bill,
		debt: []as any | any
	}),
	actions: {
		async fecthIncome(all: boolean, startDate: string, endDate: string) {
			const response = await axiosRepository.getAllIncome<Income>("box", all, startDate, endDate);
			this.income = response;
			return this.income;
		},
        async fecthBills(all: boolean, startDate: string, endDate: string) {
			const response = await axiosRepository.getAllBills<Bill>("box", all, startDate, endDate);
			this.bills = response;
			return this.bills;
		},
		async fecthDebt(all: boolean, startDate: string, endDate: string) {
			const response = await axiosRepository.getAllDebt<Income>("box", all, startDate, endDate);
			this.income = response;
			return this.income;
		},
		async createDebt(exam: any) {
			const response = await axiosRepository.create<Partial<any>>("box", exam);
			this.debt = response;
			return this.debt;
		},
		async deleteDebt(id: string | number) {
			await axiosRepository.delete("box", id);
		},
	},
});
