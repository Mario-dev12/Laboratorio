<template>
	<ion-header>
		<nav class="navbar navbar-expand-lg bg-body-secondary p-1 d-block position-relative">
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
		</nav>
	</ion-header>
</template>

<script setup lang="ts">
	import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from "@ionic/vue";
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
			top: 120%;
			left: 0;
			right: 50%;
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

		.nav-item {
			border-bottom: 1px solid white !important;
			padding: 10px !important;
		}

		.navbar-nav :last-child {
			border-bottom: none !important;
		}

		.navbar-toggler:focus {
			box-shadow: 1px 2px gray !important;
		}
	}
</style>
