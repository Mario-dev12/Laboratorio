<template>
	<ion-page>
		<ion-content>
			<div class="home-page text-center">
				<img class="background-image" src="/images/icono.png" alt="" />
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonContent, IonPage } from "@ionic/vue";
</script>

<style scoped>
	.home-page {
		position: relative;
		height: 90vh;
		overflow: hidden;
		padding-top: 10px;
	}

	.background-image {
		height: 100%;
	}

	h1 {
		color: #000;
	}
</style>
