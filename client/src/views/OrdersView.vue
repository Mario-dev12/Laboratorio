<template>
	<ion-page>
		<ion-content>
			<div class="container mt-3">
				<div class="perfiles mt-3 mb-3">
					<div class="row w-100 m-auto gap-2">
						<div
							class="col btn"
							:class="{ 'btn-light': index !== activeIndex, 'bg-gray': index === activeIndex }"
							v-for="(profileName, index) in profileNamesOrdered"
							:key="index"
							@click="handleTap(index, profileName)">
							{{ profileName }}
						</div>
					</div>
				</div>

				<div v-if="showProfile === 'Pruebas de Sangre'">
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

				<div v-else-if="showProfile === 'Cultivos'">
					<h2 class="text-center mb-4">Lista de Cultivos</h2>

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
								<tr v-for="order in filteredCultiveOrders" :key="order.idUser">
									<td>{{ order.ci }}</td>
									<td>{{ order.firstName }} {{ order.lastName }}</td>
									<td>{{ order.genre }}</td>
									<td>{{ order.age }}</td>
									<td>
										<i class="fa-solid fa-plus" style="cursor: pointer; margin-right: 10px" @click="openTabsView2(order)"></i>
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

				<div v-else>
					<h2 class="text-center mb-4">Lista de Espermatograma</h2>

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
								<tr v-for="order in filteredSpermiogramOrders" :key="order.idUser">
									<td>{{ order.ci }}</td>
									<td>{{ order.firstName }} {{ order.lastName }}</td>
									<td>{{ order.genre }}</td>
									<td>{{ order.age }}</td>
									<td>
										<i class="fa-solid fa-plus" style="cursor: pointer; margin-right: 10px" @click="openTabsView3(order)"></i>
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
			</div>
			<ion-toast
				:class="toast.class"
				:icon="toast.icon"
				:is-open="isOpen"
				:message="toast.message"
				duration="2000"
				@didDismiss="setOpen(false)"
				position="top">
			</ion-toast>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonContent, IonPage, IonToast } from "@ionic/vue";
	import { onMounted, ref, computed } from "vue";
	import { orderStore } from "@/stores/orderStore";
	import { useRouter, onBeforeRouteLeave } from "vue-router";
	import { checkboxOutline } from "ionicons/icons";

	const orders = ref();
	const cultive = ref();
	const spermiogram = ref();
	const router = useRouter();
	const searchQuery = ref("");
	const selectedDate = ref("");
	const ordersStore = orderStore();
	const profileNamesOrdered = ref(["Pruebas de Sangre", "Cultivos", "Espermatograma"]);
	const showProfile = ref("");
	const activeIndex = ref<number>(0);
	const isOpen = ref(false);
	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
	});
	const expandedOrder = ref<number | null>(null);

	onMounted(async () => {
		orders.value = await ordersStore.fecthOrdersDay(true, "");
		cultive.value = await ordersStore.fecthCultiveOrdersDay(true, "");
		spermiogram.value = await ordersStore.fecthSpermiogramOrdersDay(true, "");
		showProfile.value = "Pruebas de Sangre";
		activeIndex.value = 0;
	});

	router.beforeEach(async (to, from, next) => {
		if (to.name === "OrdersView") {
			if (selectedDate.value) {
				const dateISO = selectedDate.value;
				const [year, month, day] = dateISO.split("-");
				const formattedDate = `${day}-${month}-${year}`;

				orders.value = await ordersStore.fecthOrdersDay(false, formattedDate);
				cultive.value = await ordersStore.fecthCultiveOrdersDay(false, formattedDate);
				spermiogram.value = await ordersStore.fecthSpermiogramOrdersDay(false, formattedDate);
				showProfile.value = "Pruebas de Sangre";
			} else {
				orders.value = await ordersStore.fecthOrdersDay(true, "");
				cultive.value = await ordersStore.fecthCultiveOrdersDay(true, "");
				spermiogram.value = await ordersStore.fecthSpermiogramOrdersDay(true, "");
				showProfile.value = "Pruebas de Sangre";
			}
			activeIndex.value = 0;
		}
		next();
	});

	onBeforeRouteLeave((to, from, next) => {
		expandedOrder.value = 0;
		next();
	});

	const toggleDetails = (order: any) => {
		expandedOrder.value = expandedOrder.value === order.idUser ? null : order.idUser;
	};

	const openTabsView = (profileName: any) => {
		/*const profileNamesArray = profileName.orders.flatMap((order: { profiles: any[] }) =>
			order.profiles.map((profile: { profileName: any }) => profile.profileName)
		);*/
		const profileNamesArray2 = computed(() =>
			profileName.orders.flatMap((order: { profiles: any[] }) =>
				order.profiles
					.filter((profile: { externo: any }) => !profile.externo)
					.map((profile: { profileName: any }) => profile.profileName)
			)
		);
		const filteredProfiles = profileNamesArray2.value.filter(
			(profileName: string | string[]) =>
				!profileName.includes("(Externo)") && !profileName.includes("(externo)") && !profileName.includes("(EXTERNO)")
		);

		if (filteredProfiles.length === 0) {
			showToast("Los examenes son externos", "warning", checkboxOutline);
		} else {
			router.push({
				name: "Results2",
				query: { profile: JSON.stringify(profileName), profileNames: JSON.stringify(filteredProfiles) },
			});
		}
	};

	const openTabsView2 = (profileName: any) => {
		const profileNamesArray = profileName.orders.flatMap((order: { profiles: any[] }) =>
			order.profiles.map((profile: { profileName: any }) => profile.profileName)
		);
		router.push({
			name: "UroResults",
			query: { profile: JSON.stringify(profileName), profileNames: JSON.stringify(profileNamesArray) },
		});
	};

	const openTabsView3 = (profileName: any) => {
		const profileNamesArray = profileName.orders.flatMap((order: { profiles: any[] }) =>
			order.profiles.map((profile: { profileName: any }) => profile.profileName)
		);
		router.push({
			name: "Espermatograma",
			query: { profile: JSON.stringify(profileName), profileNames: JSON.stringify(profileNamesArray) },
		});
	};

	const filteredOrders = computed(() => filterOrders(orders.value));
	const filteredCultiveOrders = computed(() => filterOrders(cultive.value));
	const filteredSpermiogramOrders = computed(() => filterOrders(spermiogram.value));

	function filterOrders(ordersArray: any[]) {
		if (!ordersArray) return [];

		const query = searchQuery.value ? searchQuery.value.toLowerCase() : "";
		return ordersArray.filter((order: { firstName: any; lastName: any; ci: string }) => {
			const fullName = `${order.firstName} ${order.lastName}`.toLowerCase();
			return order.ci.toLowerCase().includes(query) || fullName.includes(query);
		});
	}

	const setOpen = (state: boolean) => {
		isOpen.value = state;
	};

	const showToast = (message: string, style: string, icon: any) => {
		toast.value.message = message;
		toast.value.isOpen = true;
		toast.value.class = style;
		toast.value.icon = icon;
		setOpen(true);
	};

	const deleteOrder = async (id: number | string) => {
		await ordersStore.deleteOrder(id);
		showToast("Orden borrada correctamente", "creado", checkboxOutline);
		orders.value = await ordersStore.fecthOrdersDay(true, "");
		cultive.value = await ordersStore.fecthCultiveOrdersDay(true, "");
		spermiogram.value = await ordersStore.fecthSpermiogramOrdersDay(true, "");
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
			cultive.value = await ordersStore.fecthCultiveOrdersDay(false, formattedDate);
			spermiogram.value = await ordersStore.fecthSpermiogramOrdersDay(false, formattedDate);
		} else {
			showToast("Por favor, selecciona una fecha.", "warning", checkboxOutline);
		}
	};

	function handleTap(index: number, profileName: string) {
		if (index !== activeIndex.value) {
			if (profileName === "Pruebas de Sangre") {
				showProfile.value = "Pruebas de Sangre";
			} else if (profileName === "Cultivos") {
				showProfile.value = "Cultivos";
			} else {
				showProfile.value = "Espermatograma";
			}
		}
		activeIndex.value = index;
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

	.bg-gray {
		background-color: #dcd7c9;
	}

	ion-toast.creado {
		--background: rgb(0, 204, 0);
		--color: #323232;
	}

	ion-toast.borrar {
		--background: rgb(229, 0, 0);
		--color: #323232;
	}

	ion-toast.warning {
		--background: rgb(219, 248, 0);
		--color: #323232;
	}
</style>
