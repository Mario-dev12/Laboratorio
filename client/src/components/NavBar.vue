<template>
	<div class="desktop">
		<ion-header>
			<ion-toolbar>
				<ion-title slot="end"> Lab Madre Emilia </ion-title>
				<ion-buttons>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'Home' })">
						<ion-icon slot="start" :icon="home"></ion-icon>
						Home
					</ion-button>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'Reactivos' })">
						<ion-icon slot="start" :icon="flask"></ion-icon>
						Reactivos
					</ion-button>
					<ion-button class="border-end border-secondary" @click="() => router.push({ name: 'CrearOrden' })">
						<ion-icon slot="start" :icon="document"></ion-icon>
						Crear Orden
					</ion-button>
					<ion-button @click="() => router.push({ name: 'Caja' })">
						<ion-icon slot="start" :icon="calculator"></ion-icon>
						Caja
					</ion-button>
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
					<ion-button fill="clear" class="" @click="() => router.push({ name: 'Reactivos' })">
						<ion-icon slot="start" :icon="flask"></ion-icon>
						Reactivos
					</ion-button>
					<ion-button fill="clear" @click="() => router.push({ name: 'CrearOrden' })">
						<ion-icon slot="start" :icon="document"></ion-icon>
						Crear Orden
					</ion-button>
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
	import { flask, home, document, closeOutline, calculator } from "ionicons/icons";
	import { useRouter } from "vue-router";

	const router = useRouter();
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
