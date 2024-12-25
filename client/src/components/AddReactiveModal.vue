<template>
	<ion-modal :is-open="isOpen" @ionModalDidClose="closeModal">
		<ion-header>
			<ion-toolbar>
				<ion-title>Añadir Reactivo</ion-title>
				<ion-buttons slot="end">
					<ion-button @click="closeModal">Cerrar</ion-button>
				</ion-buttons>
			</ion-toolbar>
		</ion-header>

		<ion-content>
			<form @submit.prevent="submit">
				<div class="form-group">
					<label for="reactiveName" class="form-label">Nombre del Reactivo</label>
					<input
						v-model="reactive.name"
						type="text"
						required
						class="form-control custom-input"
						placeholder="Ingrese el nombre del reactivo" />
				</div>
				<ion-footer>
					<ion-button expand="full" type="submit">Añadir Reactivo</ion-button>
				</ion-footer>
			</form>
		</ion-content>
	</ion-modal>
</template>

<script setup lang="ts">
	import { ref, defineEmits, onMounted, watch } from "vue";
	import { examStore } from "@/stores/examStore";
	import { IonContent, IonHeader, IonButton, IonButtons, IonTitle, IonFooter, IonToolbar, IonModal } from "@ionic/vue";

	const exams = ref();
	const examsStore = examStore();

	onMounted(async () => {
		exams.value = await examsStore.fecthExams();
	});

	const props = defineProps<{
		isOpen: boolean;
		reactive: any;
		exam: any;
	}>();
	const emit = defineEmits(["close", "add"]);

	watch(
		() => props.exam,
		async (newUser) => {
			if (newUser) {
				exams.value = await examsStore.fecthExams();
			}
		}
	);

	const reactive = ref({
		name: "",
	});

	const closeModal = () => {
		emit("close");
	};

	const submit = () => {
		emit("add", { ...reactive.value });
		reactive.value = { name: "" };
		closeModal();
	};
</script>

<style scoped>
	.modal-background {
		background-color: #121212;
		color: white;
	}

	.custom-input {
		background-color: #1e1e1e;
		border: 1px solid #444;
		border-radius: 8px;
		padding: 10px;
		font-size: 16px;
		transition: border-color 0.3s, box-shadow 0.3s;
		color: #fff;
	}

	.custom-input:focus {
		background-color: #1e1e1e;
		color: #fff;
	}

	.custom-input::placeholder {
		color: #ccc;
		opacity: 1;
	}
</style>
