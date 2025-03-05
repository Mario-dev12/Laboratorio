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
		async fetchInputsByProfileId(id: string | number) {
			const response = await axiosRepository.getAllInputsByProfileId<Profile>("profile", id);
			this.profiles = response;
			return this.profiles;
		},
		async fetchInputsProfileByProfile(idCampo: string | number, idProfile: string | number) {
			const response = await axiosRepository.readInputsProfileByProfile<Profile>("profile", idCampo, idProfile);
			this.profiles = response;
			return this.profiles;
		},
		async fetchProfileByName(name: string) {
			const response = await axiosRepository.getByName<Profile>("profile", name);
			this.profiles = response;
			return this.profiles;
		},
		async fetchProfileByInputsName(name: string) {
			const response = await axiosRepository.getInputsByProfileName<Profile>("profile", name);
			this.profiles = response;
			return this.profiles;
		},
		async createProfile(exam: Profile) {
			const response = await axiosRepository.create<Profile>("profile", exam);
			this.profiles = response;
			return this.profiles;
		},
		async createInputsInProfile(exam: any, inputs: any) {
			const response = await axiosRepository.createInputsInProfile<Profile>("profile", exam, inputs);
			this.profiles = response;
			return this.profiles;
		},
		async createInputs(exam: any, inputs: any) {
			const response = await axiosRepository.createInputs<Profile>("profile", exam, inputs);
			this.profiles = response;
			return this.profiles;
		},
		async createProfileInputs(exam: Partial<Profile>, inputs: any, section: any) {
			const response = await axiosRepository.createProfileInputs<Partial<Profile>>("profile", exam, inputs, section);
			this.profiles = response;
			return this.profiles;
		},
		//Este es 1
		async createProfileSection(exam: any, section: any) {
			const response = await axiosRepository.createProfileSection<Profile>("profile", exam, section);
			this.profiles = response;
			return this.profiles;
		},
		//este es 2
		async createProfileSectionInputs(exam: any, inputs: any) {
			const response = await axiosRepository.createProfileSectionInputs<Profile>("profile", exam, inputs);
			this.profiles = response;
			return this.profiles;
		},
		async updateProfile(id: string | number, data: Profile) {
			const response = await axiosRepository.update<Profile>("profile", id, data);
			this.profiles = response;
			return this.profiles;
		},
		async updateInputs(id: string | number, data: Profile) {
			const response = await axiosRepository.updateInputs<Profile>("profile", id, data);
			this.profiles = response;
			return this.profiles;
		},
		async InputsProfile(id: string | number, data: Profile) {
			const response = await axiosRepository.updateInputsProfile<Profile>("profile", id, data);
			this.profiles = response;
			return this.profiles;
		},
		async deleteProfile(id: string | number) {
			await axiosRepository.delete("profile", id);
		},
		async deleteInputs(id: string | number) {
			await axiosRepository.deleteInputs("profile", id);
		},
		async deleteInputsInProfile(exam: any, inputs: number[]) {
			await axiosRepository.deleteInputsInProfile("profile", exam, inputs);
		},
		async deleteInputsProfile(id: string | number) {
			await axiosRepository.deleteInputsProfile("profile", id);
		},
		//Este es el delete 1
		async deleteProfileSection(idProfile: number, nombre: string) {
			await axiosRepository.deleteProfileSection("profile", idProfile, nombre);
		},
		//Este es el delete 2
		async deleteProfileSectionInputs(exam: any, nombre: string, inputs: any[]) {
			await axiosRepository.deleteProfileSectionInputs("profile", exam, nombre, inputs);
		},
	},
});
