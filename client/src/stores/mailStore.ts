import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";

export const mailStore = defineStore("mail", {
	state: () => ({
		mail: [] as string[] | string,
	}),
	actions: {
		async sendEmail(data: any) {
			const response = await axiosRepository.create<any>("mail", data);
			this.mail = response;
			return this.mail;
		},
	},
});
