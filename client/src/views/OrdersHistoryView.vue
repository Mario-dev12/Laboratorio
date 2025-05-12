<template>  
	<ion-page>  
		<ion-content>  
			<div class="container mt-3">  
				<div class="perfiles mt-3 mb-3">  
					<div class="row w-100 m-auto gap-2">  
					  <div  
						class="col btn"  
						:class="{'btn-light': index !== activeIndex, 'bg-gray': index === activeIndex}" 
						v-for="(profileName, index) in profileNamesOrdered"  
						:key="index"  
						@click="handleTap(index, profileName)">  
						  {{ profileName }}  
					  </div>  
					</div>  
				</div> 

				<div v-if="showProfile === 'Pruebas de Sangre'">
					<h2 class="text-center mb-4">Histórico Órdenes</h2>  

					<div class="mb-3">  
						<input  
							type="text"  
							placeholder="Buscar por Documento, Nombre o Fecha"  
							v-model="searchQuery"  
							class="form-control"  
						/>  
					</div>  

					<div v-if="isLoading" class="text-center">Cargando...</div>  
					<div v-else class="table-responsive" style="max-height: 400px; overflow-y: auto">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Documento Identidad</th>
									<th>Nombre Paciente</th>
									<th>Género</th>
									<th>Edad</th>
									<th>Creación</th>  
									<th>Modificación</th> 
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="order in filteredOrders" :key="order.idUser">
									<td>{{ order.ci }}</td>
									<td>{{ order.firstName }} {{ order.lastName }}</td>
									<td>{{ order.genre }}</td>
									<td>{{ order.age }}</td>
									<td>{{ formatearFecha(order.createdDate) }}</td>
									<td>{{ formatearFecha(order.modifiedDate) }}</td>
									<td>
										<i class="fas fa-edit" @click="openTabsView(order)" style="cursor: pointer; margin-right: 10px"></i>
										<i class="fas fa-info-circle" @click="toggleDetails(order)" style="cursor: pointer"></i>

										<div v-if="expandedOrder === order.idUser" class="order-details">
											<ul>
												<div v-for="ord in order.orders" :key="ord.idOrder">
													{{ ord.profiles[0].profileName }} - {{ ord.status }} - {{ ord.total_cost_bs }} Bs /
													{{ ord.total_cost_usd }} USD
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
					<h2 class="text-center mb-4">Histórico Cultivos</h2>  

					<div class="mb-3">  
						<input  
							type="text"  
							placeholder="Buscar por Documento, Nombre o Fecha"  
							v-model="searchQuery"  
							class="form-control"  
						/>  
					</div>  

					<div v-if="isLoading" class="text-center">Cargando...</div>  
					<div v-else class="table-responsive" style="max-height: 400px; overflow-y: auto">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Documento Identidad</th>
									<th>Nombre Paciente</th>
									<th>Género</th>
									<th>Edad</th>
									<th>Creación</th>  
									<th>Modificación</th> 
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="order in filteredCultiveOrders" :key="order.idUser">
									<td>{{ order.ci }}</td>
									<td>{{ order.firstName }} {{ order.lastName }}</td>
									<td>{{ order.genre }}</td>
									<td>{{ order.age }}</td>
									<td>{{ formatearFecha(order.createdDate) }}</td>
									<td>{{ formatearFecha(order.modifiedDate) }}</td>
									<td>
										<i class="fas fa-edit" @click="openTabsView2(order)" style="cursor: pointer; margin-right: 10px"></i>
										<i class="fas fa-info-circle" @click="toggleDetails(order)" style="cursor: pointer"></i>

										<div v-if="expandedOrder === order.idUser" class="order-details">
											<ul>
												<div v-for="ord in order.orders" :key="ord.idOrder">
													{{ ord.profiles[0].profileName }} - {{ ord.status }} - {{ ord.total_cost_bs }} Bs /
													{{ ord.total_cost_usd }} USD
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
					<h2 class="text-center mb-4">Histórico Espermatograma</h2>  

					<div class="mb-3">  
						<input  
							type="text"  
							placeholder="Buscar por Documento, Nombre o Fecha"  
							v-model="searchQuery"  
							class="form-control"  
						/>  
					</div>  

					<div v-if="isLoading" class="text-center">Cargando...</div>  
					<div v-else class="table-responsive" style="max-height: 400px; overflow-y: auto">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Documento Identidad</th>
									<th>Nombre Paciente</th>
									<th>Género</th>
									<th>Edad</th>
									<th>Creación</th>  
									<th>Modificación</th> 
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="order in filteredSpermiogramOrders" :key="order.idUser">
									<td>{{ order.ci }}</td>
									<td>{{ order.firstName }} {{ order.lastName }}</td>
									<td>{{ order.genre }}</td>
									<td>{{ order.age }}</td>
									<td>{{ formatearFecha(order.createdDate) }}</td>
									<td>{{ formatearFecha(order.modifiedDate) }}</td>
									<td>
										<i class="fas fa-edit" @click="openTabsView3(order)" style="cursor: pointer; margin-right: 10px"></i>
										<i class="fas fa-info-circle" @click="toggleDetails(order)" style="cursor: pointer"></i>

										<div v-if="expandedOrder === order.idUser" class="order-details">
											<ul>
												<div v-for="ord in order.orders" :key="ord.idOrder">
													{{ ord.profiles[0].profileName }} - {{ ord.status }} - {{ ord.total_cost_bs }} Bs /
													{{ ord.total_cost_usd }} USD
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
	import { useRouter } from "vue-router"; 
	import { checkboxOutline, alertCircleOutline } from "ionicons/icons";
	import { Ref } from "vue";
	  
	const orders = ref(); 
	const cultive = ref();   
	const spermiogram = ref();  
	const isLoading = ref(true);  
	const searchQuery = ref("");  
	const ordersStore = orderStore(); 
	const expandedOrder = ref<number | null>(null); 
	const router = useRouter();
	const profileNamesOrdered = ref(["Pruebas de Sangre", "Cultivos", "Espermatograma"])
	const showProfile = ref('');
	const activeIndex = ref<number>(0);
	const isOpen = ref(false);
	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
	});

	onMounted(async () => {  
		try {  
			orders.value = await ordersStore.fecthHistOrdersDay();  
			cultive.value = await ordersStore.fecthCultiveHistOrdersDay(); 
			spermiogram.value = await ordersStore.fecthSpermiogramHistOrdersDay(); 
			showProfile.value = 'Pruebas de Sangre'; 
		} catch (error) {  
			showToast("Error al cargar las órdenes", "warning", alertCircleOutline);  
		} finally {  
			isLoading.value = false;  
		}  
	});  

	router.beforeEach(async (to, from, next) => {
		if (to.name === "Historico") {
			orders.value = await ordersStore.fecthHistOrdersDay();  
			cultive.value = await ordersStore.fecthCultiveHistOrdersDay(); 
			spermiogram.value = await ordersStore.fecthSpermiogramHistOrdersDay(); 
			showProfile.value = 'Pruebas de Sangre';
		}
		next();
	});

	function formatDate(dateString: string): string {  
		const date = new Date(dateString);  
		const day = String(date.getDate()).padStart(2, '0');  
		const month = String(date.getMonth() + 1).padStart(2, '0');  
		const year = date.getFullYear();  
		return `${day}-${month}-${year}`;  
	} 

	const createFilteredOrders = (sourceOrders: Ref<any, any>) => computed(() => {  
		const query = searchQuery.value.toLowerCase();  
		return sourceOrders.value.filter((order: { firstName: string; lastName: string; ci: string; createdDate: string; modifiedDate: string; }) => {  
			const fullName = `${order.firstName} ${order.lastName}`.toLowerCase();  
			const formattedCreatedDate = formatDate(order.createdDate);  
			const formattedModifiedDate = formatDate(order.modifiedDate);  
			
			return order.ci.toLowerCase().includes(query) ||  
				fullName.includes(query) ||  
				formattedCreatedDate.includes(query) ||  
				formattedModifiedDate.includes(query);  
		});  
	});  

	const filteredOrders = createFilteredOrders(orders);  
	const filteredCultiveOrders = createFilteredOrders(cultive);  
	const filteredSpermiogramOrders = createFilteredOrders(spermiogram);  

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

	function formatearFecha(fecha: string | number | Date) {  
		const fechaObjeto = new Date(fecha);  
		const dia = String(fechaObjeto.getDate()).padStart(2, "0");  
		const mes = String(fechaObjeto.getMonth() + 1).padStart(2, "0");  
		const año = fechaObjeto.getFullYear();  
		return `${dia}-${mes}-${año}`;  
	}  

	const toggleDetails = (order: any) => {
		expandedOrder.value = expandedOrder.value === order.idUser ? null : order.idUser;
	};

	const openTabsView = (profileName: any) => {
		/*const profileNamesArray = profileName.orders.flatMap((order: { profiles: any[] }) =>
			order.profiles.map((profile: { profileName: any }) => profile.profileName)
		);*/
		const profileNamesArray2 = computed(() =>  
			profileName.orders.flatMap((order: { profiles: any[]; }) =>  
				order.profiles  
				.filter((profile: { externo: any; }) => !profile.externo) 
				.map((profile: { profileName: any; }) => profile.profileName)
			)  
		);  
		const filteredProfiles = profileNamesArray2.value.filter((profileName: string | string[]) =>   
			!profileName.includes('(Externo)') && !profileName.includes('(externo)') && !profileName.includes('(EXTERNO)')
		);   

		if (filteredProfiles.length === 0){
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

	function handleTap(index: number, profileName: string) {
		if (index !== activeIndex.value){
			if (profileName === 'Pruebas de Sangre'){
				showProfile.value = 'Pruebas de Sangre'
			} else if (profileName === 'Cultivos'){
				showProfile.value = 'Cultivos'
			} else {
				showProfile.value = 'Espermatograma'
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

	.bg-gray {  
		background-color: #DCD7C9; 
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