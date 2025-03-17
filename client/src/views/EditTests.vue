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

				<div class="editar-perfil mt-4" v-if="create || update" ref="edicionPerfil">
					<h1 class="text-center" v-if="!update">Perfil Nuevo</h1>
					<h1 class="text-center" v-if="update">{{ perfilName }}</h1>
					<div class="informacion-perfil bg-dark-subtle rounded p-3">
						<div class="w-100 m-auto row px-2 mb-3">
							<label class="col-12 p-0" for="documento">Nombre Del Perfil</label>
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
								ref="costoDolaresPerfilNuevo" />
							<input
								v-else
								class="col-12"
								type="text"
								v-model="selectedPerfil.cost_usd"
								:placeholder="create ? 'Costo $' : ''"
								ref="costoDolaresPerfilNuevo" />
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
					<h1 class="mt-4 text-center">Secciones Del Perfil</h1>
					<div class="secciones mt-4">      
						<div v-if="secciones.length === 0" class="text-center mt-3">  
						  No hay secciones para este perfil.  
						</div>  
						<div v-else>  
						  <div v-for="(seccion, index) in secciones" :key="index" class="seccion mt-3">  
							<div class="d-flex align-items-center">  
							  <input  
								type="text"  
								v-model="seccion.nombre"  
								placeholder="Nombre de la sección" class="form-control mb-2" />  
							  <button @click="toggleExpand(index)" class="btn btn-link ms-2">  
								{{ seccion.expandida ? 'Menos' : 'Más' }}  
							  </button>  
							  <button @click="deleteSeccion(index)" class="btn btn-link ms-2 text-danger" title="Eliminar Sección">  
								<i class="fas fa-trash"></i> 
							  </button>  
							</div>  
				  
							<div v-if="seccion.expandida">  
							  <div class="campos">  
								<table class="table table-striped text-center">  
								  <thead>  
									<tr>  
									  <th scope="col">Name</th>  
									  <th scope="col">Unit</th>  
									  <th scope="col">Valor Referencial</th> 
									  <th scope="col">Agregado</th>  
									</tr>  
								  </thead>  
								  <tbody>  
									<tr v-for="campo in camposExistentes" :key="campo.idCampo">  
										<td>{{ campo.nombre }}</td>  
										<td>{{ campo.unidad }}</td>  
										<td>{{ campo.valor_referencial }}</td> 
										<td class="align-middle">  
											<input  
												type="checkbox"  
												@change="(e) => toggleCampoSeleccionado(e, campo, seccion)"  
												:checked="isCampoSeleccionado(seccion, campo)" />  
										</td>  
									</tr>
								  </tbody>  
								</table>  
							  </div>  
							</div>  
						  </div>  
						</div> 
						<div class="d-flex justify-content-center">
							<button class="btn btn-primary mt-2 mb-3" @click="agregarSeccion">Agregar Sección</button>  
						</div> 
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
							<option value="default">Seleccionar</option>
							<option :value="unidad.unidad" v-for="unidad in unidadesDeCampos" :key="unidad.idCampo">
								{{ unidad.unidad }}
							</option>
						</select>
					</div>
					<div class="w-100 m-auto row px-2 mb-3">
						<label for="valorReferencial">Valores Referenciales</label>
						<input type="text" placeholder="Valor Referencial" name="valorReferencial" ref="valorReferencial" />
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
	const secciones = ref<Seccion[]>([]);
	const seccionesAgregadas = ref<Seccion[]>([]);  
	const seccionesEliminadas = ref<Seccion[]>([]); 
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
	const valorReferencial = ref();
	const nombrePerfilNuevo = ref();
	const costoBsPerfilNuevo = ref();
	const costoDolaresPerfilNuevo = ref();
	const crearCampo = ref(false);
	const edicionPerfil = ref();
	const edicionCampo = ref();
	const camposDelPerfil = ref();
	const isOpen = ref(false);
	const idCamposAgregados = ref<number[]>([]);
	const idCamposEliminados = ref<number[]>([]);
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
		idCampo: number;
		nombre: string;
		unidad: string;
		referencial: string;
		checked?: boolean;
	}

	interface Seccion {
		nombre: string;  
		campos: Array<{ idCampo: number; nombre: string; unidad: string; valor_referencial?: any }>;
		expandida: boolean;
		orden: number;
		camposAgregados: Number[],   
    	camposEliminados: Number[],
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
		secciones.value = camposDelPerfil.value.section
		secciones.value = secciones.value.filter(seccion => {  
			return seccion.nombre.trim() !== "" || (seccion.campos && seccion.campos.length > 0);  
		});  
		selectedPerfil.value = perfil;
		perfilName.value = perfil.name;
		create.value = false;
		update.value = true;
		crearCampo.value = false;
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
			if (idCamposAgregados.value.length || idCamposEliminados.value.length) {  
				if (idCamposAgregados.value.length) {  
					console.log("campos agregados");  
					await tests.createInputsInProfile(selectedPerfil.value.idProfile, idCamposAgregados.value);  
				}  

				if (idCamposEliminados.value.length) {  
					console.log("campos eliminados");  
					await tests.deleteInputsInProfile(selectedPerfil.value.idProfile, idCamposEliminados.value);  
				}  
				showToast("Perfil actualizado exitosamente!", "creado", checkboxOutline);  
				update.value = false;  
				crearCampo.value = false;  
			}  
		} else {    
			if (  
				isNaN(costoDolaresPerfilNuevo.value.value.replace(",", ".")) ||  
				isNaN(costoBsPerfilNuevo.value.value.replace(",", ".")) ||  
				!isNaN(nombrePerfilNuevo.value.value)  
			) {  
				alert("Por favor ingresa datos válidos.");  
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
					showToast("El perfil ya existe", "warning", alertCircleOutline);  
				} else {    
					selectedPerfil.value.name = nombrePerfilNuevo.value.value;  
					selectedPerfil.value.cost_bs = costoBsPerfilNuevo.value.value;  
					selectedPerfil.value.cost_usd = costoDolaresPerfilNuevo.value.value;  

					const profilesSections: any = await tests.fetchInputsByProfileId(selectedPerfil.value.idProfile);  

					const seccionesActualizadas = secciones.value.map(seccion => ({  
						nombre: seccion.nombre,  
						campos: seccion.campos,  
						camposAgregados: seccion.camposAgregados,  
						camposEliminados: seccion.camposEliminados,  
					}));  

					const seccionesValidas = seccionesActualizadas.every(seccion =>   
						seccion.nombre.trim() !== "" && seccion.campos.length > 0  
					); 

					if (!seccionesValidas) {  
						alert("Cada sección debe tener un nombre y al menos un campo seleccionado.");  
						return;
					} 
 
					if (campos.value.length) {  
						await tests.createInputs(selectedPerfil.value.idProfile, campos.value).then(async () => {  
							perfiles.value = await tests.fecthProfiles();  
							camposExistentes.value = await tests.fecthProfilesInputs();  
							unidadesDeCampos.value = await tests.fecthProfilesInputUnits();  
						});  
					}  
 
					if (seccionesAgregadas.value.length) {  
						for (const seccion of seccionesAgregadas.value) {  
							const existe = profilesSections.section.some((existingSeccion: { nombre: string; }) =>   
								existingSeccion.nombre.trim() === seccion.nombre.trim()  
							);  
							if (!existe) {  
								seccion.nombre = seccion.nombre.trim();
								await tests.createProfileSection(selectedPerfil.value.idProfile, seccion);   
							}  
						}   
					}   
 
					if (seccionesEliminadas.value.length) {  
						for (const seccion of seccionesEliminadas.value) {
							if (seccion.nombre !== ''){ 
							    await tests.deleteProfileSection(selectedPerfil.value.idProfile, seccion.nombre); 
							}  
						}   
					}  
 
					for (const seccion of seccionesActualizadas) {   
						if (seccion.camposAgregados && seccion.camposAgregados.length > 0) {   
							const data = {  
								idProfile: selectedPerfil.value.idProfile,  
								nombre: seccion.nombre.trim()  
							};   
							const camposNuevos = seccion.campos.filter(campo => campo.idCampo === 0); 

							const idsCorrespondientes = camposNuevos.map(campoNuevo => {  
								const campoExistente = camposExistentes.value.find(campo => campo.nombre === campoNuevo.nombre);  
								return campoExistente ? campoExistente.idCampo : null;   
							}).filter(id => id !== null) as number[];  

							seccion.camposAgregados.push(...idsCorrespondientes);  
							seccion.camposAgregados = seccion.camposAgregados.filter(id => id !== 0); 

							await tests.createProfileSectionInputs(data, seccion.camposAgregados);
							
						}  

						if (seccion.camposEliminados && seccion.camposEliminados.length > 0) { 
							await tests.deleteProfileSectionInputs(selectedPerfil.value.idProfile, seccion.nombre, seccion.camposEliminados);  
						}  
					}   
  
					await tests.updateProfile(selectedPerfil.value.idProfile, selectedPerfil.value);  
					showToast("Perfil actualizado exitosamente!", "creado", checkboxOutline);  
					update.value = false;  
					crearCampo.value = false;  
				}  
			}  
		}  
	};  

	async function createPerfil() {
		camposDelPerfil.value = null;
		campos.value = [];
		create.value = true;
		update.value = false;
		crearCampo.value = false;
		await nextTick();
		nombrePerfilNuevo.value.value = "";
		costoBsPerfilNuevo.value.value = "";
		costoDolaresPerfilNuevo.value.value = "";
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
		const dataCampoNuevo = {  
			idCampo: 0,  
			nombre: "",  
			unidad: "",  
			referencial: "",  
			checked: true,  
			seleccionado: false  
		};  

		if (  
			!nombreCampo.value.value ||  
			(unidadNuevoRef.value && !nombreUnidadNueva.value.value) ||  
			(unidadExistenteRef.value && nombreUnidadExistente.value.value === "default")  
		) {  
			alert("Por Favor Completar Datos Del Campo");  
		} else {  
			if (!isNaN(nombreCampo.value.value)) {  
				alert("Por Favor Introduce Un Nombre De Campo Valido");  
			} else {  
				if (  
					camposExistentes.value.some((campo) => {  
						return campo.nombre.trim() === nombreCampo.value.value.trim();  
					})  
				) {  
					alert("Ya Existe Un Campo Con Ese Nombre");  
				} else {  
					dataCampoNuevo.nombre = nombreCampo.value.value;  
					if (valorReferencial.value.value) {  
						dataCampoNuevo.referencial = valorReferencial.value.value;  
					}  
					if (unidadNuevoRef.value && nombreUnidadNueva.value.value) {  
						dataCampoNuevo.unidad = nombreUnidadNueva.value.value;  
						nombreUnidadNueva.value.value = "";  
					} else if (unidadExistenteRef.value && nombreUnidadExistente.value.value) {  
						dataCampoNuevo.unidad = nombreUnidadExistente.value.value;  
						nombreUnidadExistente.value.value = "default";
					}  
					campos.value.push(dataCampoNuevo);  
					camposExistentes.value.unshift(dataCampoNuevo);
					nombreCampo.value.value = ""; 
					valorReferencial.value.value = "";  
				}  
			}  
		}  
		crearCampo.value = !crearCampo.value;
	};

	async function crearPerfil() {  
		if (!nombrePerfilNuevo.value.value || !costoBsPerfilNuevo.value.value || !costoDolaresPerfilNuevo.value.value) {  
			alert("Por favor completa los datos del perfil.");  
		} else {  
			if (  
				isNaN(costoDolaresPerfilNuevo.value.value.replace(",", ".")) ||  
				isNaN(costoBsPerfilNuevo.value.value.replace(",", ".")) ||  
				!isNaN(nombrePerfilNuevo.value.value)  
			) {  
				alert("Por favor ingresa datos válidos.");  
			} else {  
				dataPerfilNuevo.name = nombrePerfilNuevo.value.value;  
				dataPerfilNuevo.cost_usd = costoDolaresPerfilNuevo.value.value;  
				dataPerfilNuevo.cost_bs = costoBsPerfilNuevo.value.value;  

				if (secciones.value.length === 0) {  
					alert("El perfil debe contener al menos una sección.");  
					return;
				}   

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
					showToast("El perfil ya existe", "warning", alertCircleOutline);  
				} else {  

					const seccionesValidas = secciones.value.every(seccion =>   
						seccion.nombre.trim() !== "" && seccion.campos.length > 0
					);  

					if (!seccionesValidas) {  
						alert("Cada sección debe tener un nombre y al menos un campo.");  
						return;  
					}  
					const camposNuevos = secciones.value.flatMap(seccion =>   
						seccion.campos.map(({ nombre, unidad, valor_referencial }) => ({  
							nombre,  
							unidad,  
							referencial: valor_referencial   
						}))  
					);  
					const datosFiltrados = secciones.value.filter(item =>   
						item.nombre.trim() !== "" || (item.campos && item.campos.length > 0)  
					);  

					await tests.createProfileInputs(dataPerfilNuevo, camposNuevos, datosFiltrados).then(async () => {  
						perfiles.value = await tests.fecthProfiles();  
						camposExistentes.value = await tests.fecthProfilesInputs();  
						unidadesDeCampos.value = await tests.fecthProfilesInputUnits();  
					});
					showToast("Perfil creado exitosamente!", "creado", checkboxOutline);  
					create.value = false;  
					crearCampo.value = false;  
					secciones.value = [];  
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

	const toggleExpand = (index: number) => {  
		const seccion = secciones.value[index];   
		secciones.value.forEach((s, i) => {  
			s.expandida = i === index ? !s.expandida : false;  
		});  
	};

	const agregarSeccion = () => {   
		const todosCamposLlenos = secciones.value.every(seccion =>  
			seccion.nombre.trim() !== "" && seccion.campos.length > 0 
		);  

		if (!todosCamposLlenos) {  
			alert("Por favor, completa todos los campos y selecciona al menos un campo en cada sección.");  
			return; 
		}  

		secciones.value.forEach(seccion => (seccion.expandida = false));  
	
		const nuevaSeccion: Seccion = {  
			nombre: '',  
			campos: [],  
			expandida: true,  
			orden: secciones.value.length === 0 ? 1 : secciones.value.length + 1,  
			camposAgregados: [],  
			camposEliminados: []  
		};  
		  
		secciones.value.push(nuevaSeccion);  
		 
		if (!seccionesAgregadas.value.includes(nuevaSeccion)) {  
			seccionesAgregadas.value.push(nuevaSeccion);   
		}  
	};   

	const toggleCampoSeleccionado = (event: Event, campo: Campo, seccion: Seccion) => {   
		if (!seccion) {  
			console.error("Sección no definida");  
			return;  
		}  

		const checked = (event.target as HTMLInputElement).checked;

		if (checked) {  
			if (campo.idCampo === 0) {  
				if (!seccion.campos.some(c => c.nombre === campo.nombre)) {  
					seccion.campos.push(campo);
				}  
			} else {   
				if (!seccion.campos.some(c => c.idCampo === campo.idCampo)) {  
					seccion.campos.push(campo); 
				}  
			}  

			if (!seccion.camposAgregados) {  
				seccion.camposAgregados = [];  
			}  
			if (!seccion.camposAgregados.includes(campo.idCampo)) {  
				seccion.camposAgregados.push(campo.idCampo); 
			}  

			if (!seccion.camposEliminados) {  
				seccion.camposEliminados = [];  
			}  
			seccion.camposEliminados = seccion.camposEliminados.filter(id => id !== campo.idCampo);  
		} else {   
			seccion.campos = seccion.campos.filter(c => c.idCampo !== campo.idCampo);  

			if (!seccion.camposEliminados) {  
				seccion.camposEliminados = [];  
			}  
			if (!seccion.camposEliminados.includes(campo.idCampo)) {  
				seccion.camposEliminados.push(campo.idCampo);  
			}  

			if (seccion.camposAgregados) {  
				seccion.camposAgregados = seccion.camposAgregados.filter(id => id !== campo.idCampo);  
			}  
		}  
	}; 

	const isCampoSeleccionado = (seccion: Seccion, campo: Campo) => {   
		if (campo.idCampo === 0 || campo.idCampo === undefined) {  
			return seccion.campos.some(c => c.nombre === campo.nombre);  
		}  

		return seccion.campos.some(c => c.idCampo === campo.idCampo);  
	};    
	
	const deleteSeccion = (index: number) => {  
		if (confirm("¿Estás seguro de que deseas eliminar esta sección?")) {  
			const seccionAEliminar = secciones.value[index];  
			
			if (!seccionesEliminadas.value.includes(seccionAEliminar)) {  
				seccionesEliminadas.value.push(seccionAEliminar);  
			}  

			secciones.value.splice(index, 1);  
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
