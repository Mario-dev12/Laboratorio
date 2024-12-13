<template>
	<ion-app>
		<NavBar />
		<ion-content>
			<ion-router-outlet />
		</ion-content>
	</ion-app>
</template>

<script setup lang="ts">
	import { IonApp, IonRouterOutlet, IonContent } from "@ionic/vue";
	import NavBar from "./components/NavBar.vue";
</script>
