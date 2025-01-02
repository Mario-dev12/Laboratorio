import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Income, Bill } from "@/interfaces/interfaces";

export const boxStore = defineStore("box", {
	state: () => ({
		income: [] as Income[] | Income,
        bills: [] as Bill[] | Bill,
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
	},
});
