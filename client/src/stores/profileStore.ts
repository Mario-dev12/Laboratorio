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

		async fecthAllProfiles() {
			const response = await axiosRepository.getAllProfile<Profile>("profile");
			this.profiles = response;
			return this.profiles;
		},

		async fecthCultives() {
			const response = await axiosRepository.getAllCultive<Profile>("profile");
			this.profiles = response;
			return this.profiles;
		},
		async fecthSpermiogram() {
			const response = await axiosRepository.getAllSpermiogram<Profile>("profile");
			this.profiles = response;
			return this.profiles;
		},
		async fecthBacterium() {
			const response = await axiosRepository.getAllBacterium<Profile>("profile");
			this.profiles = response;
			return this.profiles;
		},
		async fecthAntibiotics() {
			const response = await axiosRepository.getAllAntibiotics<Profile>("profile");
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
		//Es esta lo de hematología
		async fetchSectionByName(name: string) {
			const response = await axiosRepository.getBySectionName<Profile>("profile", name);
			this.profiles = response;
			return this.profiles;
		},
		async fetchProfileByInputsName(name: string) {
			const response = await axiosRepository.getInputsByProfileName<Profile>("profile", name);
			this.profiles = response;
			return this.profiles;
		},
		async fetchProfileByInputsName2(name: string, id: string | number) {
			const response = await axiosRepository.getInputsByProfileName2<Profile>("profile", name, id);
			this.profiles = response;
			return this.profiles;
		},
		async fetchCultiveResult(id: string | number, name: string) {
			const response = await axiosRepository.getCultiveResult<Profile>("profile", id, name);
			this.profiles = response;
			return this.profiles;
		},
		async fetchSpermiogramResult(id: string | number, name: string) {
			const response = await axiosRepository.getSpermiogramResult<Profile>("profile", id, name);
			this.profiles = response;
			return this.profiles;
		},
		async createProfile(exam: Profile) {
			const response = await axiosRepository.create<Profile>("profile", exam);
			this.profiles = response;
			return this.profiles;
		},
		async createAntibiotics(exam: any) {
			const response = await axiosRepository.createAntibiotics<Profile>("profile", exam);
			this.profiles = response;
			return this.profiles;
		},
		async createBacteria(exam: any) {
			const response = await axiosRepository.createBacterium<Profile>("profile", exam);
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
		async createCultive(exam: Partial<Profile>) {
			const response = await axiosRepository.createCultive<Partial<Profile>>("profile", exam);
			this.profiles = response;
			return this.profiles;
		},
		async createCultiveResults(exam: any, sensibles: any, resistentes: any) {
			const response = await axiosRepository.createCultiveResults<Partial<Profile>>("profile", exam, sensibles, resistentes);
			this.profiles = response;
			return this.profiles;
		},
		async createSpermiogramResults(exam: any, id: number) {
			const response = await axiosRepository.createSpermiogramResults<Partial<Profile>>("profile", exam, id);
			this.profiles = response;
			return this.profiles;
		},
		async createProfileSection(exam: any, section: any) {
			const response = await axiosRepository.createProfileSection<Profile>("profile", exam, section);
			this.profiles = response;
			return this.profiles;
		},
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
		async updateProfileSection(id: string | number, data: any) {
			const response = await axiosRepository.updateProfileSection<Profile>("profile", id, data);
			this.profiles = response;
			return this.profiles;
		},
		async updateAntibiotics(id: string | number, data: any) {
			const response = await axiosRepository.updateAntibiotics<Profile>("profile", id, data);
			this.profiles = response;
			return this.profiles;
		},
		async updateBacterium(id: string | number, data: any) {
			const response = await axiosRepository.updateBacterium<Profile>("profile", id, data);
			this.profiles = response;
			return this.profiles;
		},
		async updateCultive(id: string | number, data: Profile) {
			const response = await axiosRepository.updateCultive<Profile>("profile", id, data);
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
		async deleteAntibiotics(id: string | number) {
			await axiosRepository.deleteAntibiotics("profile", id);
		},
		async deleteBacterium(id: string | number) {
			await axiosRepository.deleteBacterium("profile", id);
		},
		async deleteCultive(id: string | number) {
			await axiosRepository.deleteCultive("profile", id);
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
		async deleteProfileSection(idProfile: number, nombre: string) {
			await axiosRepository.deleteProfileSection("profile", idProfile, nombre);
		},
		async deleteProfileSectionInputs(exam: any, nombre: string, inputs: any[]) {
			await axiosRepository.deleteProfileSectionInputs("profile", exam, nombre, inputs);
		},
	},
});
