<template>
	<ion-header>
		<nav class="navbar navbar-expand-lg bg-body-secondary p-0">
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
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<a class="nav-item bg-danger text-center p-1 text-decoration-none text-black" href="#">
							<img src="/images/resultados.png" alt="" />
							<p class="m-0">Resultados</p>
						</a>
						<a class="nav-item bg-primary text-center p-1 text-decoration-none text-black" href="#">
							<img src="/images/especialista.png" alt="" />
							<p class="m-0">Especialista</p>
						</a>
						<a class="nav-item bg-warning text-center p-1 text-decoration-none text-black" href="#">
							<img src="/images/lista.png" alt="" />
							<p class="m-0">Lista De Precios</p>
						</a>
						<a class="nav-item bg-success text-center p-1 text-decoration-none text-black" href="#">
							<img src="/images/reactivos.png" alt="" />
							<p class="m-0">Reactivos</p>
						</a>
						<router-link class="nav-item bg-info text-center p-1 text-decoration-none text-black" :to="{ path: '/crearOrden' }">
							<img src="/images/reactivos.png" alt="" />
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
