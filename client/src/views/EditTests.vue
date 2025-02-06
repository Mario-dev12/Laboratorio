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

							<td>$ {{ perfil.cost_usd }}</td>

							<td>Bs {{ perfil.cost_bs }}</td>

							<td class="align-middle">
								<i class="fas fa-edit" style="cursor: pointer; margin-right: 10px" @click="editPerfil(perfil)"></i>
								<i class="fas fa-trash" style="cursor: pointer" @click="deletePerfil(perfil.idProfile)"></i>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="editar-perfil mt-4">
					<h1 class="text-center">Perfil Nuevo</h1>
					<div class="informacion-perfil bg-dark-subtle rounded p-3">
						<div class="w-100 m-auto row px-2 mb-3">
							<label class="col-12 p-0" for="documento">Nombre Del Perfil</label>
							<input class="col-12" type="text" placeholder="Nombre" ref="nombrePerfilNuevo" />
						</div>
						<div class="w-100 m-auto row px-2 mb-3">
							<label class="col-12 p-0" for="documento">Costo En Dolares</label>
							<input class="col-12" type="text" placeholder="Cost $" ref="costoDolaresPerfilNuevo" />
						</div>
						<div class="w-100 m-auto row px-2">
							<label class="col-12 p-0" for="documento">Costo En Bolivares</label>
							<input class="col-12" type="text" placeholder="Costo Bs" ref="costoBsPerfilNuevo" />
						</div>
					</div>
					<h1 class="mt-4 text-center">Campos Del Perfil</h1>
					<table class="table table-striped text-center">
						<thead>
							<tr>
								<th scope="col">Name</th>
								<th scope="col">Unit</th>
								<th scope="col">Agregado</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="campo in camposExistentes" :key="campo.idCampo">
								<td>{{ campo.nombre }}</td>
								<td>{{ campo.unidad }}</td>
								<td class="align-middle">
									<input
										type="checkbox"
										@change="
											(e) => {
												addCampo(e, campo);
											}
										" />
								</td>
							</tr>
						</tbody>
					</table>
					<div class="agregar-campo bg-dark-subtle rounded p-3 mb-3">
						<div class="w-100 m-auto row px-2 mb-3">
							<label for="campo">Nombre Del Campo</label>
							<input type="text" placeholder="Nombre" name="campo" ref="nombreCampo" />
						</div>
						<div class="w-100 m-auto row px-2">
							<div class="col">
								<label for="unidad">Unidad Del Campo</label>
							</div>
							<div class="col d-flex align-content-center">
								<p class="d-inline m-0 me-2">Existente</p>
								<input class="" type="checkbox" name="existente" v-model="unidadExistenteRef" @click="handleCampo" />
							</div>
							<div class="col d-flex align-content-center">
								<p class="d-inline m-0 me-2">Nueva</p>
								<input type="checkbox" name="nueva" v-model="unidadNuevoRef" @click="handleCampo" />
							</div>
						</div>
						<div class="w-100 m-auto row px-2 mb-3">
							<input type="text" placeholder="Unidad" name="unidad" v-if="unidadNuevoRef" ref="nombreUnidadNueva" />
							<select name="campos" id="campos" v-if="unidadExistenteRef" ref="nombreUnidadExistente">
								<option value="">Seleccionar</option>
								<option :value="unidad.unidad" v-for="unidad in unidadesDeCampos" :key="unidad.idCampo">
									{{ unidad.unidad }}
								</option>
							</select>
						</div>
						<div class="d-flex justify-content-center">
							<button class="btn btn-primary" @click="createCampo">Crear Campo</button>
						</div>
					</div>
					<div class="d-flex justify-content-center">
						<button class="btn btn-primary mb-4" @click="crearPerfil">Crear Perfil</button>
					</div>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonContent, IonPage, IonButton } from "@ionic/vue";
	import { onMounted, ref } from "vue";
	import { profileStore } from "@/stores/profileStore";
	import { Profile, Campo, Unit } from "@/interfaces/interfaces";

	interface CampoNuevo {
		nombre: string;
		unidad: string;
	}

	const modalOpen = ref(false);
	const selectedPerfil = ref();
	const tests = profileStore();
	const perfiles = ref<Profile[]>([]);
	const camposExistentes = ref<Campo[]>([]);
	const create = ref(false);
	const update = ref(false);
	const campos = ref<CampoNuevo[]>([]);
	const unidadExistenteRef = ref(true);
	const unidadNuevoRef = ref(false);
	const unidadesDeCampos = ref<Unit[]>([]);
	const nombreCampo = ref();
	const nombreUnidadNueva = ref();
	const nombreUnidadExistente = ref();
	const nombrePerfilNuevo = ref();
	const costoBsPerfilNuevo = ref();
	const costoDolaresPerfilNuevo = ref();

	const dataPerfilNuevo: Partial<Profile> = {
		name: "",
		cost_bs: "",
		cost_usd: "",
	};

	onMounted(async () => {
		perfiles.value = await tests.fecthProfiles();
		console.log(perfiles.value);
		camposExistentes.value = await tests.fecthProfilesInputs();
		console.log(camposExistentes.value);
		unidadesDeCampos.value = await tests.fecthProfilesInputUnits();
		console.log(unidadesDeCampos.value);
	});

	function editPerfil(perfil: any) {
		selectedPerfil.value = perfil;
		create.value = false;
		update.value = true;
		modalOpen.value = true;
	}

	// const updatePerfil = async (updatedPerfil: Profile) => {
	// 	console.log(updatedPerfil.idProfile);
	// 	await tests.updateProfile(updatedPerfil.idProfile, updatedPerfil);
	// 	perfiles.value = await tests.fecthProfiles();
	// };

	// async function addNewPerfil(newPerfil: Profile) {
	// 	console.log(newPerfil);
	// 	await tests.createProfile(newPerfil);
	// 	perfiles.value = await tests.fecthProfiles();
	// }

	function createPerfil() {
		create.value = true;
		update.value = false;
		modalOpen.value = true;
	}

	async function deletePerfil(idperfil: number) {
		console.log(idperfil);
		if (confirm("Borrar Perfil?")) {
			await tests.deleteProfile(idperfil);
			perfiles.value = await tests.fecthProfiles();
		}
	}

	const addCampo = (event: any, campo: { nombre: string; unidad: string }) => {
		if (event.target.checked) {
			console.log("true");
			const { nombre, unidad } = campo;
			const newCampo = { nombre, unidad };
			campos.value.push(newCampo);
			console.log(campos.value);
		} else {
			campos.value = campos.value.filter((item) => {
				return item.nombre != campo.nombre;
			});
			console.log(campos.value);
		}
	};

	function handleCampo() {
		if (unidadExistenteRef.value) {
			unidadExistenteRef.value = false;
			unidadNuevoRef.value = true;
			console.log(unidadExistenteRef.value);
			console.log(unidadNuevoRef.value);
		} else {
			unidadExistenteRef.value = true;
			unidadNuevoRef.value = false;
		}
	}

	const createCampo = () => {
		const dataCampoNuevo: CampoNuevo = {
			nombre: "",
			unidad: "",
		};
		if (!nombreCampo.value.value) {
			alert("ingresar el nombre del campo");
		} else {
			console.log(nombreCampo.value.value);
			dataCampoNuevo.nombre = nombreCampo.value.value;
			if (unidadNuevoRef.value && nombreUnidadNueva.value.value) {
				console.log(nombreUnidadNueva.value.value);
				dataCampoNuevo.unidad = nombreUnidadNueva.value.value;
			} else if (unidadExistenteRef.value && nombreUnidadExistente.value.value) {
				console.log(nombreUnidadExistente.value.value);
				dataCampoNuevo.unidad = nombreUnidadExistente.value.value;
			}
		}
		console.log(dataCampoNuevo);
		camposExistentes.value.push(dataCampoNuevo);
	};

	function crearPerfil() {
		if (!nombrePerfilNuevo.value.value || !costoBsPerfilNuevo.value.value || !costoDolaresPerfilNuevo.value.value) {
			alert("por favor completar datos del perfil");
			console.log(nombrePerfilNuevo.value.value);
			console.log(costoDolaresPerfilNuevo.value.value);
			console.log(costoBsPerfilNuevo.value.value);
		} else {
			dataPerfilNuevo.name = nombrePerfilNuevo.value.value;
			dataPerfilNuevo.cost_usd = costoDolaresPerfilNuevo.value.value;
			dataPerfilNuevo.cost_bs = costoBsPerfilNuevo.value.value;
			console.log(dataPerfilNuevo);
			if (!campos.value.length) {
				alert("El perfil debe contener al menos 1 campo");
			} else {
				console.log('ññññññ', campos.value)
				tests.createProfileInputs(dataPerfilNuevo, campos.value);
			}
		}
	}

	// campos de prueba
	// const camposDePerfil = [
	// 	{ id: "1", nombre: "Glucosa", unidad: "mg/ml" },
	// 	{ id: "2", nombre: "HDL", unidad: "mg/mg" },
	// 	{ id: "3", nombre: "LDL", unidad: "mg/mg" },
	// ];
</script>

<style scoped>
	.perfiles:not(:last-child) {
		margin-bottom: 15px;
	}
</style>
