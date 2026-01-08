import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Restriction } from "@/interfaces/interfaces";

export const restrictionStore = defineStore("restriction", {
	state: () => ({
		restrictions: [] as Restriction[] | Restriction,
	}),
	actions: {
		async fecthRestrictions() {
			const response = await axiosRepository.getAll<Restriction>("restriction");
			this.restrictions = response;
			return this.restrictions;
		},
		async fetchRestrictionById(id: string | number) {
			const response = await axiosRepository.getById<Restriction>("restriction", id);
			this.restrictions = response;
			return this.restrictions;
		},
		async createRestriction(restriction: any) {
			const response = await axiosRepository.create<Restriction>("restriction", restriction);
			this.restrictions = response;
			return this.restrictions;
		},
		async updateRestriction(id: string | number, data: any) {
			const response = await axiosRepository.update<Restriction>("restriction", id, data);
			this.restrictions = response;
			return this.restrictions;
		},
		async deleteRestriction(id: string | number) {
			await axiosRepository.delete("restriction", id);
		},
	},
});
