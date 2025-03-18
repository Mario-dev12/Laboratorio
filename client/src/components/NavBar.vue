<template>
	<div class="desktop">
		<ion-header>
			<ion-toolbar>
				<ion-title slot="end"> Lab Madre Emilia </ion-title>
				<ion-buttons slot="start">
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'Home' })">
						<ion-icon slot="start" :icon="home"></ion-icon>
						Home
					</ion-button>
					<ion-button class="border-end border-secondary" fill="clear" @click="() => router.push({ name: 'EditarPerfil' })">
						<ion-icon slot="start" :icon="pencilSharp"></ion-icon>
						Editar Perfil
					</ion-button>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'Reactivos' })">
						<ion-icon slot="start" :icon="flask"></ion-icon>
						Reactivos
					</ion-button>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'CrearOrden' })">
						<ion-icon slot="start" :icon="document"></ion-icon>
						Crear Orden
					</ion-button>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'OrdersView' })">
						<ion-icon slot="start" :icon="create"></ion-icon>
						Órdenes
					</ion-button>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'Historico' })">
						<ion-icon slot="start" :icon="copy"></ion-icon>
						Hist.Órdenes
					</ion-button>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'Caja' })">
						<ion-icon slot="start" :icon="calculator"></ion-icon>
						Caja
					</ion-button> 
					<div class="d-flex align-items-center">  
						<h5 v-if="!showChangeDolar" class="text-success mb-0 fw-bold">Tasa Dolar: Bs: {{ precioDolar }}</h5> 
						<input  
							v-if="showChangeDolar"  
							v-model.number="precioDolar"  
							type="number"  
							placeholder="Nuevo monto"  
							@keyup.enter="cambiarPrecioDolar(precioDolar)"  
							class="ms-2"   
						/>  
						
						<i   
							class="fas fa-edit ms-2 text-dark cursor-pointer"   
							@click="showChangeDolar = !showChangeDolar"   
							title="Editar tasa del dólar"></i>  
						
						<i  
							v-if="showChangeDolar"  
							class="fas fa-check accept-icon"  
							@click="cambiarPrecioDolar(precioDolar)"  
							style="cursor: pointer; margin-left: 10px;"  
						></i>  
						
						<i  
							v-if="showChangeDolar"  
							class="fas fa-times reject-icon"  
							@click="cancelarEdicion"  
							style="cursor: pointer; margin-left: 10px;"  
						></i>  
					</div> 
				</ion-buttons>
			</ion-toolbar>
		</ion-header>
	</div>
	<div class="mobile">
		<ion-menu content-id="main-content">
			<ion-header>
				<ion-toolbar>
					<ion-title>Lab Madre Emilia</ion-title>
				</ion-toolbar>
			</ion-header>
			<ion-content class="ion-padding">
				<ion-row class="row">
					<ion-button fill="clear" @click="() => router.push({ name: 'Home' })">
						<ion-icon slot="start" :icon="home"></ion-icon>
						Home
					</ion-button>
					<ion-button class="clear" fill="clear" @click="() => router.push({ name: 'EditarPerfil' })">
						<ion-icon slot="start" :icon="pencilSharp"></ion-icon>
						Editar Perfil
					</ion-button>
					<ion-button fill="clear" class="" @click="() => router.push({ name: 'Reactivos' })">
						<ion-icon slot="start" :icon="flask"></ion-icon>
						Reactivos
					</ion-button>
					<ion-button fill="clear" @click="() => router.push({ name: 'CrearOrden' })">
						<ion-icon slot="start" :icon="document"></ion-icon>
						Crear Orden
					</ion-button>
					<ion-button fill="clear" @click="() => router.push({ name: 'OrdersView' })">
						<ion-icon slot="start" :icon="create"></ion-icon>
						Órdenes
					</ion-button>
					<ion-button fill="clear" @click="() => router.push({ name: 'Historico' })">
						<ion-icon slot="start" :icon="copy"></ion-icon>
						Hist. Órdenes
					</ion-button>
					<ion-button fill="clear" @click="() => router.push({ name: 'Caja' })">
						<ion-icon slot="start" :icon="calculator"></ion-icon>
						Caja
					</ion-button>
					<div class="d-flex align-items-center">  
						<h5 v-if="!showChangeDolar" class="text-success mb-0 fw-bold">Tasa Dolar: Bs: {{ precioDolar }}</h5> 
						<input  
							v-if="showChangeDolar"  
							v-model.number="precioDolar"  
							type="number"  
							placeholder="Nuevo monto"  
							@keyup.enter="cambiarPrecioDolar(precioDolar)"  
							class="ms-2"   
						/>  
						
						<i   
							class="fas fa-edit ms-2 text-dark cursor-pointer"   
							@click="showChangeDolar = !showChangeDolar"   
							title="Editar tasa del dólar"></i>  
						
						<i  
							v-if="showChangeDolar"  
							class="fas fa-check accept-icon"  
							@click="cambiarPrecioDolar(precioDolar)"  
							style="cursor: pointer; margin-left: 10px;"  
						></i>  
						
						<i  
							v-if="showChangeDolar"  
							class="fas fa-times reject-icon"  
							@click="cancelarEdicion"  
							style="cursor: pointer; margin-left: 10px;"  
						></i>  
					</div> 
					<ion-menu-toggle class="mt-2">
						<ion-button expand="block" color="danger">
							<ion-icon slot="start" :icon="closeOutline"></ion-icon>
							Cerrar Menu
						</ion-button>
					</ion-menu-toggle>
				</ion-row>
			</ion-content>
		</ion-menu>
		<div id="main-content">
			<ion-header>
				<ion-toolbar color="primary">
					<ion-buttons slot="start">
						<ion-menu-button></ion-menu-button>
					</ion-buttons>
					<ion-title>Lab Madre Emilia</ion-title>
				</ion-toolbar>
			</ion-header>
		</div>
	</div>
