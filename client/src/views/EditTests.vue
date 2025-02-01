<template>
	<ion-page>
		<ion-content>
			<div class="container">
				<div>
					<h1 class="mb-4 text-center mt-4">Perfiles</h1>
				</div>
				<div class="d-flex justify-content-end mb-3">
					<ion-button @click="createPerfil" color="primary">+ Perfil</ion-button>
				</div>
				<table class="table table-striped text-center">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Name</th>
							<th scope="col">Cost $</th>
							<th scope="col">Cost Bs</th>
							<th scope="col">Acciones</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="perfil in perfiles" :key="perfil.idProfile">
							<td>{{ perfil.idProfile }}</td>
							<td>
								{{ perfil.name }}
							</td>

							<td>${{ perfil.cost_usd }}</td>

							<td>Bs{{ perfil.cost_bs }}</td>

							<td class="align-middle">
								<i class="fas fa-edit" style="cursor: pointer; margin-right: 10px" @click="editPerfil(perfil)"></i>
								<i class="fas fa-trash" style="cursor: pointer" @click="deletePerfil(perfil.idProfile)"></i>
							</td>
						</tr>
					</tbody>
				</table>
				<EditTestsModal
					:is-open="modalOpen"
					:perfil="selectedPerfil"
					:create="create"
					:update="update"
					@close="modalOpen = false"
					@update="updatePerfil"
					@create="addNewPerfil" />
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonContent, IonPage, IonButton } from "@ionic/vue";
	import { onMounted, ref } from "vue";
	import { profileStore } from "@/stores/profileStore";
	import { Profile } from "@/interfaces/interfaces";
	import EditTestsModal from "@/components/EditTestsModal.vue";

	const modalOpen = ref(false);
	const selectedPerfil = ref();
	const tests = profileStore();
	const perfiles = ref<Profile[]>([]);
	const create = ref(false);
	const update = ref(false);

	onMounted(async () => {
		perfiles.value = await tests.fecthProfiles();
		console.log(perfiles.value);
	});

	function editPerfil(perfil: any) {
		selectedPerfil.value = perfil;
		create.value = false;
		update.value = true;
		modalOpen.value = true;
	}

	const updatePerfil = async (updatedPerfil: Profile) => {
		console.log(updatedPerfil.idProfile);
		await tests.updateProfile(updatedPerfil.idProfile, updatedPerfil);
		perfiles.value = await tests.fecthProfiles();
	};

	function createPerfil() {
		create.value = true;
		update.value = false;
		modalOpen.value = true;
	}

	async function addNewPerfil(newPerfil: Profile) {
		console.log(newPerfil);
		await tests.createProfile(newPerfil);
		perfiles.value = await tests.fecthProfiles();
	}

	async function deletePerfil(idperfil: number) {
		console.log(idperfil);
		if (confirm("Borrar Perfil?")) {
			await tests.deleteProfile(idperfil);
			perfiles.value = await tests.fecthProfiles();
		}
	}
</script>

<style scoped>
	.perfiles:not(:last-child) {
		margin-bottom: 15px;
	}
</style>
