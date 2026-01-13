<template>
	<ion-modal :is-open="isOpen" @did-dismiss="closeModal">
		<ion-header>
			<ion-toolbar>
				<ion-title>Añadir Antibiotico</ion-title>
				<ion-buttons slot="end">
					<ion-button @click="closeModal">Cerrar</ion-button>
				</ion-buttons>
			</ion-toolbar>
		</ion-header>

		<ion-content>
			<form @submit.prevent="submit">
				<div class="form-group">
					<label for="antibioticsName" class="form-label">Nombre del Antibiotico</label>
					<input
						v-model="antibiotics.name"
						type="text"
						required
						class="form-control custom-input"
						placeholder="Ingrese el nombre del antibiotico" />
				</div>
				<ion-footer>
					<ion-button expand="full" type="submit">Añadir Antibiotico</ion-button>
				</ion-footer>
			</form>
		</ion-content>
	</ion-modal>
</template>

<script setup lang="ts">
	import { ref, defineEmits, watch } from "vue";
	import { IonModal, IonButton, IonContent, IonFooter, IonHeader, IonToolbar, IonTitle, IonButtons } from "@ionic/vue";

	const props = defineProps<{
		isOpen: boolean;
		antibiotic: any;
	}>();
	const emit = defineEmits(["close", "add"]);

	watch(
		() => props.antibiotic,
		async (newUser) => {
			if (newUser) {
				
			}
		}
	);

	const antibiotics = ref({
		name: "",
	});

	const closeModal = () => {
		emit("close");
	};

	const submit = () => {
		emit("add", { ...antibiotics.value });
		antibiotics.value = { name: "" };
		closeModal();
	};
</script>

<style scoped>
	.modal-background {
		background-color: #121212;
		color: white;
	}

	.custom-input {
		border: 1px solid #444;
		border-radius: 8px;
		padding: 10px;
		font-size: 16px;
		transition: border-color 0.3s, box-shadow 0.3s;
	}
</style>
