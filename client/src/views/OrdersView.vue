<template>  
	<ion-page>  
		<ion-content>  
			<div class="container mt-3">  
				<h2 class="text-center mb-4">Lista de Órdenes</h2>  

				<div class="mb-3">  
					<input  
						type="text"  
						placeholder="Buscar por Documento o Nombre"  
						v-model="searchQuery"  
						class="form-control"  
					/>  
				</div>  

				<div class="table-responsive" style="max-height: 400px; overflow-y: auto">  
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
								<th>Acciones</th>  
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
								<td>  
									<i class="fa-solid fa-plus" style="cursor: pointer; margin-right: 10px"></i>  
									<i class="fas fa-edit" style="cursor: pointer; margin-right: 10px"></i>  
									<i class="fas fa-trash" @click="deleteOrder(order.idOrden)" style="cursor: pointer"></i>  
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

	const orders = ref();  // Mantener como solo ref()  
	const searchQuery = ref("");  
	const ordersStore = orderStore();  
	const toast = ref({  
		isOpen: false,  
		message: "",  
		duration: 2000,  
	});  

	onMounted(async () => {  
		orders.value = await ordersStore.fecthOrdersDay();  
	});  

	const filteredOrders = computed(() => {  
		if (!orders.value) return []; 

		const query = searchQuery.value.toLowerCase();  
		return orders.value.filter((order: { firstName: any; lastName: any; ci: string; }) => {  
			const fullName = `${order.firstName} ${order.lastName}`.toLowerCase();  
			return (  
				order.ci.toLowerCase().includes(query) || fullName.includes(query)  
			);  
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