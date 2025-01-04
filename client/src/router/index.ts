import { createRouter, createWebHistory } from "@ionic/vue-router";
import { RouteRecordRaw } from "vue-router";
import HomeView from "../views/HomeView.vue";
import ListOfReactives from "../views/ListOfReactives.vue";
import NumberConsultant from "../views/NumberConsultant.vue";
import CrearOrden from "@/views/CrearOrden.vue";

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
	{
		path: "/caja",
		name: "Caja",
		component: NumberConsultant,
	},
];

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes,
});

export default router;
