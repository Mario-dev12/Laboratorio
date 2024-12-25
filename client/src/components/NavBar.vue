<template>
	<ion-page>
		<ion-tabs>
			<ion-tab-bar class="bg-secondary" slot="top">
				<ion-tab-button class="border-end border-black" tab="home" href="HomeView">
					<ion-icon :icon="home" />
					Home
				</ion-tab-button>
				<ion-tab-button class="border-end border-black" tab="reactivos" href="reactivos">
					<ion-icon :icon="flask" />
					Reactivos
				</ion-tab-button>
				<ion-tab-button class="" tab="crearOrden" href="crearOrden">
					<ion-icon :icon="document" />
					Crear Orden
				</ion-tab-button>
			</ion-tab-bar>
			<ion-router-outlet></ion-router-outlet>
		</ion-tabs>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonTabBar, IonTabButton, IonTabs, IonIcon, IonPage, IonRouterOutlet, IonTab, IonContent } from "@ionic/vue";
	import { flask, home, document } from "ionicons/icons";
</script>

<style scoped>
	@media (max-width: 991px) {
		.navbar {
			padding: 2px !important;
		}
		#navbarSupportedContent {
			border-top-right-radius: 50px;
			border-bottom-right-radius: 50px;
			margin-right: auto;
			background-color: rgb(201, 201, 201);
			position: absolute;
			top: 100%;
			bottom: -916px;
			left: 0;
			right: 40%;
			padding: 8px;
		}

		.navbar-toggler {
			display: block !important;
		}

		.nav-item {
			display: flex;
			align-items: center;
			border-right: none !important;
		}

		.nav-img {
			margin-right: 10px;
		}

		.navbar-nav a:not(:last-child) {
			border-bottom: 1px solid white !important;
		}

		.navbar-nav a {
			padding: 10px !important;
		}

		.navbar-toggler:focus {
			box-shadow: 1px 1px gray !important;
		}
	}
</style>

<style scoped></style>
