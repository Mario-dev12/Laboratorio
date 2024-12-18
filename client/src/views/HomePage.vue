<template>
	<ion-page>
		<ion-content :fullscreen="true">
			<div class="container mt-4 p-3 bg-body-secondary rounded">
				<div class="w-100 m-auto">
					<label class="row w-100 m-auto" for="documento">Documento de identidad</label>
					<div class="row w-100 m-auto">
						<input class="col-11" type="text" placeholder="Documento de identidad" name="documento" />
						<button class="btn btn-success col w-auto ms-1">🔎</button>
					</div>
				</div>
				<div class="mt-2">
					<label class="me-1" for="genero">Genero</label>
					<input class="w-auto me-3" type="text" placeholder="Genero" name="genero" />
					<label class="me-1" for="edad">Edad</label>
					<input class="w-auto" type="text" placeholder="Edad" name="edad" />
					<label class="ms-3" for="procedencia">Procedencia</label>
					<select class="ms-1 p-1" name="procedencia" id="precedencia">
						<option disabled selected>Seleccionar</option>
						<option value="procedencia1">procedencia1</option>
						<option value="procedencia2">procedencia2</option>
					</select>
				</div>
				<div class="mt-2 d-flex">
					<label class="me-1" for="diagnostico">Motivo/Diagnostico:</label>
					<textarea name="diagnostico" id="diagnostico" cols="50"></textarea>
				</div>
			</div>
			<div class="bg-info container py-2 rounded mt-2">
				<div class="mt-2">
					<label class="me-1" for="examen">Tipo de Examen:</label>
					<select class="ms-1 p-1" name="examen" id="examen" v-model="tipoDeExamen" @change="agregarExamen()">
						<option value="">Seleccionar</option>
						<option value="Perfil 20">Perfil 20</option>
						<option value="Perfil Tiroideo">Perfil Tiroideo</option>
					</select>
				</div>
				<div class="mt-2">
					<table class="table">
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
								<td><button class="btn btn-danger" @click="eliminarExamen(value.nombre)">borrar</button></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="factura container mt-2 bg-dark-subtle rounded p-2">
				<div class="row">
					<div class="col">Numero de orden</div>
					<div class="col">1</div>
				</div>
				<div class="row">
					<div class="col">Fecha</div>
					<div class="col">{{ `${day}/${month}/${year}` }}</div>
				</div>
				<div class="row">
					<div class="col">Total En Bs</div>
					<div class="col">Bs: {{ totales.totalBs }}</div>
				</div>
				<div class="row">
					<div class="col">Total En $</div>
					<div class="col">$: {{ totales.total$.toFixed(2) }}</div>
				</div>
				<div class="row">
					<div class="col">Pago Bs</div>
					<div class="col">
						<input type="text" v-model="pagoEnBs" />
					</div>
				</div>
				<div class="row mt-1">
					<div class="col">Pago $</div>
					<div class="col">
						<input type="text" v-model="pagoEnDivisas" />
					</div>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { ref, watch, onMounted } from "vue";
	import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from "@ionic/vue";
	import { userStore } from "@/stores/userStore";

	const tipoDeExamen = ref("");
	const pagoEnDivisas = ref();
	const pagoEnBs = ref();
	const examenesSeleccionados = ref<Examen[]>([]);
	const today = new Date();
	const day = today.getUTCDate();
	const month = today.getUTCMonth() + 1;
	const year = today.getFullYear();
	console.log(day);
	console.log(month);
	console.log(year);
	const precioDolar = 48;
	const user = userStore();

	onMounted(async () => {
		const usuarios = await user.fecthUserByName("Juan");
		console.log(usuarios);
	});

	interface Examen {
		nombre: string;
		precio$: number;
		descripcion: string;
	}

	const totales = {
		totalBs: 0,
		total$: 0,
	};

	const examenes: Examen[] = [
		{ nombre: "Perfil 20", precio$: 10, descripcion: "examen general de salud" },
		{ nombre: "Perfil Tiroideo", precio$: 10, descripcion: "examen de la tiroides" },
	];

	const agregarExamen = () => {
		console.log(examenesSeleccionados.value);
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
		console.log("watching");
		console.log(newValue);
		console.log(oldValue);
		if (newValue.length) {
			if (newValue.length < oldValue.length) {
				totales.totalBs -= newValue[0].precio$ * precioDolar;
				totales.total$ -= newValue[0].precio$;
			} else if (newValue.length >= oldValue.length) {
				totales.totalBs += newValue[0].precio$ * precioDolar;
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
			totales2.totalBs += item.precio$ * precioDolar;
		}

		if (examenesSeleccionados.value.length) {
			if (pagoEnBs.value) {
				if (newValue) {
					totales2.totalBs -= newValue * precioDolar;
					totales2.totalBs -= pagoEnBs.value;
					totales2.total$ -= newValue;
					totales2.total$ -= pagoEnBs.value / precioDolar;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				} else {
					totales2.totalBs -= pagoEnBs.value;
					totales2.total$ -= pagoEnBs.value / precioDolar;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				}
			} else {
				if (newValue) {
					totales2.totalBs -= newValue * precioDolar;
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
			totales2.totalBs += item.precio$ * precioDolar;
		}

		if (examenesSeleccionados.value.length) {
			if (pagoEnDivisas.value) {
				if (newValue) {
					totales2.totalBs -= newValue;
					totales2.totalBs -= pagoEnDivisas.value * precioDolar;
					totales2.total$ -= pagoEnDivisas.value;
					totales2.total$ -= newValue / precioDolar;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				} else {
					totales2.totalBs -= pagoEnDivisas.value * precioDolar;
					totales2.total$ -= pagoEnDivisas.value;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				}
			} else {
				if (newValue) {
					totales2.totalBs -= newValue;
					totales2.total$ -= newValue / precioDolar;
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				} else {
					totales.totalBs = totales2.totalBs;
					totales.total$ = totales2.total$;
				}
			}
		}
	});
</script>

<style scoped></style>
