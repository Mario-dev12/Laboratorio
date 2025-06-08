import { createRouter, createWebHistory } from "@ionic/vue-router";
import { RouteRecordRaw } from "vue-router";
import HomeView from "../views/HomeView.vue";
import ListOfReactives from "../views/ListOfReactives.vue";
import NumberConsultant from "../views/NumberConsultant.vue";
import CrearOrden from "@/views/CrearOrden.vue";
import EditUserExam from "@/views/EditTests.vue";
import OrdersView from "@/views/OrdersView.vue";
import OrdersHistoryView from "@/views/OrdersHistoryView.vue";
import EditarOrden from "@/views/EditarOrden.vue";
import AddResults2 from "@/views/AddResults2.vue";
import UrocultivoResults from "@/views/UrocultivoResults.vue";
import EditCultive from "@/views/EditCultive.vue";
import EspermatogramaView from "@/views/EspermatogramaView.vue";
import Antibiotics from "@/views/AntibioticsView.vue";

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
		path: "/editarOrden/:idUser?/:idExam/:cost_bs/:cost_usd/:name/:lastName?",
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
		path: "/editarPerfil",
		name: "EditarPerfil",
		component: EditUserExam,
	},
	{
		path: "/editarCultivo",
		name: "EditarCultivo",
		component: EditCultive,
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
	{
		path: "/result2",
		name: "Results2",
		component: AddResults2,
	},
	{
		path: "/uroResults",
		name: "UroResults",
		component: UrocultivoResults,
	},
	{
		path: "/espermatograma",
		name: "Espermatograma",
		component: EspermatogramaView,
	},
	{
		path: "/antibioticos",
		name: "Antibioticos",
		component: Antibiotics,
	},
];

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes,
});

export default router;
