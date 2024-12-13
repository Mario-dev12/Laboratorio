import { defineStore } from "pinia";
import axios from "axios";

const userStore = defineStore("user", {
	state: () => ({
		users: [],
	}),
	actions: {
		async fecthUsers() {
			const response = await axios.get();
			this.users = response.data;
		},
	},
});
