<template>
	<ion-page>
		<ion-content>
			<div class="container mt-3">
				<h2 class="text-center mb-4">Lista de Antibioticos</h2>

				<div class="d-flex justify-content-end mb-3">
					<ion-button @click="showAntibioticsModal" color="primary">+ Antibiotico</ion-button>
				</div>

				<div class="table-responsive div-table">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Nombre del Antibiotico</th>
								<th>Fecha Creación</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="antibiotic in antibiotics" :key="antibiotic.idAntibiotico">
								<td>{{ antibiotic.nombre }}</td>
								<td>{{ formatearFecha(antibiotic.createdDate) }}</td>
								<td>
									<i class="fas fa-edit" @click="editAntibiotics(antibiotic)" style="cursor: pointer; margin-right: 10px"></i>
									<i class="fas fa-trash" @click="deleteAntibiotics(antibiotic.idAntibiotico)" style="cursor: pointer"></i>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="container mt-3">
					<h2 class="text-center mb-4">Lista de Bacterias</h2>
					<div class="d-flex justify-content-end mb-3">
						<ion-button @click="showBacteriaModal" color="primary">+ Bacteria</ion-button>
					</div>
					<div class="d-flex justify-content-between">
						<div class="table-responsive" style="max-height: 400px; overflow-y: auto; flex: 1">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>Nombre Bacteria</th>
										<th>Fecha Creación</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="bacteria in bacterias" :key="bacteria.idbacteria">
										<td>{{ bacteria.nombre }}</td>
										<td>{{ formatearFecha(bacteria.createdDate) }}</td>
										<td>
											<i class="fas fa-edit" @click="editBacteria(bacteria)" style="cursor: pointer; margin-right: 10px"></i>
											<i class="fas fa-trash" @click="deleteBacteria(bacteria.idBacteria)" style="cursor: pointer"></i>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<AddAntibioticsModal
					:is-open="isAntibioticsModalOpen"
					:antibiotic="antibiotics"
					@close="closeAntibioticsModal"
					@add="addAntibioticsToList" />
				<AddBacteriaModal
					:is-open="isBacteriaModalOpen"
					:bacteria="bacterias"
					@close="closeBacteriaModal"
					@add="addBacteriaToList" />
				<EditAntibioticsModal
					:is-open="isEditAntibioticsModalOpen"
					:provider="selectedAntibiotics"
					@close="isEditAntibioticsModalOpen = false"
					@update="updateAntibioticsInList" />
				<EditBacteriaModal
					:is-open="isEditBacteriaModalOpen"
					:provider="selectedBacteria"
					@close="isEditBacteriaModalOpen = false"
					@update="updateBacteriaInList" />
				<IonToast
					:is-open="toast.isOpen"
					:message="toast.message"
					:duration="toast.duration"
					@on-did-dismiss="toast.isOpen = false"
					@did-dismiss="toast.isOpen = false" />
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonButton, IonContent, IonPage } from "@ionic/vue";
	import EditAntibioticsModal from "@/components/EditAntibioticsModal.vue";
	import EditBacteriaModal from "@/components/EditBacteriaModal.vue";
	import AddAntibioticsModal from "@/components/AddAntibioticsModal.vue";
	import AddBacteriaModal from "@/components/AddBacteriaModal.vue";
	import { Antibiotics, Bacteria } from "@/interfaces/interfaces";
	import { reactiveStore } from "@/stores/reactiveStore";
	import { onMounted, ref } from "vue";
	import { providerStore } from "@/stores/providerStore";
	import { examStore } from "@/stores/examStore";
	import { IonToast } from "@ionic/vue";
	import { profileStore } from "@/stores/profileStore";
	import { useRouter } from "vue-router";

	const reactives = ref();
	const antibiotics = ref();
	const bacterias = ref();
	const providers = ref();
	const allReactives = ref();
	const exams = ref();
	const reactivesStore = reactiveStore();
	const providersStore = providerStore();
	const examsStore = examStore();
	const isAntibioticsModalOpen = ref(false);
	const isBacteriaModalOpen = ref(false);
	const selectedBacteria = ref();
	const selectedAntibiotics = ref();
	const isEditBacteriaModalOpen = ref(false);
	const isEditAntibioticsModalOpen = ref(false);
	const profilesStore = profileStore();
	const router = useRouter();
	const toast = ref({
		isOpen: false,
		message: "",
		duration: 2000,
	});

	onMounted(async () => {
		try {
			const [reactivesData, providersData, allReactivesData, examsData, antibioticsData, bacteriasData] = await Promise.all([
				reactivesStore.fetchReactiveByProvider(),
				providersStore.fecthProviders(),
				reactivesStore.fecthReactives(),
				examsStore.fecthExams(),
				profilesStore.fecthAntibiotics(),
				profilesStore.fecthBacterium(),
			]);

			reactives.value = reactivesData;
			providers.value = providersData;
			allReactives.value = allReactivesData;
			exams.value = examsData;
			antibiotics.value = antibioticsData;
			bacterias.value = bacteriasData;
		} catch (error) {
			console.error("Error al cargar datos:", error);
			showToast("Hubo un problema al cargar los datos.");
		}
	});

	router.beforeEach(async (to, from, next) => {
		if (to.name === "Antibioticos") {
			try {
				const [reactivesData, providersData, allReactivesData, examsData, antibioticsData, bacteriasData] = await Promise.all([
					reactivesStore.fetchReactiveByProvider(),
					providersStore.fecthProviders(),
					reactivesStore.fecthReactives(),
					examsStore.fecthExams(),
					profilesStore.fecthAntibiotics(),
					profilesStore.fecthBacterium(),
				]);

				reactives.value = reactivesData;
				providers.value = providersData;
				allReactives.value = allReactivesData;
				exams.value = examsData;
				antibiotics.value = antibioticsData;
				bacterias.value = bacteriasData;
			} catch (error) {
				console.error("Error al cargar datos:", error);
				showToast("Hubo un problema al cargar los datos.");
			}
		}
		next();
	});

	const showToast = (message: string) => {
		toast.value.message = message;
		toast.value.isOpen = true;
	};

	const editBacteria = (bacteria: any) => {
		selectedBacteria.value = { ...bacteria };
		selectedBacteria.value = bacteria;
		isEditBacteriaModalOpen.value = true;
	};

	const editAntibiotics = (antibiotics: any) => {
		selectedAntibiotics.value = { ...antibiotics };
		selectedAntibiotics.value = antibiotics;
		isEditAntibioticsModalOpen.value = true;
	};

	const updateBacteriaInList = async (updatedBacteria: any) => {
		const id = updatedBacteria.idBacteria;
		await profilesStore.updateBacterium(id, updatedBacteria);
		showToast("Bacteria actualizada correctamente");
		antibiotics.value = await profilesStore.fecthAntibiotics();
		bacterias.value = await profilesStore.fecthBacterium();
	};

	const updateAntibioticsInList = async (updatedAntibiotics: any) => {
		const id = updatedAntibiotics.idAntibiotico;
		await profilesStore.updateAntibiotics(id, updatedAntibiotics);
		showToast("Antibiotico actualizado correctamente");
		antibiotics.value = await profilesStore.fecthAntibiotics();
		bacterias.value = await profilesStore.fecthBacterium();
	};

	const deleteBacteria = async (id: number | string) => {
		await profilesStore.deleteBacterium(id);
		showToast("Bacteria borrado correctamente");
		antibiotics.value = await profilesStore.fecthAntibiotics();
		bacterias.value = await profilesStore.fecthBacterium();
	};

	const deleteAntibiotics = async (id: number | string) => {
		await profilesStore.deleteAntibiotics(id);
		showToast("Antibiotico borrada correctamente");
		antibiotics.value = await profilesStore.fecthAntibiotics();
		bacterias.value = await profilesStore.fecthBacterium();
	};

	const addBacteriaToList = async (newBacteria: Bacteria) => {
		await profilesStore.createBacteria(newBacteria);
		showToast("Bacteria creado correctamente");
		antibiotics.value = await profilesStore.fecthAntibiotics();
		bacterias.value = await profilesStore.fecthBacterium();
	};

	const addAntibioticsToList = async (newAntibiotics: Antibiotics) => {
		const resp = await profilesStore.createAntibiotics(newAntibiotics);
		showToast("Antibiotico creado correctamente");
		antibiotics.value = await profilesStore.fecthAntibiotics();
		bacterias.value = await profilesStore.fecthBacterium();
	};

	const showAntibioticsModal = async () => {
		isAntibioticsModalOpen.value = true;
	};

	const closeAntibioticsModal = () => {
		isAntibioticsModalOpen.value = false;
	};

	const showBacteriaModal = async () => {
		isBacteriaModalOpen.value = true;
	};

	const closeBacteriaModal = () => {
		isBacteriaModalOpen.value = false;
	};

	function formatearFecha(fecha: string | number | Date) {
		const fechaObjeto = new Date(fecha);

		const dia = String(fechaObjeto.getDate()).padStart(2, "0");
		const mes = String(fechaObjeto.getMonth() + 1).padStart(2, "0");
		const año = fechaObjeto.getFullYear();

		return `${dia}-${mes}-${año}`;
	}
</script>

<style scoped>
	.container {
		padding: 16px;
	}

	.table-responsive {
		max-height: 400px;
	}

	.btn-container {
		display: flex;
		justify-content: flex-end;
		margin-bottom: 1rem;
	}

	.div-table {
		max-height: 400px;
		overflow-y: auto;
	}
</style>
