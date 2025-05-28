<template>
	<ion-page>
		<ion-content>
			<div class="container mt-3">
				<h2 class="text-center mb-4">Lista de Envios</h2>

				<div class="d-flex justify-content-end mb-3">
					<ion-button @click="showAllianceModal" color="primary">+ Envio</ion-button>
				</div>

				<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Nombre del Reactivo</th>
								<th>Proveedor</th>
								<th>Cantidad</th>
								<th>Fecha Envío</th>
								<th>Costo Bs</th>
								<th>Costo $</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="reactive in reactives" :key="reactive.idreactive">
								<td>{{ reactive.name }}</td>
								<td>{{ reactive.providerName }}</td>
								<td>{{ reactive.providerQuantity }}</td>
								<td>{{ formatearFecha(reactive.createdDate) }}</td>
								<td>{{ reactive.cost_bs }} bs</td>
								<td>{{ reactive.cost_usd }} $</td>
								<td>
									<i class="fas fa-edit" @click="editAlliance(reactive)" style="cursor: pointer; margin-right: 10px"></i>
									<i class="fas fa-trash" @click="deleteAlliance(reactive.idAlliance)" style="cursor: pointer"></i>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="container mt-3">
					<h2 class="text-center mb-4">Lista de Reactivos</h2>
					<div class="d-flex justify-content-end mb-3">
						<ion-button @click="showModal" color="primary">+ Reactivo</ion-button>
					</div>
					<div class="d-flex justify-content-between">
						<div class="table-responsive" style="max-height: 400px; overflow-y: auto; flex: 1">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>Nombre del Reactivo</th>
										<th>Cantidad Existencia</th>
										<th>Acciones</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="reactive in allReactives" :key="reactive.idreactive">
										<td>{{ reactive.name }}</td>
										<td>{{ reactive.total }}</td>
										<td>
											<i class="fas fa-edit" @click="editReactive(reactive)" style="cursor: pointer; margin-right: 10px"></i>
											<i class="fas fa-trash" @click="deleteReactive(reactive.idReactive)" style="cursor: pointer"></i>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="container mt-3">
					<h2 class="text-center mb-4">Lista de Proveedores</h2>
					<div class="d-flex justify-content-end mb-3">
						<ion-button @click="showProvidersModal" color="primary">+ Proveedor</ion-button>
					</div>
					<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Nombre del Proveedor</th>
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="provider in providers" :key="provider.idprovider">
									<td>{{ provider.name }}</td>
									<td>
										<i class="fas fa-edit" @click="editProvider(provider)" style="cursor: pointer; margin-right: 10px"></i>
										<i class="fas fa-trash" @click="deleteProvider(provider.idProvider)" style="cursor: pointer"></i>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="container mt-3">
					<h2 class="text-center mb-4">Lista de Campos</h2>
					<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Campo</th>
									<th>Unidad</th>
									<th>Valor Referencial</th>
									<th>Calculado</th>
									<th>Acciones</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="campos in campo" :key="campos.idcampo">
									<td>{{ campos.nombre }}</td>
									<td>{{ campos.unidad }}</td>
									<td>{{ campos.valor_referencial }}</td>
									<td>{{ campos.calculado }}</td>
									<td>
										<i class="fas fa-edit" @click="editCampo(campos)" style="cursor: pointer; margin-right: 10px"></i>
										<i class="fas fa-trash" @click="deleteCampo(campos.idCampo)" style="cursor: pointer"></i>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<AddReactiveModal
					:is-open="isModalOpen"
					:reactive="allReactives"
					:exam="exams"
					@close="isModalOpen = false"
					@add="addReactiveToList" />

				<AddProviderModal
					:is-open="isProvidersModalOpen"
					:provider="providers"
					@close="closeProvidersModal"
					@add="addProviderToList" />

				<AddShipmentModal
					:is-open="isAllianceModalOpen"
					:alliance="reactives"
					:provider="providers"
					@close="isAllianceModalOpen = false"
					@add="addShipmentToList" />

				<EditProviderModal
					:is-open="isEditProviderModalOpen"
					:provider="selectedProvider"
					@close="isEditProviderModalOpen = false"
					@update="updateProviderInList" />

				<EditCampoModal
					:is-open="isEditCampoModalOpen"
					:campo="selectedCampo"
					@close="isEditCampoModalOpen = false"
					@update="updateCampoInList" />

				<EditAllianceModal
					:is-open="isEditAllianceModalOpen"
					:alliance="selectedAlliance"
					@close="isEditAllianceModalOpen = false"
					@update="updateAllianceInList" />

				<EditReactiveModal
					:is-open="isEditModalOpen"
					:reactive="selectedReactive"
					@close="isEditModalOpen = false"
					@update="updateReactiveInList" />

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
	import { Alliance, Provider, Reactive } from "@/interfaces/interfaces";
	import { reactiveStore } from "@/stores/reactiveStore";
	import { onMounted, ref } from "vue";
	import AddReactiveModal from "@/components/AddReactiveModal.vue";
	import EditReactiveModal from "@/components/EditReactiveModal.vue";
	import AddProviderModal from "@/components/AddProviderModal.vue";
	import AddShipmentModal from "@/components/AddShipmentModal.vue";
	import EditProviderModal from "@/components/EditProviderModal.vue";
	import EditCampoModal from "@/components/EditCampoModal.vue";
	import EditAllianceModal from "@/components/EditAllianceModal.vue";
	import { providerStore } from "@/stores/providerStore";
	import { allianceStore } from "@/stores/allianceStore";
	import { examStore } from "@/stores/examStore";
	import { IonToast } from "@ionic/vue";
	import { useRouter } from "vue-router";

	const reactives = ref();
	const providers = ref();
	const allReactives = ref();
	const campo = ref();
	const exams = ref();
	const reactivesStore = reactiveStore();
	const providersStore = providerStore();
	const alliancesStore = allianceStore();
	const examsStore = examStore();
	const isModalOpen = ref(false);
	const isProvidersModalOpen = ref(false);
	const isAllianceModalOpen = ref(false);
	const selectedReactive = ref();
	const selectedAlliance = ref();
	const selectedProvider = ref();
	const selectedCampo = ref();
	const isEditModalOpen = ref(false);
	const isEditAllianceModalOpen = ref(false);
	const isEditProviderModalOpen = ref(false);
	const isEditCampoModalOpen = ref(false);
	const router = useRouter();
	const toast = ref({
		isOpen: false,
		message: "",
		duration: 2000,
	});

	onMounted(async () => {
		[reactives.value, providers.value, allReactives.value, exams.value, campo.value] = await Promise.all([
			reactivesStore.fetchReactiveByProvider(),
			providersStore.fecthProviders(),
			reactivesStore.fecthReactives(),
			examsStore.fecthExams(),
			reactivesStore.fecthCampo(),
		]);
	});

	router.beforeEach(async (to, from, next) => {
		if (to.name === "Reactivos") {
			[reactives.value, providers.value, allReactives.value, exams.value, campo.value] = await Promise.all([
				reactivesStore.fetchReactiveByProvider(),
				providersStore.fecthProviders(),
				reactivesStore.fecthReactives(),
				examsStore.fecthExams(),
				reactivesStore.fecthCampo(),
			]);
		}
		next();
	});

	const showToast = (message: string) => {
		toast.value.message = message;
		toast.value.isOpen = true;
	};

	const editReactive = (reactive: any) => {
		selectedReactive.value = { ...reactive };
		selectedReactive.value = reactive;
		isEditModalOpen.value = true;
	};

	const editAlliance = (alliance: any) => {
		selectedAlliance.value = { ...alliance };
		selectedAlliance.value = alliance;
		isEditAllianceModalOpen.value = true;
	};

	const editProvider = (provider: any) => {
		selectedProvider.value = { ...provider };
		selectedProvider.value = provider;
		isEditProviderModalOpen.value = true;
	};

	const editCampo = (campo: any) => {
		selectedCampo.value = { ...campo };
		selectedCampo.value = campo;
		isEditCampoModalOpen.value = true;
	};

	const updateReactiveInList = async (updatedReactive: Reactive) => {
		const id = updatedReactive.idreactive;
		await reactivesStore.updateReactive(id, updatedReactive);
		showToast("Reactivo actualizado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const updateAllianceInList = async (updatedAlliance: Alliance) => {
		const id = updatedAlliance.idalliance;
		await alliancesStore.updateAlliance(id, updatedAlliance);
		showToast("Alianza actualizada correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const updateProviderInList = async (updatedProvider: Provider) => {
		const id = updatedProvider.idprovider;
		await providersStore.updateProvider(id, updatedProvider);
		showToast("Proveedor actualizado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const updateCampoInList = async (updatedCampo: any) => {
		const id = updatedCampo.oId;
		await reactivesStore.updateCampo(id, updatedCampo);
		showToast("Campo actualizado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const deleteReactive = async (id: number | string) => {
		await reactivesStore.deleteReactive(id);
		showToast("Reactivo borrado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const deleteAlliance = async (id: number | string) => {
		await alliancesStore.deleteAlliance(id);
		showToast("Alianza borrada correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const deleteProvider = async (id: number | string) => {
		await providersStore.deleteProvider(id);
		showToast("Proveedor borrado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const deleteCampo = async (id: number | string) => {
		await reactivesStore.deleteCampo(id);
		showToast("Campo borrado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const addReactiveToList = async (newReactive: Reactive) => {
		await reactivesStore.createReactive(newReactive);
		showToast("Reactivo creado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const addProviderToList = async (newProvider: Provider) => {
		const resp = await providersStore.createProvider(newProvider);
		showToast("Proveedor creado correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const addShipmentToList = async (newShipment: Alliance) => {
		await alliancesStore.createAlliance(newShipment);
		showToast("Alianza creada correctamente");
		reactives.value = await reactivesStore.fetchReactiveByProvider();
		providers.value = await providersStore.fecthProviders();
		allReactives.value = await reactivesStore.fecthReactives();
		campo.value = await reactivesStore.fecthCampo();
	};

	const showModal = async () => {
		isModalOpen.value = true;
	};

	const showProvidersModal = async () => {
		isProvidersModalOpen.value = true;
	};

	const closeProvidersModal = () => {
		isProvidersModalOpen.value = false;
	};

	const showAllianceModal = async () => {
		isAllianceModalOpen.value = true;
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
</style>
