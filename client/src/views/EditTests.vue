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
				<div class="perfiles">
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
				</div>

				<div class="editar-perfil mt-4" v-if="create" ref="edicionPerfil">
					<h1 class="text-center" v-if="!update">Perfil Nuevo</h1>
					<h1 class="text-center" v-if="update">{{ perfilName }}</h1>
					<div class="informacion-perfil bg-dark-subtle rounded p-3">
						<div class="w-100 m-auto row px-2 mb-3">
							<label class="col-12 p-0" for="documento">Nombre Del Perfil</label>
							<input class="col-12" type="text" :placeholder="update ? selectedPerfil.name : 'Nombre'" ref="nombrePerfilNuevo" />
						</div>
						<div class="w-100 m-auto row px-2 mb-3">
							<label class="col-12 p-0" for="documento">Costo En Dolares</label>
							<input
								class="col-12"
								type="text"
								:placeholder="update ? selectedPerfil.cost_usd : 'Costo $'"
								ref="costoDolaresPerfilNuevo" />
						</div>
						<div class="w-100 m-auto row px-2">
							<label class="col-12 p-0" for="documento">Costo En Bolivares</label>
							<input
								class="col-12"
								type="text"
								:placeholder="update ? selectedPerfil.cost_bs : 'Costo Bs'"
								ref="costoBsPerfilNuevo" />
						</div>
					</div>
					<h1 class="mt-4 text-center">Campos Del Perfil</h1>
					<div class="campos">
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
											"
											:checked="ischecked(campo)" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="d-flex justify-content-center mt-3 mb-3">
						<button class="btn btn-primary mb-4" @click="crearPerfil" v-if="!update">Crear Perfil</button>
						<button class="btn btn-primary mb-4" v-if="update" @click="updatePerfil">Guardar Cambios</button>
						<button class="btn btn-primary mb-4 ms-5" @click="adicionarCampo">+ Campo</button>
					</div>
				</div>
				<div class="agregar-campo bg-dark-subtle rounded p-3 mb-3" v-if="crearCampo" ref="edicionCampo">
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
			</div>
			<ion-toast
				:class="toast.class"
				:icon="toast.icon"
				:is-open="isOpen"
				:message="toast.message"
				duration="2000"
				@didDismiss="setOpen(false)"
				position="top"></ion-toast>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonContent, IonPage, IonButton, IonToast } from "@ionic/vue";
	import { onMounted, ref, nextTick } from "vue";
	import { profileStore } from "@/stores/profileStore";
	import { Profile, Campo, Unit } from "@/interfaces/interfaces";
	import { checkboxOutline, closeCircleOutline, alertCircleOutline } from "ionicons/icons";

	const perfilName = ref();
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
	const crearCampo = ref(false);
	const edicionPerfil = ref();
	const edicionCampo = ref();
	const camposDelPerfil = ref();
	const isOpen = ref(false);
	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
	});

	const dataPerfilNuevo: Partial<Profile> = {
		name: "",
		cost_bs: "",
		cost_usd: "",
	};

	interface CampoNuevo {
		nombre: string;
		unidad: string;
		checked?: boolean;
	}

	onMounted(async () => {
		perfiles.value = await tests.fecthProfiles();
		camposExistentes.value = await tests.fecthProfilesInputs();
		unidadesDeCampos.value = await tests.fecthProfilesInputUnits();
	});

	const setOpen = (state: boolean) => {
		isOpen.value = state;
	};

	const showToast = (message: string, style: string, icon: any) => {
		toast.value.message = message;
		toast.value.isOpen = true;
		toast.value.class = style;
		toast.value.icon = icon;
		setOpen(true);
	};

	async function editPerfil(perfil: any) {
		camposDelPerfil.value = await tests.fetchInputsByProfileId(perfil.idProfile);
		selectedPerfil.value = perfil;
		perfilName.value = perfil.name;
		create.value = true;
		update.value = true;
		crearCampo.value = false;
		await nextTick();
		if (edicionPerfil.value) {
			edicionPerfil.value.scrollIntoView({ behavior: "smooth" });
		}
	}

	function ischecked(campo: any) {
		if (
			(camposDelPerfil.value &&
				camposDelPerfil.value.some((item: any) => {
					return item.idCampo === campo.idCampo;
				})) ||
			campo.checked == true
		) {
			campos.value.push(campo);
			return true;
		} else {
			return false;
		}
	}

	const updatePerfil = async () => {
		if (
			selectedPerfil.value.name.trim() == nombrePerfilNuevo.value.value.trim() &&
			selectedPerfil.value.cost_usd == costoDolaresPerfilNuevo.value.value &&
			selectedPerfil.value.cost_bs == costoBsPerfilNuevo.value.value
		) {
			alert("datos del perfil no han cambiado");
		} else {
			selectedPerfil.value.name = nombrePerfilNuevo.value.value;
			selectedPerfil.value.cost_bs = costoBsPerfilNuevo.value.value;
			selectedPerfil.value.cost_usd = costoDolaresPerfilNuevo.value.value;
			console.log(selectedPerfil.value.idProfile);
			console.log(selectedPerfil.value);
			tests.updateProfile(selectedPerfil.value.idProfile, selectedPerfil.value).then(async () => {
				perfiles.value = await tests.fecthProfiles();
				alert("perfil actualizado");
			});
		}
	};

	async function createPerfil() {
		camposDelPerfil.value = null;
		create.value = true;
		update.value = false;
		crearCampo.value = false;
		await nextTick();
		if (edicionPerfil.value) {
			edicionPerfil.value.scrollIntoView({ behavior: "smooth" });
		}
	}

	async function deletePerfil(idperfil: number) {
		if (confirm("Borrar Perfil?")) {
			await tests.deleteProfile(idperfil);
			perfiles.value = await tests.fecthProfiles();
			showToast("Perfil borrado", "borrar", closeCircleOutline);
		}
	}

	const addCampo = (event: any, campo: { nombre: string; unidad: string; checked?: boolean }) => {
		if (event.target.checked) {
			const { nombre, unidad, checked } = campo;
			const newCampo = { nombre, unidad, checked };
			campos.value.push(newCampo);
		} else {
			campos.value = campos.value.filter((item) => {
				return item.nombre != campo.nombre;
			});
		}
	};

	function handleCampo() {
		if (unidadExistenteRef.value) {
			unidadExistenteRef.value = false;
			unidadNuevoRef.value = true;
		} else {
			unidadExistenteRef.value = true;
			unidadNuevoRef.value = false;
		}
	}

	const createCampo = () => {
		const dataCampoNuevo: CampoNuevo = {
			nombre: "",
			unidad: "",
			checked: true,
		};
		if (!nombreCampo.value.value) {
			alert("ingresar el nombre del campo");
		} else {
			dataCampoNuevo.nombre = nombreCampo.value.value;
			if (unidadNuevoRef.value && nombreUnidadNueva.value.value) {
				dataCampoNuevo.unidad = nombreUnidadNueva.value.value;
			} else if (unidadExistenteRef.value && nombreUnidadExistente.value.value) {
				dataCampoNuevo.unidad = nombreUnidadExistente.value.value;
			}
		}
		campos.value.push(dataCampoNuevo);
		camposExistentes.value.unshift(dataCampoNuevo);
	};

	async function crearPerfil() {
		if (!nombrePerfilNuevo.value.value || !costoBsPerfilNuevo.value.value || !costoDolaresPerfilNuevo.value.value) {
			alert("por favor completar datos del perfil");
		} else {
			dataPerfilNuevo.name = nombrePerfilNuevo.value.value;
			dataPerfilNuevo.cost_usd = costoDolaresPerfilNuevo.value.value;
			dataPerfilNuevo.cost_bs = costoBsPerfilNuevo.value.value;
			if (!campos.value.length) {
				alert("El perfil debe contener al menos 1 campo");
			} else {
				if (
					perfiles.value.some((item) => {
						const nombrePerfilExistente = item.name
							.normalize("NFD")
							.replace(/[\u0300-\u036f]/g, "")
							.replace(/\s+/g, " ")
							.trim()
							.toLowerCase();

						const nombrePerfilNuevoLimpiado =
							dataPerfilNuevo.name
								?.normalize("NFD")
								.replace(/[\u0300-\u036f]/g, "")
								.replace(/\s+/g, " ")
								.trim()
								.toLowerCase() || "";

						return nombrePerfilExistente === nombrePerfilNuevoLimpiado;
					})
				) {
					showToast("Perfil Ya Existe", "warning", alertCircleOutline);
				} else {
					const camposNuevos = campos.value.map(({ nombre, unidad }) => ({ nombre, unidad }));
					tests.createProfileInputs(dataPerfilNuevo, camposNuevos).then(async () => {
						/*traer de nuevo perfiles, campos y unidades */
						perfiles.value = await tests.fecthProfiles();
						camposExistentes.value = await tests.fecthProfilesInputs();
						unidadesDeCampos.value = await tests.fecthProfilesInputUnits();
					});
					showToast("Perfil creado Exitosamente!", "creado", checkboxOutline);
					create.value = false;
					crearCampo.value = false;
				}
			}
		}
	}

	const adicionarCampo = async () => {
		crearCampo.value = !crearCampo.value;
		await nextTick();
		if (edicionCampo.value) {
			edicionCampo.value.scrollIntoView({ behavior: "smooth" });
		}
	};
</script>

<style scoped>
	.perfiles:not(:last-child) {
		margin-bottom: 15px;
	}

	.campos,
	.perfiles {
		max-height: 400px;
		overflow-y: auto;
	}

	ion-toast.creado {
		--background: rgb(0, 204, 0);
		--color: #323232;
	}

	ion-toast.borrar {
		--background: rgb(229, 0, 0);
		--color: #323232;
	}

	ion-toast.warning {
		--background: rgb(219, 248, 0);
		--color: #323232;
	}
</style>
