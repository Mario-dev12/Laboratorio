import { defineStore } from "pinia";
import { axiosRepository } from "@/repository/axios.repository";
import { User } from "@/interfaces/interfaces";

export const userStore = defineStore("user", {
	state: () => ({
		users: [] as User[],
	}),
	actions: {
		async fecthUsers() {
			const response = await axiosRepository.getAll<User>("users");
			this.users = response;
			return this.users;
		},
		async fecthUserById(id: string | number) {
			const response = await axiosRepository.getById<User>("users", id);
			this.users = response;
			return this.users;
		},
		async fecthUserByName(name: string) {
			const response = await axiosRepository.getByName<User>("users", name);
			this.users = response;
			return this.users;
		},
		async createUser(user: User) {
			await axiosRepository.create<User>("users", user);
		},
		async updateUser(id: string | number, data: User) {
			await axiosRepository.update<User>("users", id, data);
		},
		async deleteUser(id: string | number) {
			await axiosRepository.delete("users", id);
		},
	},
});
