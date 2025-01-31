import { createRouter, createWebHistory } from "@ionic/vue-router";
import { RouteRecordRaw } from "vue-router";
import HomeView from "../views/HomeView.vue";
import ListOfReactives from "../views/ListOfReactives.vue";
import NumberConsultant from "../views/NumberConsultant.vue";
import CrearOrden from "@/views/CrearOrden.vue";
import OrdersView from "@/views/OrdersView.vue";
import OrdersHistoryView from "@/views/OrdersHistoryView.vue";
import EditarOrden from "@/views/EditarOrden.vue";

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
		path: "/editarOrden/:idUser/:idExam/:cost_bs/:cost_usd",  
		name: "EditarOrden",  
		component: EditarOrden,  
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
	{
		path: "/ordenes",
		name: "OrdersView",
		component: OrdersView,
	},
	{
		path: "/historico",
		name: "Historico",
		component: OrdersHistoryView,
	},
];

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes,
});

export default router;
