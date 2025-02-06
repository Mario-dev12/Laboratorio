import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { Profile, Campo, Unit } from "@/interfaces/interfaces";

export const profileStore = defineStore("profile", {
	state: () => ({
		profiles: [] as Profile[] | Profile | Partial<Profile>,
		inputs: [] as Campo[] | Campo,
		units: [] as Unit[] | Unit,
	}),
	actions: {
		async fecthProfiles() {
			const response = await axiosRepository.getAll<Profile>("profile");
			this.profiles = response;
			return this.profiles;
		},
		// Estos son el store para conseguir los campos y las unidades, las 2 comentadas

		async fecthProfilesInputs() {
			const response = await axiosRepository.getAllInputs<Campo>("profile");
			this.inputs = response;
			return this.inputs;
		},
		async fecthProfilesInputUnits() {
			const response = await axiosRepository.getAllInputUnits<Unit>("profile");
			this.units = response;
			return this.units;
		},
		async fecthProfilesUnrepeated() {
			const response = await axiosRepository.getAllUnrepeated<Profile>("profile");
			this.profiles = response;
			return this.profiles;
		},
		async fetchProfileById(id: string | number) {
			const response = await axiosRepository.getById<Profile>("profile", id);
			this.profiles = response;
			return this.profiles;
		},
		async fetchProfileByName(name: string) {
			const response = await axiosRepository.getByName<Profile>("profile", name);
			this.profiles = response;
			return this.profiles;
		},
		async createProfile(exam: Profile) {
			const response = await axiosRepository.create<Profile>("profile", exam);
			this.profiles = response;
			return this.profiles;
		},
		async createProfileInputs(exam: Partial<Profile>, inputs: any) {
			const response = await axiosRepository.createProfileInputs<Partial<Profile>>("profile", exam, inputs);
			this.profiles = response;
			return this.profiles;
		},
		async updateProfile(id: string | number, data: Profile) {
			const response = await axiosRepository.update<Profile>("profile", id, data);
			this.profiles = response;
			return this.profiles;
		},
		async deleteProfile(id: string | number) {
			await axiosRepository.delete("profile", id);
		},
	},
});
