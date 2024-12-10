<template>
	<nav class="navbar navbar-expand-lg bg-body-secondary p-0">
		<div class="container-fluid p-0">
			<button
				class="navbar-toggler"
				type="button"
				data-bs-toggle="collapse"
				data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent"
				aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<a class="nav-item bg-danger text-center p-1 text-decoration-none text-black" href="#">
						<img src="/images/resultados.png" alt="" />
						<p class="m-0">Resultados</p>
					</a>
					<a class="nav-item bg-primary text-center p-1 text-decoration-none text-black" href="#">
						<img src="/images/especialista.png" alt="" />
						<p class="m-0">Especialista</p>
					</a>
					<a class="nav-item bg-warning text-center p-1 text-decoration-none text-black" href="#">
						<img src="/images/lista.png" alt="" />
						<p class="m-0">Lista De Precios</p>
					</a>
					<a class="nav-item bg-success text-center p-1 text-decoration-none text-black" href="#">
						<img src="/images/reactivos.png" alt="" />
						<p class="m-0">Reactivos</p>
					</a>
					<button class="nav-item bg-info text-center p-1 text-decoration-none text-black" @click="showCrearOrden()">
						<img src="/images/reactivos.png" alt="" />
						<p class="m-0">Crear Orden</p>
					</button>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container mt-4 p-3 bg-body-secondary rounded" v-if="showCrearOrdenRef">
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
	<div class="bg-info container py-2 rounded mt-2" v-if="showCrearOrdenRef">
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
						<td>Bs: {{ value.preciobs }}</td>
						<td>$: {{ value.precio$ }}</td>
						<td><button class="btn btn-danger" @click="eliminarExamen(value.nombre)">borrar</button></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="factura container mt-2 bg-dark-subtle rounded p-2" v-if="showCrearOrdenRef">
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
			<div class="col">$: {{ totales.total$ }}</div>
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
		bs: {{ pagoEnBs }} $: {{ pagoEnDivisas }}
	</div>
</template>

<script setup lang="ts">
	import { ref, watch } from "vue";

	const showCrearOrdenRef = ref(false);
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

	interface Examen {
		nombre: string;
		preciobs: number;
		precio$: number;
		descripcion: string;
	}

	let totales = {
		totalBs: 0,
		total$: 0,
	};

	const examenes: Examen[] = [
		{ nombre: "Perfil 20", preciobs: 400, precio$: 10, descripcion: "examen general de salud" },
		{ nombre: "Perfil Tiroideo", preciobs: 400, precio$: 10, descripcion: "examen de la tiroides" },
	];

	function showCrearOrden() {
		showCrearOrdenRef.value = !showCrearOrdenRef.value;
	}

	const agregarExamen = () => {
		totales = {
			totalBs: 0,
			total$: 0,
		};
		for (const item of examenes) {
			if (item.nombre === tipoDeExamen.value && !examenesSeleccionados.value.includes(item)) {
				examenesSeleccionados.value.push(item);
				examenesSeleccionados.value = [...examenesSeleccionados.value];
			}
		}

		tipoDeExamen.value = "";
		console.log(examenesSeleccionados.value);
	};

	function eliminarExamen(examen: string) {
		totales = {
			totalBs: 0,
			total$: 0,
		};
		examenesSeleccionados.value = examenesSeleccionados.value.filter((item) => {
			return item.nombre !== examen;
		});
	}

	watch(examenesSeleccionados, (newValue) => {
		console.log("watching");
		if (newValue.length) {
			for (const item of newValue) {
				totales.totalBs += item.preciobs;
				totales.total$ += item.precio$;
			}
		}
		console.log(newValue);
		console.log(totales);
	});
</script>

<style scoped></style>
