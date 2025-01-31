<template>  
	<ion-page>  
		<ion-content>  
			<div class="container mt-3">  
				<h2 class="text-center mb-4">Histórico Órdenes</h2>  

				<div class="mb-3">  
					<input  
						type="text"  
						placeholder="Buscar por Documento o Nombre"  
						v-model="searchQuery"  
						class="form-control"  
					/>  
				</div>  

				<div v-if="isLoading" class="text-center">Cargando...</div>  
				<div v-else class="table-responsive" style="max-height: 400px; overflow-y: auto">  
					<table class="table table-striped">  
						<thead>  
							<tr>  
								<th>Nombre Paciente</th>  
								<th>Documento Identidad</th>  
								<th>Género</th>  
								<th>Edad</th>  
								<th>N° Orden</th>  
								<th>Perfil</th>  
								<th>Estatus</th>  
								<th>Creación</th>  
								<th>Modificado</th>  
							</tr>  
						</thead>  
						<tbody>  
							<tr v-for="order in filteredOrders" :key="order.idOrden">  
								<td>{{ order.firstName }} {{ order.lastName }}</td>  
								<td>{{ order.ci }}</td>  
								<td>{{ order.genre }}</td>  
								<td>{{ order.age }}</td>  
								<td>{{ order.idExam }}</td>  
								<td>{{ order.profileName }}</td>  
								<td>{{ order.status }}</td>  
								<td>{{ formatearFecha(order.createdDate) }}</td>  
								<td>{{ formatearFecha(order.modifiedDate) }}</td>  
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
	  
	const orders = ref();  
	const isLoading = ref(true);  
	const searchQuery = ref("");  
	const ordersStore = orderStore();  

	onMounted(async () => {  
		try {  
			orders.value = await ordersStore.fecthHistOrdersDay();  
		} catch (error) {  
			showToast("Error al cargar las órdenes");  
		} finally {  
			isLoading.value = false;  
		}  
	});  

	const filteredOrders = computed(() => {  
		const query = searchQuery.value.toLowerCase();  
		return orders.value.filter((order: { firstName: any; lastName: any; ci: string; }) => {  
			const fullName = `${order.firstName} ${order.lastName}`.toLowerCase();  
			return order.ci.toLowerCase().includes(query) || fullName.includes(query);  
		});  
	});  

	const showToast = (message: string) => {  
		const toast = document.createElement('ion-toast');  
		toast.message = message;  
		toast.duration = 2000;  
		document.body.appendChild(toast);  
		toast.present();  
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
</style>