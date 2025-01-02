import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Alliance } from "@/interfaces/interfaces";

export const allianceStore = defineStore("alliance", {
	state: () => ({
		alliance: [] as Alliance[] | Alliance,
	}),
	actions: {
		async fecthAlliance() {
			const response = await axiosRepository.getAll<Alliance>("alliance");
			this.alliance = response;
			return this.alliance;
		},
		async fecthAllianceById(id: string | number) {
			const response = await axiosRepository.getById<Alliance>("alliance", id);
			this.alliance = response;
			return this.alliance;
		},
		async fecthAllianceByName(name: string) {
			const response = await axiosRepository.getByName<Alliance>("alliance", name);
			this.alliance = response;
			return this.alliance;
		},
		async createAlliance(user: Alliance) {
			const response = await axiosRepository.create<Alliance>("alliance", user);
			this.alliance = response;
		},
		async updateAlliance(id: string | number, data: Alliance) {
			const response = await axiosRepository.update<Alliance>("alliance", id, data);
			this.alliance = response;
		},
		async deleteAlliance(id: string | number) {
			await axiosRepository.delete("alliance", id);
		},
	},
});
