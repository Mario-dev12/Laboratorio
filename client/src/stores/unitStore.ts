import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Unit } from "@/interfaces/interfaces";

export const unitStore = defineStore("unit", {
	state: () => ({
		units: [] as Unit[] | Unit,
	}),
	actions: {
		async fecthUnits() {
			const response = await axiosRepository.getAll<Unit>("unit");
			this.units = response;
			return this.units;
		},
		async fetchUnitById(id: string | number) {
			const response = await axiosRepository.getById<Unit>("unit", id);
			this.units = response;
			return this.units;
		},
		async fetchUnitByName(name: string) {
			const response = await axiosRepository.getByName<Unit>("unit", name);
			this.units = response;
			return this.units;
		},
		async createUnit(reactive: Unit) {
			const response = await axiosRepository.create<Unit>("unit", reactive);
			this.units = response;
		},
		async updateUnit(id: string | number, data: Unit) {
			const response = await axiosRepository.update<Unit>("unit", id, data);
			this.units = response;
		},
		async deleteUnit(id: string | number) {
			await axiosRepository.delete("unit", id);
		},
	},
});
