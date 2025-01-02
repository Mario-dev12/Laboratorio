import { createRouter, createWebHistory } from "@ionic/vue-router";
import { RouteRecordRaw } from "vue-router";
import HomePage from "../views/HomePage.vue";
import HomeView from '../views/HomeView.vue'
import ListOfReactives from '../views/ListOfReactives.vue'
import NumberConsultant from '../views/NumberConsultant.vue'

const routes: Array<RouteRecordRaw> = [
	{
		path: "/",
		name: "HomeView",
		component: HomeView,
	},
	{
		path: "/crearOrden",
		name: "Home",
		component: HomePage,
	},
	{
		path: "/reactivos",
		name: "ListOfReactives",
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
