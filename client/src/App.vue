<template>
	<ion-app>
		<ion-router-outlet></ion-router-outlet>
	</ion-app>
</template>

<script setup lang="ts">
	import { IonApp, IonRouterOutlet, IonPage, IonContent, IonHeader } from "@ionic/vue";
	import NavBar from "./components/NavBar.vue";
</script>

<style scoped></style>
