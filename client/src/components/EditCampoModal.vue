<template>
	<ion-modal :is-open="isOpen" @did-dismiss="closeModal">
		<ion-header>
			<ion-toolbar>
				<ion-title>Editar Campo</ion-title>
				<ion-buttons slot="end">
					<ion-button @click="closeModal">Cerrar</ion-button>
				</ion-buttons>
			</ion-toolbar>
		</ion-header>

		<ion-content>
			<form @submit.prevent="submit">
				<div class="form-group">
					<label class="form-label">Nombre</label>
					<input
						v-model="form.nombre"
						type="text"
						required
						class="form-control custom-input"
						placeholder="Ingrese el nombre" />
				</div>
                <div class="form-group">
					<label for="examSelect" class="form-label">Unidad</label>
					<select v-model="form.unidad" class="form-select custom-input">
						<option v-for="unidad in unidades" :key="unidad.unidad" :value="unidad.unidad">
							{{ unidad.unidad }}
						</option>
					</select>
				</div>
                <div class="form-group">
					<label class="form-label">Valor Referencial</label>
					<input
						v-model="form.valor_referencial"
						type="text"
						class="form-control custom-input"
						placeholder="Ingrese el nombre" />
				</div>
                <div class="form-group">
					<label class="form-label">Calculado</label>
					<input
						v-model="form.calculado"
						type="text"
						class="form-control custom-input"
						placeholder="Ingrese el nombre" />
				</div>
				<ion-footer>
					<ion-button expand="full" type="submit">Guardar Cambios</ion-button>
				</ion-footer>
			</form>
		</ion-content>
	</ion-modal>
</template>

<script setup lang="ts">
	import { IonModal, IonButton, IonContent, IonFooter, IonHeader, IonToolbar, IonTitle, IonButtons } from "@ionic/vue";
	import { reactiveStore } from "@/stores/reactiveStore";
    import { profileStore } from "@/stores/profileStore";
	import { ref, defineEmits, watch, onMounted } from "vue";
	const campoData = ref();
    const unidades = ref();
	const reactivesStore = reactiveStore();
    const tests = profileStore();

	const props = defineProps<{
		isOpen: boolean;
		campo: any;
	}>();

	const emit = defineEmits(["close", "update"]);

	const campos = ref();
	const form = ref({
		idCampo: 0,
		nombre: "",
        unidad: "",
        valor_referencial: "",
        calculado: "",
        oId: 0
	});

	watch(
		() => props.campo,
		async (newUser) => {
			campoData.value = await reactivesStore.fecthCampo();
			if (newUser) {
				campos.value = newUser;
				form.value.idCampo = newUser.idCampo;
				form.value.nombre = newUser.nombre;
				form.value.unidad = newUser.unidad;
				form.value.valor_referencial = newUser.valor_referencial;
				form.value.calculado = newUser.calculado;
                form.value.oId = newUser.idCampo
			}
		}
	);

	onMounted(async () => {
		campoData.value = await reactivesStore.fecthCampo();
        unidades.value = await tests.fecthProfilesInputUnits();
	});

	const closeModal = () => {
		emit("close");
	};

	const submit = () => {
        if (form.value.unidad === null || form.value.unidad === 'null'){
            form.value.unidad = ''
        }
		emit("update", { ...form.value });
		closeModal();
	};
</script>

<style scoped>
	.custom-input {
		border: 1px solid #444;
		border-radius: 8px;
		padding: 10px;
		font-size: 16px;
	}

	.radio-input {
		margin-right: 5px;
	}

	.radio-label {
		margin-right: 20px;
	}
</style>
