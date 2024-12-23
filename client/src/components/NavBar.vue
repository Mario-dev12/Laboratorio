<template>
	<ion-header>
		<nav class="navbar navbar-expand-lg bg-dark-subtle p-1">
			<div class="container-fluid p-0">
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
				<div class="collapse navbar-collapse container" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto">
						<a
							class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
							href="#">
							<img src="/images/resultados.png" alt="" />
							<p class="m-0">Resultados</p>
						</a>
						<a
							class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
							href="#">
							<img src="/images/especialista.png" alt="" />
							<p class="m-0">Especialista</p>
						</a>
						<a
							class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
							href="#">
							<img src="/images/lista.png" alt="" />
							<p class="m-0">Precios</p>
						</a>
						<a
							class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1 border-end border-2"
							href="#">
							<img src="/images/reactivos.png" alt="" />
							<p class="m-0">Reactivos</p>
						</a>
						<router-link
							class="nav-item text-center p-1 text-decoration-none text-black align-content-center mb-1 mb-lg-0 me-lg-1"
							:to="{ path: '/crearOrden' }">
							<img src="/images/crear_orden.png" alt="" />
							<p class="m-0">Crear Orden</p>
						</router-link>
					</ul>
				</div>
			</div>
		</nav>
	</ion-header>
</template>

<script setup lang="ts">
	import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from "@ionic/vue";
</script>

<style scoped></style>
