<template>
	<ion-page>
		<ion-content>
			<div class="home-page">
				<div :style="{ backgroundImage: `url(${backgroundImage})` }" class="background-image">
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { ref } from "vue";
	import { IonContent, IonPage } from "@ionic/vue";

	const backgroundImage = ref("./images/laboratorio.png");
</script>

<style scoped>
	.home-page {
		position: relative;
		height: 90vh;
		overflow: hidden;
	}

	.background-image {
		background-size: cover;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
		color: white;
		text-align: center;
		width: auto;
	}

	h1 {
		color: #000;
	}
</style>
