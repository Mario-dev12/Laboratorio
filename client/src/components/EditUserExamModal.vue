<template>
	<ion-modal :is-open="isOpen" @did-dismiss="closeModal">
		<ion-header>
			<ion-toolbar>
				<ion-title>Editar Perfil</ion-title>
				<ion-buttons slot="end">
					<ion-button @click="closeModal">Cerrar</ion-button>
				</ion-buttons>
			</ion-toolbar>
		</ion-header>

		<ion-content>
			<form @submit.prevent="submit">
				<div class="form-group">
					<label class="form-label">Nombre del Perfil</label>
					<input
						v-model="updatedPerfil.name"
						type="text"
						required
						class="form-control custom-input"
						placeholder="Ingresar nuevo nombre del perfil" />
				</div>
				<div class="form-group">
					<label class="form-label">Costo en USD</label>
					<input
						v-model.number="updatedPerfil.cost_usd"
						type="number"
						required
						class="form-control custom-input"
						placeholder="Ingresar costo en dolares" />
				</div>
				<div class="form-group">
					<label class="form-label">Costo en BS</label>
					<input
						v-model.number="updatedPerfil.cost_bs"
						type="number"
						required
						class="form-control custom-input"
						placeholder="Ingresar costo en dolares" />
				</div>
				<ion-footer>
					<ion-button expand="full" type="submit">Guardar Cambios</ion-button>
				</ion-footer>
			</form>
		</ion-content>
	</ion-modal>
</template>

<script setup lang="ts">
	import { defineEmits, ref, watch } from "vue";
	import { IonModal, IonContent, IonHeader, IonToolbar, IonButtons, IonButton, IonFooter, IonTitle } from "@ionic/vue";

	const emit = defineEmits(["close", "update"]);

	const props = defineProps<{
		isOpen: boolean;
		perfil: any;
	}>();

	const updatedPerfil = ref();

	const closeModal = () => {
		emit("close");
	};

	const submit = () => {
		emit("update", { ...updatedPerfil.value });
		closeModal();
	};

	watch(
		() => props.perfil,
		(newPerfil) => {
			console.log(newPerfil);
			updatedPerfil.value = newPerfil;
			console.log(updatedPerfil.value);
		}
	);
</script>

<style scoped>
	.custom-input {
		border: 1px solid #444;
		border-radius: 8px;
		padding: 10px;
		font-size: 16px;
		color: #fff;
	}
</style>
