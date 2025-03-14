<template>
	<ion-page>
		<ion-content>
			<div class="home-page">
				<div :style="{ backgroundImage: `url(${backgroundImage})` }" class="background-image">
					<h1>Bienvenido al Laboratorio Clínico Madre Emilia</h1>
					<!-- Puedes agregar más contenido aquí -->
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { ref } from "vue";
	import { IonContent, IonPage } from "@ionic/vue";

	const backgroundImage = ref("./images/logo.jpg");
</script>

<style scoped>
	.home-page {
		position: relative;
		height: 100vh;
		overflow: hidden;
	}

	.background-image {
		background-size: cover;
		background-position: center;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
		color: white;
		text-align: center;
	}

	h1 {
		color: #000;
	}
</style>
