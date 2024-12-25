import { createRouter, createWebHistory } from "@ionic/vue-router";
import { RouteRecordRaw } from "vue-router";
import HomePage from "../views/HomePage.vue";
import NavBar from "@/components/NavBar.vue";

const routes: Array<RouteRecordRaw> = [
	{
		path: "/",
		name: "Main",
		component: NavBar,
		children: [
			{
				path: "crearOrden",
				component: HomePage,
			},
		],
	},
];

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes,
});

export default router;
