<template>
	<ion-page>
		<ion-content>
			<div class="container mt-3">
				<h2 class="text-center mb-4">Lista de Órdenes</h2>

				<div class="mb-3 d-flex">
					<input type="text" placeholder="Buscar por Documento o Nombre" v-model="searchQuery" class="form-control" />
					<input type="date" v-model="selectedDate" class="form-control" style="margin-left: 10px; margin-right: 10px" />
					<button class="btn btn-primary ml-2" @click="searchOrders">Buscar</button>
				</div>

				<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Documento Identidad</th>
								<th>Nombre Paciente</th>
								<th>Género</th>
								<th>Edad</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="order in filteredOrders" :key="order.idUser">
								<td>{{ order.ci }}</td>
								<td>{{ order.firstName }} {{ order.lastName }}</td>
								<td>{{ order.genre }}</td>
								<td>{{ order.age }}</td>
								<td>
									<i class="fa-solid fa-plus" style="cursor: pointer; margin-right: 10px" @click="openTabsView(order)"></i>
									<i class="fas fa-edit" @click="editOrder(order)" style="cursor: pointer; margin-right: 10px"></i>
									<i class="fas fa-info-circle" @click="toggleDetails(order)" style="cursor: pointer"></i>

									<div v-if="expandedOrder === order.idUser" class="order-details">
										<ul>
											<div v-for="ord in order.orders" :key="ord.idOrder">
												{{ ord.profiles[0].profileName }} - {{ ord.status }} - {{ ord.total_cost_bs }} Bs /
												{{ ord.total_cost_usd }} USD
												<i
													class="fas fa-trash"
													@click="deleteOrder(ord.idOrder)"
													style="cursor: pointer; margin-left: 10px; color: black"
													title="Eliminar orden"></i>
											</div>
										</ul>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonContent, IonPage } from "@ionic/vue";
	import { onMounted, ref, computed } from "vue";
	import { orderStore } from "@/stores/orderStore";
	import { useRouter } from "vue-router";

	const orders = ref();
	const router = useRouter();
	const searchQuery = ref("");
	const selectedDate = ref("");
	const ordersStore = orderStore();
	const toast = ref({
		isOpen: false,
		message: "",
		duration: 2000,
	});
	const expandedOrder = ref<number | null>(null);

	onMounted(async () => {
		orders.value = await ordersStore.fecthOrdersDay(true, "");
	});

	router.beforeEach(async (to, from, next) => {
		if (to.name === "OrdersView") {
			if (selectedDate.value) {
				const dateISO = selectedDate.value;
				const [year, month, day] = dateISO.split("-");
				const formattedDate = `${day}-${month}-${year}`;

				orders.value = await ordersStore.fecthOrdersDay(false, formattedDate);
			} else {
				orders.value = await ordersStore.fecthOrdersDay(true, "");
			}
		}
		next();
	});

	const toggleDetails = (order: any) => {
		expandedOrder.value = expandedOrder.value === order.idUser ? null : order.idUser;
	};

	const openTabsView = (profileName: any) => {
		const profileNamesArray = profileName.orders.flatMap((order: { profiles: any[] }) =>
			order.profiles.map((profile: { profileName: any }) => profile.profileName)
		);
		router.push({
			name: "Results2",
			query: { profile: JSON.stringify(profileName), profileNames: JSON.stringify(profileNamesArray) },
		});
	};

	const filteredOrders = computed(() => {
		if (!orders.value) return [];

		const query = searchQuery.value ? searchQuery.value.toLowerCase() : "";
		return orders.value.filter((order: { firstName: any; lastName: any; ci: string }) => {
			if (!order.firstName || !order.lastName || !order.ci) return false;
			const fullName = `${order.firstName} ${order.lastName}`.toLowerCase();
			return order.ci.toLowerCase().includes(query) || fullName.includes(query);
		});
	});

	const showToast = (message: string) => {
		toast.value.message = message;
		toast.value.isOpen = true;
	};

	const deleteOrder = async (id: number | string) => {
		await ordersStore.deleteOrder(id);
		showToast("Orden borrada correctamente");
		orders.value = await ordersStore.fecthOrdersDay(true, "");
	};

	const editOrder = async (order: any) => {
		router.push({
			name: "EditarOrden",
			params: {
				idUser: order.ci,
				idExam: order.orders[0].idExam,
				cost_bs: order.orders[0].total_cost_bs,
				cost_usd: order.orders[0].total_cost_usd,
			},
		});
	};

	const searchOrders = async () => {
		if (selectedDate.value) {
			const dateISO = selectedDate.value;
			const [year, month, day] = dateISO.split("-");
			const formattedDate = `${day}-${month}-${year}`;

			orders.value = await ordersStore.fecthOrdersDay(false, formattedDate);
		} else {
			showToast("Por favor, selecciona una fecha.");
		}
	};
</script>

<style scoped>
	.container {
		padding: 16px;
	}

	.table-responsive {
		max-height: 400px;
	}

	.btn-container {
		display: flex;
		justify-content: flex-end;
		margin-bottom: 1rem;
	}

	.order-details {
		margin-top: 10px;
		padding: 10px;
		background-color: #f9f9f9;
		border-radius: 4px;
	}
</style>
