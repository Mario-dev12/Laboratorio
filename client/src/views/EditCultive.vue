<template>
	<ion-page>
		<ion-content>
			<div class="container mt-3">
				<div class="perfiles mt-3 mb-3">
					<div class="row w-100 m-auto gap-2">
						<div
							class="col btn"
							:class="{ 'btn-light': index !== activeIndex, 'bg-gray': index === activeIndex }"
							v-for="(profileName, index) in profileNamesOrdered"
							:key="index"
							@click="handleTap(index)">
							{{ profileName }}
						</div>
					</div>
				</div>

				<div v-if="showProfile">
					<div>
						<h1 class="mb-4 text-center">Cultivos</h1>
					</div>
					<div class="d-flex justify-content-end mb-3">
						<ion-button @click="createPerfil" color="primary">+ Cultivo</ion-button>
					</div>
					<div class="perfiles">
						<input type="text" v-model="filtroNombre" placeholder="Filtrar por nombre" class="form-control" />
						<table class="table table-striped text-center">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Name</th>
									<th scope="col">Costo $</th>
									<th scope="col">Costo Bs</th>
									<th scope="col">Acciones</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="perfil in perfilesFiltrados" :key="perfil.idProfile">
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

					<div class="editar-perfil mt-4" v-if="create || update" ref="edicionPerfil">
						<h1 class="text-center" v-if="!update">Cultivo Nuevo</h1>
						<h1 class="text-center" v-if="update">{{ perfilName }}</h1>
						<div class="informacion-perfil bg-dark-subtle rounded p-3">
							<div class="w-100 m-auto row px-2 mb-3">
								<label class="col-12 p-0" for="documento">Nombre Del Cultivo</label>
								<input
									v-if="!update"
									class="col-12"
									type="text"
									:placeholder="update ? selectedPerfil.name : 'Nombre'"
									ref="nombrePerfilNuevo" />
								<input
									v-else
									class="col-12"
									type="text"
									v-model="selectedPerfil.name"
									:placeholder="create ? 'Nombre' : ''"
									ref="nombrePerfilNuevo" />
							</div>
							<div class="w-100 m-auto row px-2 mb-3">
								<label class="col-12 p-0" for="documento">Costo En Dolares</label>
								<input
									v-if="!update"
									class="col-12"
									type="text"
									:placeholder="update ? selectedPerfil.cost_usd : 'Costo $'"
									ref="costoDolaresPerfilNuevo"
									@input="updateCostBs" />
								<input
									v-else
									class="col-12"
									type="text"
									v-model="selectedPerfil.cost_usd"
									:placeholder="create ? 'Costo $' : ''"
									ref="costoDolaresPerfilNuevo"
									@input="updateCostBs" />
							</div>
							<div class="w-100 m-auto row px-2">
								<label class="col-12 p-0" for="documento">Costo En Bolivares</label>
								<input
									v-if="!update"
									class="col-12"
									type="text"
									:placeholder="update ? selectedPerfil.cost_bs : 'Costo Bs'"
									ref="costoBsPerfilNuevo" />
								<input
									v-else
									class="col-12"
									type="text"
									v-model="selectedPerfil.cost_bs"
									:placeholder="create ? 'Costo Bs' : ''"
									ref="costoBsPerfilNuevo" />
							</div>
						</div>

						<div class="w-100 m-auto row px-2 mb-3 mt-3">
							<label v-if="!update" class="col-12 p-0"> <input type="checkbox" v-model="externoNuevo" /> Examen Externo </label>
							<label v-else class="col-12 p-0">
								<input type="checkbox" v-model="selectedPerfil.externo" ref="externoNuevo" /> Examen Externo
							</label>
						</div>

						<div class="d-flex justify-content-center mt-3 mb-3">
							<button class="btn btn-primary mb-4" @click="crearPerfil" v-if="!update">Crear Cultivo</button>
							<button class="btn btn-primary mb-4" v-if="update" @click="updatePerfil">Guardar Cambios</button>
						</div>
					</div>
				</div>

				<div v-else>
					<div>
						<h1 class="mb-4 text-center">Espermatograma</h1>
					</div>
					<div class="d-flex justify-content-end mb-3">
						<ion-button @click="createPerfil" color="primary">+ Espermatograma</ion-button>
					</div>
					<div class="perfiles">
						<input type="text" v-model="filtroNombre" placeholder="Filtrar por nombre" class="form-control" />
						<table class="table table-striped text-center">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Name</th>
									<th scope="col">Costo $</th>
									<th scope="col">Costo Bs</th>
									<th scope="col">Acciones</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="perfil in espermatogramaFiltrados" :key="perfil.idProfile">
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

					<div class="editar-perfil mt-4" v-if="create || update" ref="edicionPerfil">
						<h1 class="text-center" v-if="!update">Espermatograma Nuevo</h1>
						<h1 class="text-center" v-if="update">{{ perfilName }}</h1>
						<div class="informacion-perfil bg-dark-subtle rounded p-3">
							<div class="w-100 m-auto row px-2 mb-3">
								<label class="col-12 p-0" for="documento">Nombre Del Espermatograma</label>
								<input
									v-if="!update"
									class="col-12"
									type="text"
									:placeholder="update ? selectedPerfil.name : 'Nombre'"
									ref="nombrePerfilNuevo" />
								<input
									v-else
									class="col-12"
									type="text"
									v-model="selectedPerfil.name"
									:placeholder="create ? 'Nombre' : ''"
									ref="nombrePerfilNuevo" />
							</div>
							<div class="w-100 m-auto row px-2 mb-3">
								<label class="col-12 p-0" for="documento">Costo En Dolares</label>
								<input
									v-if="!update"
									class="col-12"
									type="text"
									:placeholder="update ? selectedPerfil.cost_usd : 'Costo $'"
									ref="costoDolaresPerfilNuevo"
									@input="updateCostBs" />
								<input
									v-else
									class="col-12"
									type="text"
									v-model="selectedPerfil.cost_usd"
									:placeholder="create ? 'Costo $' : ''"
									ref="costoDolaresPerfilNuevo"
									@input="updateCostBs" />
							</div>
							<div class="w-100 m-auto row px-2">
								<label class="col-12 p-0" for="documento">Costo En Bolivares</label>
								<input
									v-if="!update"
									class="col-12"
									type="text"
									:placeholder="update ? selectedPerfil.cost_bs : 'Costo Bs'"
									ref="costoBsPerfilNuevo" />
								<input
									v-else
									class="col-12"
									type="text"
									v-model="selectedPerfil.cost_bs"
									:placeholder="create ? 'Costo Bs' : ''"
									ref="costoBsPerfilNuevo" />
							</div>
						</div>

						<div class="w-100 m-auto row px-2 mb-3 mt-3">
							<label v-if="!update" class="col-12 p-0"> <input type="checkbox" v-model="externoNuevo" /> Examen Externo </label>
							<label v-else class="col-12 p-0">
								<input type="checkbox" v-model="selectedPerfil.externo" ref="externoNuevo" /> Examen Externo
							</label>
						</div>

						<div class="d-flex justify-content-center mt-3 mb-3">
							<button class="btn btn-primary mb-4" @click="crearPerfil" v-if="!update">Crear Espermatograma</button>
							<button class="btn btn-primary mb-4" v-if="update" @click="updatePerfil">Guardar Cambios</button>
						</div>
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
	import { onMounted, ref, nextTick, watch, computed } from "vue";
	import { profileStore } from "@/stores/profileStore";
	import { Profile } from "@/interfaces/interfaces";
	import { checkboxOutline, closeCircleOutline, alertCircleOutline } from "ionicons/icons";
	import eventBus from "../eventBus";
	import { onBeforeRouteLeave } from "vue-router";
	import { useRouter } from "vue-router";

	const perfilName = ref();
	const selectedPerfil = ref();
	const tests = profileStore();
	const secciones = ref<Seccion[]>([]);
	const perfiles = ref<Profile[]>([]);
	const spermiogram = ref<Profile[]>([]);
	const create = ref(false);
	const update = ref(false);
	const nombrePerfilNuevo = ref();
	const costoBsPerfilNuevo = ref();
	const costoDolaresPerfilNuevo = ref();
	const crearCampo = ref(false);
	const edicionPerfil = ref();
	const isOpen = ref(false);
	const tasa = ref<number>(parseFloat(localStorage.getItem("tasaDolar") || "1"));
	const filtroNombre = ref("");
	const profileNamesOrdered = ref(["Cultivos", "Espermatograma"]);
	const activeIndex = ref<number>(0);
	const showProfile = ref<boolean>(true);
	const externoNuevo = ref(false);
	const router = useRouter();
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
		externo: false,
	};

	interface Seccion {
		nombre: string;
		campos: Array<{ idCampo: number; nombre: string; unidad: string; valor_referencial?: any; calculado: string }>;
		expandida: boolean;
		orden: number;
		camposAgregados: number[];
		camposEliminados: number[];
		nueva?: boolean;
	}

	onMounted(async () => {
		create.value = false;
		crearCampo.value = false;
		secciones.value = [];
		update.value = false;
		eventBus.on("precioActualizado", handlePrecioActualizado);
		tasa.value = Number(localStorage.getItem("tasaDolar")) || 50;
		[perfiles.value, spermiogram.value] = await Promise.all([tests.fecthCultives(), tests.fecthSpermiogram()]);
		perfiles.value.forEach((perfil) => {
			const costUsd = parseFloat(perfil.cost_usd);
			const costBs = (costUsd * tasa.value).toFixed(2);
			perfil.cost_bs = costBs.toString().replace(",", ".");
		});
		spermiogram.value.forEach((perfil) => {
			const costUsd = parseFloat(perfil.cost_usd);
			const costBs = (costUsd * tasa.value).toFixed(2);
			perfil.cost_bs = costBs.toString().replace(",", ".");
		});
	});

	router.beforeEach(async (to, from, next) => {
		if (to.name === "EditarCultivo") {
			create.value = false;
			crearCampo.value = false;
			secciones.value = [];
			update.value = false;
			eventBus.on("precioActualizado", handlePrecioActualizado);
			tasa.value = Number(localStorage.getItem("tasaDolar")) || 50;
			[perfiles.value, spermiogram.value] = await Promise.all([tests.fecthCultives(), tests.fecthSpermiogram()]);
			perfiles.value.forEach((perfil) => {
				const costUsd = parseFloat(perfil.cost_usd);
				const costBs = (costUsd * tasa.value).toFixed(2);
				perfil.cost_bs = costBs.toString().replace(",", ".");
			});
			spermiogram.value.forEach((perfil) => {
				const costUsd = parseFloat(perfil.cost_usd);
				const costBs = (costUsd * tasa.value).toFixed(2);
				perfil.cost_bs = costBs.toString().replace(",", ".");
			});
		}
		next();
	});

	onBeforeRouteLeave((to, from, next) => {
		create.value = false;
		update.value = false;
		next();
	});

	const perfilesFiltrados = computed(() => {
		return perfiles.value.filter((perfil) => {
			return perfil.name.toLowerCase().includes(filtroNombre.value.toLowerCase());
		});
	});

	const espermatogramaFiltrados = computed(() => {
		return spermiogram.value.filter((perfil) => {
			return perfil.name.toLowerCase().includes(filtroNombre.value.toLowerCase());
		});
	});

	const updateCostBs = () => {
		if (create.value) {
			const costInDollars = parseFloat(costoDolaresPerfilNuevo.value.value) || 0;
			const calculated = (costInDollars * tasa.value).toFixed(2);
			costoBsPerfilNuevo.value.value = calculated.toString().replace(",", ".");
		} else {
			const costInDollars = parseFloat(selectedPerfil.value.cost_usd) || 0;
			const calculated = (costInDollars * tasa.value).toFixed(2);
			selectedPerfil.value.cost_bs = calculated.toString().replace(",", ".");
		}
	};

	watch(tasa, () => {
		perfiles.value.forEach((perfil) => {
			const costUsd = parseFloat(perfil.cost_usd);
			const costBs = (costUsd * tasa.value).toFixed(2);
			perfil.cost_bs = costBs.toString().replace(",", ".");
		});
		spermiogram.value.forEach((perfil) => {
			const costUsd = parseFloat(perfil.cost_usd);
			const costBs = (costUsd * tasa.value).toFixed(2);
			perfil.cost_bs = costBs.toString().replace(",", ".");
		});
	});

	function handlePrecioActualizado(nuevoPrecio: number) {
		tasa.value = nuevoPrecio;
	}

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
		selectedPerfil.value = perfil;
		perfilName.value = perfil.name;
		create.value = false;
		update.value = true;
		await nextTick();
		if (!update.value) {
			nombrePerfilNuevo.value.value = "";
			costoBsPerfilNuevo.value.value = "";
			costoDolaresPerfilNuevo.value.value = "";
		}
		if (edicionPerfil.value) {
			edicionPerfil.value.scrollIntoView({ behavior: "smooth" });
		}
	}

	const updatePerfil = async () => {
		if (!nombrePerfilNuevo.value.value && !costoDolaresPerfilNuevo.value.value && !costoBsPerfilNuevo.value.value) {
			showToast("Por favor completa los datos del cultivo.", "warning", alertCircleOutline);
		} else {
			if (
				isNaN(costoDolaresPerfilNuevo.value.value.replace(",", ".")) ||
				isNaN(costoBsPerfilNuevo.value.value.replace(",", ".")) ||
				!isNaN(nombrePerfilNuevo.value.value)
			) {
				showToast("Por favor ingresa datos válidos.", "warning", alertCircleOutline);
			} else {
				const perfilesMenosSeleccionado = perfiles.value.filter((perfil) => {
					return perfil.idProfile !== selectedPerfil.value.idProfile;
				});

				if (
					perfilesMenosSeleccionado.some((item) => {
						const nombrePerfilExistente = item.name
							.normalize("NFD")
							.replace(/[\u0300-\u036f]/g, "")
							.replace(/\s+/g, " ")
							.trim()
							.toLowerCase();

						const nombrePerfilEditadoLimpiado =
							nombrePerfilNuevo.value.value
								?.normalize("NFD")
								.replace(/[\u0300-\u036f]/g, "")
								.replace(/\s+/g, " ")
								.trim()
								.toLowerCase() || "";

						return nombrePerfilExistente === nombrePerfilEditadoLimpiado;
					})
				) {
					showToast("El cultivo ya existe", "warning", alertCircleOutline);
				} else {
					selectedPerfil.value.name = nombrePerfilNuevo.value.value;
					selectedPerfil.value.cost_bs = costoBsPerfilNuevo.value.value;
					selectedPerfil.value.cost_usd = costoDolaresPerfilNuevo.value.value;

					await tests.updateCultive(selectedPerfil.value.idProfile, selectedPerfil.value);
					showToast("Cultivo actualizado exitosamente!", "creado", checkboxOutline);
					update.value = false;
					perfiles.value = await tests.fecthCultives();
					(spermiogram.value = await tests.fecthSpermiogram()),
						perfiles.value.forEach((perfil) => {
							const costUsd = parseFloat(perfil.cost_usd);
							const costBs = (costUsd * tasa.value).toFixed(2);
							perfil.cost_bs = costBs.toString().replace(",", ".");
						});
					spermiogram.value.forEach((perfil) => {
						const costUsd = parseFloat(perfil.cost_usd);
						const costBs = (costUsd * tasa.value).toFixed(2);
						perfil.cost_bs = costBs.toString().replace(",", ".");
					});
				}
			}
		}
	};

	async function createPerfil() {
		create.value = true;
		update.value = false;
		await nextTick();
		nombrePerfilNuevo.value.value = "";
		costoBsPerfilNuevo.value.value = "";
		costoDolaresPerfilNuevo.value.value = "";
		if (edicionPerfil.value) {
			edicionPerfil.value.scrollIntoView({ behavior: "smooth" });
		}
	}

	async function deletePerfil(idperfil: number) {
		if (confirm("Borrar Cultivo?")) {
			await tests.deleteCultive(idperfil);
			perfiles.value = await tests.fecthCultives();
			showToast("Cultivo borrado", "borrar", closeCircleOutline);
		}
	}

	async function crearPerfil() {
		if (!nombrePerfilNuevo.value.value || !costoBsPerfilNuevo.value.value || !costoDolaresPerfilNuevo.value.value) {
			showToast("Por favor completa los datos del cultivo.", "warning", alertCircleOutline);
		} else {
			if (
				isNaN(costoDolaresPerfilNuevo.value.value.replace(",", ".")) ||
				isNaN(costoBsPerfilNuevo.value.value.replace(",", ".")) ||
				!isNaN(nombrePerfilNuevo.value.value)
			) {
				showToast("Por favor ingresa datos válidos.", "warning", alertCircleOutline);
			} else {
				dataPerfilNuevo.name = nombrePerfilNuevo.value.value;
				dataPerfilNuevo.cost_usd = costoDolaresPerfilNuevo.value.value;
				dataPerfilNuevo.cost_bs = costoBsPerfilNuevo.value.value;
				dataPerfilNuevo.externo = externoNuevo.value;

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
					showToast("El cultivo ya existe", "warning", alertCircleOutline);
				} else {
					await tests.createCultive(dataPerfilNuevo);

					perfiles.value = await tests.fecthCultives();
					(spermiogram.value = await tests.fecthSpermiogram()),
						showToast("Cultivo creado exitosamente!", "creado", checkboxOutline);
					create.value = false;
					crearCampo.value = false;
					secciones.value = [];
				}
			}
		}
	}

	function handleTap(index: number) {
		if (index !== activeIndex.value) {
			showProfile.value = !showProfile.value;
		}
		activeIndex.value = index;
	}
</script>

<style scoped>
	.container {
		padding: 16px;
	}
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

	.bg-gray {
		background-color: #dcd7c9;
	}
</style>
