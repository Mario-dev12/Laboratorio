<template>
	<ion-page>
		<ion-content>
			<div class="d-flex mt-4 ms-5">
				<div class="p-3 bg-dark-subtle rounded text-center">
					<h2>Tasa del Dolar</h2>
					<h3>Bs: {{ precioDolar }}</h3>
					<button
						class="btn btn-primary mb-2"
						v-if="!showChangeDolar"
						@click="
							() => {
								showChangeDolar = !showChangeDolar;
							}
						">
						Editar
					</button>
					<div v-if="showChangeDolar">
						<input class="d-block mb-2" type="text" ref="precioDolarRef" />
						<button class="d-block btn btn-primary w-auto mx-auto" @click="cambiarPrecioDolar">Cambiar tasa del dolar</button>
					</div>
				</div>
			</div>
			<div class="container mt-2 p-3 bg-dark-subtle rounded">
				<div class="w-100 m-auto row px-2">
					<label class="col-12 p-0" for="documento">Documento de identidad</label>
					<div class="col-12 p-0">
						<div class="row w-100 m-auto pe-1 justify-content-between">
							<input class="col-10" type="text" placeholder="Documento de identidad" name="documento" ref="documentoRef" />
							<button class="btn btn-success col-2 w-auto ms-1" @click="searchClient">🔎</button>
						</div>
					</div>
				</div>
				<div class="row mt-2 w-100 m-auto">
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="nombre">Nombre</label>
							<input class="col w-auto" type="text" placeholder="Nombre" name="nombre" ref="nombreRef" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="apellido">Apellido</label>
							<input class="col w-auto" type="text" placeholder="Apellido" name="apellido" ref="apellidoRef" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="genero">Genero</label>
							<select
								class="col w-auto py-2"
								name="genero"
								id="genero"
								ref="generoRef"
								@change="() => console.log(generoRef.value)">
								<option disabled selected>Seleccionar</option>
								<option value="masculino">Masculino</option>
								<option value="femenino">Femenino</option>
							</select>
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="edad">Edad</label>
							<input class="col w-auto" type="text" placeholder="Edad" name="edad" ref="edadRef" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="procedencia">Procedencia</label>
							<select class="col w-auto py-2" name="procedencia" id="precedencia" ref="procedenciaRef">
								<option disabled selected>Seleccionar</option>
								<option value="procedencia1">procedencia1</option>
								<option value="procedencia2">procedencia2</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row w-100 m-auto">
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col-12 p-0" for="diagnostico">Motivo/Diagnostico:</label>
							<textarea class="col-12" name="diagnostico" id="diagnostico" cols="50" ref="diagnosticoRef"></textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="bg-dark-subtle container p-3 rounded mt-3">
				<div class="row w-100 m-auto">
					<div class="col-12">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="examen">Tipo de Examen:</label>
							<select class="col p-1" name="examen" id="examen" v-model="tipoDeExamen" @change="agregarExamen()">
								<option value="">Seleccionar</option>
								<option value="Perfil 20">Perfil 20</option>
								<option value="Perfil Tiroideo">Perfil Tiroideo</option>
								<option value="Perfil Urológico">Perfil Urológico</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row w-100 m-auto">
					<div class="col-12">
						<div class="mt-2 table-responsive">
							<table class="table text-nowrap table-striped">
								<thead>
									<tr>
										<th scope="col">Examen</th>
										<th scope="col">Descripcion</th>
										<th scope="col">Precio Bs</th>
										<th scope="col">Precio $</th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="(value, index) in examenesSeleccionados" :key="index">
										<td>{{ value.nombre }}</td>
										<td>{{ value.descripcion }}</td>
										<td>Bs: {{ value.precio$ * precioDolar }}</td>
										<td>$: {{ value.precio$ }}</td>
										<td><button class="btn btn-danger" @click="eliminarExamen(value.nombre)">Borrar</button></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="factura container mt-3 mb-4 bg-dark-subtle rounded p-3">
				<div class="row w-100 m-auto mb-1">
					<div class="col">Numero de orden</div>
					<div class="col">1</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Fecha</div>
					<div class="col">{{ `${day}/${month}/${year}` }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Total En Bs</div>
					<div class="col">Bs: {{ totales.totalBs.toFixed(2) }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Total En $</div>
					<div class="col">$: {{ totales.total$.toFixed(2) }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Pago Bs</div>
					<div class="col">
						<input type="text" v-model="pagoEnBs" />
					</div>
				</div>
				<div class="row w-100 m-auto">
					<div class="col">Pago $</div>
					<div class="col">
						<input type="text" v-model="pagoEnDivisas" />
					</div>
				</div>
			</div>
			<div class="row w-100 m-auto justify-content-center mb-4">
				<button class="btn btn-primary w-auto" @click="saveOrder">Guardar Orden</button>
			</div>
			<!-- Toast cliente no encontrado -->
			<div class="toast-container position-fixed top-0 end-0 p-3 z-3">
				<div
					id="searchClientToast"
					class="toast align-items-center text-bg-warning border-0 text-white"
					role="alert"
					aria-live="assertive"
					aria-atomic="true">
					<div class="d-flex">
						<div class="toast-body">No se encontró cliente con ese documento de identidad</div>
						<button
							type="button"
							class="btn-close btn-close-white me-2 m-auto"
							data-bs-dismiss="toast"
							aria-label="Close"></button>
					</div>
				</div>
			</div>
			<!-- Toast orden creada -->
			<div class="toast-container position-fixed top-0 end-0 p-3 z-3">
				<div
					id="liveToast"
					class="toast align-items-center text-bg-primary border-0"
					role="alert"
					aria-live="assertive"
					aria-atomic="true">
					<div class="d-flex">
						<div class="toast-body">Orden Creada Exitosamente!!</div>
						<button
							type="button"
							class="btn-close btn-close-white me-2 m-auto"
							data-bs-dismiss="toast"
							aria-label="Close"></button>
					</div>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { ref, watch, onMounted } from "vue";
	import { IonContent, IonPage } from "@ionic/vue";
	import { userStore } from "@/stores/userStore";
	import { User } from "@/interfaces/interfaces";
	import { Toast } from "bootstrap";

	const tipoDeExamen = ref();
	const pagoEnDivisas = ref();
	const pagoEnBs = ref();
	const examenesSeleccionados = ref<Examen[]>([]);
	const documentoRef = ref();
	const nombreRef = ref();
	const apellidoRef = ref();
	const generoRef = ref();
	const edadRef = ref();
	const procedenciaRef = ref();
	const diagnosticoRef = ref();
	const today = new Date();
	const day = today.getUTCDate();
	const month = today.getUTCMonth() + 1;
	const year = today.getFullYear();
	const precioDolar = ref(Number(localStorage.getItem("tasaDolar")) || 50);
	const precioDolarRef = ref();
	const users = userStore();
	let bs: number = 0;
	let divisas: number = 0;
	const showChangeDolar = ref(false);

	const totales = {
		totalBs: 0,
		total$: 0,
	};

	onMounted(async () => {});

	interface Examen {
		nombre: string;
		precio$: number;
		descripcion: string;
	}

	interface Orden {
		documentoIdentidad: number;
		nombre: any;
		apellido: string;
		genero: string;
		edad: number;
		procedencia: string;
		diagnostico: string;
		examenes: Examen[];
		totalEnBs: number;
		totalEn$: number;
		pagoBs: number;
		pago$: number;
		fechaDeCreacion: string;
	}

	const searchClient = async () => {
		if (documentoRef.value.value) {
			const currentClient: User[] = await users.fecthUserById(documentoRef.value.value);
			if (currentClient.length) {
				nombreRef.value.value = currentClient[0].firstName;
				apellidoRef.value.value = currentClient[0].lastName;
				generoRef.value.value = currentClient[0].genre === "M" ? "masculino" : "femenino";
				edadRef.value.value = currentClient[0].age;
			} else {
				const clientToast: any = document.getElementById("searchClientToast");
				const toastBootstrap = Toast.getOrCreateInstance(clientToast);
				toastBootstrap.show();
			}
		} else {
			alert("Ingrese documento de identidad");
		}
	};

	const examenes: Examen[] = [
		{ nombre: "Perfil 20", precio$: 10, descripcion: "examen general de salud" },
		{ nombre: "Perfil Tiroideo", precio$: 10, descripcion: "examen de la tiroides" },
		{ nombre: "Perfil Urológico", precio$: 15, descripcion: "examen urológico" },
	];

	const cambiarPrecioDolar = () => {
		if (isNaN(precioDolarRef.value.value) || precioDolarRef.value.value === "") {
			alert("Ingrese un valor válido");
		} else {
			precioDolar.value = precioDolarRef.value.value;
			localStorage.setItem("tasaDolar", precioDolarRef.value.value);
			showChangeDolar.value = !showChangeDolar.value;
			precioDolarRef.value.value = "";
		}
	};

	const agregarExamen = () => {
		for (const item of examenes) {
			const itemInArray = examenesSeleccionados.value.find((element) => element.nombre === item.nombre);
			if (item.nombre === tipoDeExamen.value && !itemInArray) {
				examenesSeleccionados.value.push(item);
				examenesSeleccionados.value = [...examenesSeleccionados.value];
				pagoEnBs.value = "";
				pagoEnDivisas.value = "";
			}
		}

		tipoDeExamen.value = "";
	};

	function eliminarExamen(examen: string) {
		examenesSeleccionados.value = examenesSeleccionados.value.filter((item) => {
			return item.nombre !== examen;
		});
	}

	watch(examenesSeleccionados, (newValue, oldValue) => {
		if (newValue.length) {
			if (newValue.length < oldValue.length) {
				totales.totalBs -= newValue[0].precio$ * precioDolar.value;
				totales.total$ -= newValue[0].precio$;
			} else if (newValue.length >= oldValue.length) {
				totales.totalBs += newValue[0].precio$ * precioDolar.value;
				totales.total$ += newValue[0].precio$;
			}
		} else {
			totales.totalBs = 0;
			totales.total$ = 0;
		}
	});

	watch(pagoEnDivisas, (newValue) => {
		const totales2 = {
			totalBs: 0,
			total$: 0,
		};

		for (const item of examenesSeleccionados.value) {
			totales2.total$ += item.precio$;
			totales2.totalBs += item.precio$ * precioDolar.value;
		}

		if (examenesSeleccionados.value.length) {
			if (pagoEnBs.value) {
				if (newValue) {
					totales2.totalBs -= newValue * precioDolar.value;
					totales2.totalBs -= pagoEnBs.value;
					totales2.total$ -= newValue;
					totales2.total$ -= pagoEnBs.value / precioDolar.value;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				} else {
					totales2.totalBs -= pagoEnBs.value;
					totales2.total$ -= pagoEnBs.value / precioDolar.value;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				}
			} else {
				if (newValue) {
					totales2.totalBs -= newValue * precioDolar.value;
					totales2.total$ -= newValue;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				} else {
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				}
			}
		}
	});

	watch(pagoEnBs, (newValue) => {
		const totales2 = {
			totalBs: 0,
			total$: 0,
		};

		for (const item of examenesSeleccionados.value) {
			totales2.total$ += item.precio$;
			totales2.totalBs += item.precio$ * precioDolar.value;
		}

		if (examenesSeleccionados.value.length) {
			if (pagoEnDivisas.value) {
				if (newValue) {
					totales2.totalBs -= newValue;
					totales2.totalBs -= pagoEnDivisas.value * precioDolar.value;
					totales2.total$ -= pagoEnDivisas.value;
					totales2.total$ -= newValue / precioDolar.value;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				} else {
					totales2.totalBs -= pagoEnDivisas.value * precioDolar.value;
					totales2.total$ -= pagoEnDivisas.value;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				}
			} else {
				if (newValue) {
					totales2.totalBs -= newValue;
					totales2.total$ -= newValue / precioDolar.value;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				} else {
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				}
			}
		}
	});

	function obtenerTotales() {
		bs = 0;
		divisas = 0;
		for (const item of examenesSeleccionados.value) {
			divisas += item.precio$;
			bs += item.precio$ * precioDolar.value;
		}
	}

	const saveOrder = () => {
		obtenerTotales();
		const orden: Orden = {
			documentoIdentidad: documentoRef.value.value,
			nombre: nombreRef.value.value,
			apellido: apellidoRef.value.value,
			genero: generoRef.value.value,
			edad: edadRef.value.value,
			procedencia: procedenciaRef.value.value,
			diagnostico: diagnosticoRef.value.value,
			examenes: examenesSeleccionados.value,
			totalEnBs: bs,
			totalEn$: divisas,
			pagoBs: pagoEnBs.value,
			pago$: pagoEnDivisas.value,
			fechaDeCreacion: `${day}/${month}/${year}`,
		};

		if (Object.entries(orden).every(([key, value]) => key === "pagoBs" || key === "pago$" || Boolean(value))) {
			if (totales.total$ != 0 || totales.totalBs != 0) {
				alert("Por favor completar pago");
			} else {
				const toastElement: any = document.getElementById("liveToast");
				const toastBootstrap = Toast.getOrCreateInstance(toastElement);
				console.log(toastElement);
				toastBootstrap.show();
			}
		} else {
			alert("please fill all fields");
		}

		console.log(orden);
	};
</script>

<style scoped>
	@media (width < 576px) {
		ion-content {
			--padding-start: 20px;
			--padding-end: 20px;
		}
	}
</style>
