import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { User } from "@/interfaces/interfaces";

const userStore = defineStore("user", {
	state: () => ({
		users: [] as User[] | User,
	}),
	actions: {
		async fecthUsers() {
			const response = await axiosRepository.getAll<User>("users");
			this.users = response;
		},
		async fecthUserById(id: string | number) {
			const response = await axiosRepository.getById<User>("users", id);
			this.users = response;
		},
		async fecthUserByName(name: string) {
			const response = await axiosRepository.getByName<User>("users", name);
			this.users = response;
		},
		async createUser(user: User) {
			const response = await axiosRepository.create<User>("users", user);
			this.users = response;
		},
		async updateUser(id: string | number, data: User) {
			const response = await axiosRepository.update<User>("users", id, data);
			this.users = response;
		},
		async deleteUser(id: string | number) {
			await axiosRepository.delete("users", id);
		},
	},
});
