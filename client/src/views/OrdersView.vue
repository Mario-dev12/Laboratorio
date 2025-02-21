<template>
	<ion-page>
		<ion-content>
			<div class="container mt-3">
				<h2 class="text-center mb-4">Lista de Órdenes</h2>

				<div class="mb-3">
					<input type="text" placeholder="Buscar por Documento o Nombre" v-model="searchQuery" class="form-control" />
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
	import { onMounted, ref, computed, watch } from "vue";
	import { orderStore } from "@/stores/orderStore";
	import { OrdersDay } from "@/interfaces/interfaces";
	import { useRouter } from "vue-router";

	const orders = ref();
	const router = useRouter();
	const searchQuery = ref("");
	const ordersStore = orderStore();
	const toast = ref({
		isOpen: false,
		message: "",
		duration: 2000,
	});
	const expandedOrder = ref<number | null>(null);

	onMounted(async () => {
		orders.value = await ordersStore.fecthOrdersDay();
	});

	watch(
		() => ordersStore.order,
		async (newVal, oldVal) => {
			if (newVal !== oldVal) {
				orders.value = await ordersStore.fecthOrdersDay();
			}
		},
		{ deep: true }
	);

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
		orders.value = await ordersStore.fecthOrdersDay();
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

	const openTabsView = (profileName: any) => {
		const profileNamesArray = profileName.orders.flatMap((order: { profiles: any[] }) =>
			order.profiles.map((profile: { profileName: any }) => profile.profileName)
		);
		router.push({
			name: "Results",
			query: { profileNames: JSON.stringify(profileNamesArray) },
		});
	};

	const toggleDetails = (order: any) => {
		expandedOrder.value = expandedOrder.value === order.idUser ? null : order.idUser;
	};

	function formatearFecha(fecha: string | number | Date) {
		const fechaObjeto = new Date(fecha);
		const dia = String(fechaObjeto.getDate()).padStart(2, "0");
		const mes = String(fechaObjeto.getMonth() + 1).padStart(2, "0");
		const año = fechaObjeto.getFullYear();
		return `${dia}-${mes}-${año}`;
	}
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