</template>

<script setup lang="ts">
	import {
		IonHeader,
		IonToolbar,
		IonTitle,
		IonButtons,
		IonButton,
		IonIcon,
		IonContent,
		IonMenu,
		IonMenuButton,
		IonMenuToggle,
		IonRow,
	} from "@ionic/vue";
	import { flask, home, document, closeOutline, calculator, create, copy, pencilSharp } from "ionicons/icons";
	import { useRouter } from "vue-router";
	import { onMounted, ref, watch } from "vue";
	import eventBus from '../eventBus';

	const router = useRouter();
	const showChangeDolar = ref(false);
	const precioDolar = ref(Number(localStorage.getItem("tasaDolar")));
	const cambioDolar = ref(precioDolar.value);
	const nuevoMontoDolar = ref<number | null>(null);

	onMounted(() => {   
		eventBus.on("precioActualizado", handlePrecioActualizado);  
		precioDolar.value = Number(localStorage.getItem("tasaDolar")) || 50;
	});  

	function handlePrecioActualizado(nuevoPrecio: number) {  
		precioDolar.value = nuevoPrecio;  
	}  

	watch(precioDolar, (newVal) => {  
		localStorage.setItem("tasaDolar", newVal.toString());  
	});  

	const cambiarPrecioDolar = (nuevoPrecio: any) => {
		const newPrice = Number(nuevoPrecio);
		if (isNaN(nuevoPrecio) || nuevoPrecio === "") {
			alert("Ingrese un valor válido");
		} else {
			precioDolar.value = newPrice;
			cambioDolar.value = newPrice;
			localStorage.setItem("tasaDolar", newPrice.toString());
			showChangeDolar.value = false;
			eventBus.emit("precioActualizado", precioDolar.value);
		}
	};

	const cancelarEdicion = () => {  
		showChangeDolar.value = false; 
		precioDolar.value = Number(localStorage.getItem("tasaDolar")) 
		nuevoMontoDolar.value = null;  
	};  
</script>

<style scoped>
	@media (width < 991px) {
		.desktop {
			display: none;
		}

		.mobile {
			display: block;
		}
	}

	@media (width > 991px) {
		.desktop {
			display: block;
		}

		.mobile {
			display: none;
		}
	}

	ion-button {
		--color: black;
	}

	ion-menu-button {
		--background-hover: rgb(106, 106, 106) !important;
		--background-hover-opacity: 0.5;
	}
</style>

<style scoped></style>
