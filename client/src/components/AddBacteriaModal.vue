<template>
	<ion-modal :is-open="isOpen" @did-dismiss="closeModal">
		<ion-header>
			<ion-toolbar>
				<ion-title>Añadir Bacteria</ion-title>
				<ion-buttons slot="end">
					<ion-button @click="closeModal">Cerrar</ion-button>
				</ion-buttons>
			</ion-toolbar>
		</ion-header>

		<ion-content>
			<form @submit.prevent="submit">
				<div class="form-group">
					<label for="bacteriaName" class="form-label">Nombre de la Bacteria</label>
					<input
						v-model="bacteria.name"
						type="text"
						required
						class="form-control custom-input"
						placeholder="Ingrese el nombre de la bacteria" />
				</div>
				<ion-footer>
					<ion-button expand="full" type="submit">Añadir Bacteria</ion-button>
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
		bacteria: any;
	}>();
	const emit = defineEmits(["close", "add"]);

	watch(
		() => props.bacteria,
		async (newUser) => {
			if (newUser) {
			
			}
		}
	);

	const bacteria = ref({
		name: "",
	});

	const closeModal = () => {
		emit("close");
	};

	const submit = () => {
		emit("add", { ...bacteria.value });
		bacteria.value = { name: "" };
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
