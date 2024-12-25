<template>
	<!-- <nav class="navbar navbar-expand-lg bg-body-secondary p-1">
		<button
			class="navbar-toggler"
			type="button"
			data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent"
			aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto">
				<a
					class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
					href="#">
					<img class="nav-img" src="/images/resultados.png" alt="" />
					<p class="m-0">Resultados</p>
				</a>
				<a
					class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
					href="#">
					<img class="nav-img" src="/images/especialista.png" alt="" />
					<p class="m-0">Especialista</p>
				</a>
				<a
					class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
					href="#">
					<img class="nav-img" src="/images/lista.png" alt="" />
					<p class="m-0">Precios</p>
				</a>
				<a
					class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
					href="#">
					<img class="nav-img" src="/images/reactivos.png" alt="" />
					<p class="m-0">Reactivos</p>
				</a>
				<router-link
					class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1"
					:to="{ path: '/crearOrden' }">
					<img class="nav-img" src="/images/crear_orden.png" alt="" />
					<p class="m-0">Crear Orden</p>
				</router-link>
			</ul>
		</div>
	</nav> -->
	<ion-page>
		<ion-tabs>
			<ion-tab-bar slot="top">
				<ion-tab-button tab="home">
					<ion-icon :icon="homeOutline" />
					Home
				</ion-tab-button>
				<ion-tab-button tab="reactivos">
					<ion-icon :icon="flaskOutline" />
					Reactivos
				</ion-tab-button>
				<ion-tab-button tab="crearOrden" href="/crearOrden">
					<ion-icon :icon="documentTextOutline" />
					Crear Orden
				</ion-tab-button>
			</ion-tab-bar>
			<ion-router-outlet></ion-router-outlet>
		</ion-tabs>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonTabBar, IonTabButton, IonTabs, IonIcon, IonPage, IonRouterOutlet, IonTab, IonContent } from "@ionic/vue";
	import { flaskOutline, homeOutline, documentTextOutline } from "ionicons/icons";
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

<style></style>
