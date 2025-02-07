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
			<form>
				<div class="form-group" v-if="props.update">
					<label class="form-label">Nombre del Perfil</label>
					<input
						v-model="selectedPerfil.name"
						type="text"
						required
						class="form-control custom-input"
						placeholder="Ingresar nuevo nombre del perfil" />
				</div>
				<div class="form-group" v-if="props.create">
					<label class="form-label">Nombre del Perfil</label>
					<input
						ref="nameInputRef"
						type="text"
						required
						class="form-control custom-input"
						placeholder="Ingresar nuevo nombre del perfil" />
				</div>

				<div class="form-group" v-if="update">
					<label class="form-label">Costo en USD</label>
					<input
						v-model.number="selectedPerfil.cost_usd"
						type="number"
						required
						class="form-control custom-input"
						placeholder="Ingresar costo en dolares" />
				</div>
				<div class="form-group" v-if="create">
					<label class="form-label">Costo en USD</label>
					<input
						ref="costUsdInputRef"
						type="number"
						required
						class="form-control custom-input"
						placeholder="Ingresar costo en dolares" />
				</div>

				<div class="form-group" v-if="update">
					<label class="form-label">Costo en BS</label>
					<input
						v-model.number="selectedPerfil.cost_bs"
						type="number"
						required
						class="form-control custom-input"
						placeholder="Ingresar costo en dolares" />
				</div>
				<div class="form-group" v-if="create">
					<label class="form-label">Costo en BS</label>
					<input
						ref="costBsInputRef"
						type="number"
						required
						class="form-control custom-input"
						placeholder="Ingresar costo en dolares" />
				</div>
				<ion-footer>
					<ion-button expand="full" @click="updatePerfil()" v-if="update">Guardar Cambios</ion-button>
					<ion-button expand="full" @click="createPerfil()" v-if="create">Crear Perfil</ion-button>
				</ion-footer>
			</form>
		</ion-content>
	</ion-modal>
</template>

<script setup lang="ts">
	import { defineEmits, ref, watch } from "vue";
	import { IonModal, IonContent, IonHeader, IonToolbar, IonButtons, IonButton, IonFooter, IonTitle } from "@ionic/vue";

	const emit = defineEmits(["close", "update", "create"]);
	const nameInputRef = ref();
	const costBsInputRef = ref();
	const costUsdInputRef = ref();

	const props = defineProps<{
		isOpen: boolean;
		perfil: any;
		update: boolean;
		create: boolean;
	}>();

	const selectedPerfil = ref();

	const newPerfil = ref<{ name: string; cost_bs: string; cost_usd: string }>({
		name: "",
		cost_bs: "",
		cost_usd: "",
	});

	const closeModal = () => {
		emit("close");
	};

	const updatePerfil = () => {
		emit("update", { ...selectedPerfil.value });
		closeModal();
	};

	const createPerfil = () => {
		newPerfil.value!.name = nameInputRef.value.value;
		newPerfil.value!.cost_usd = costUsdInputRef.value.value;
		newPerfil.value!.cost_bs = costBsInputRef.value.value;
		emit("create", { ...newPerfil.value });
		closeModal();
	};

	watch(
		() => props.perfil,
		(newPerfil) => {
			const { idProfile, name, cost_bs, cost_usd } = newPerfil;
			selectedPerfil.value = { idProfile, name, cost_bs, cost_usd };
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
