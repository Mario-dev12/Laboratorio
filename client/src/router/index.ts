import { createRouter, createWebHistory } from "@ionic/vue-router";
import { RouteRecordRaw } from "vue-router";
import CrearOrden from "../views/CrearOrden.vue";
import HomeView from "../views/HomeView.vue";
import ListOfReactives from "../views/ListOfReactives.vue";

const routes: Array<RouteRecordRaw> = [
	{
		path: "/",
		redirect: "/home",
	},
	{
		path: "/home",
		name: "Home",
		component: HomeView,
	},
	{
		path: "/crearOrden",
		name: "CrearOrden",
		component: CrearOrden,
	},
	{
		path: "/reactivos",
		name: "Reactivos",
		component: ListOfReactives,
	},
];

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes,
});

export default router;
