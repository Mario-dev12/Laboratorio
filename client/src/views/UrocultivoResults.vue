<template>
	<ion-page>
		<ion-content>
			<div class="container" ref="urocultivoPDF">
				<div ref="headerPatientInfo">
					<div class="header">
						<div class="row">
							<div class="col text-center">
								<img src="/images/laboratorio.png" alt="" />
							</div>
							<div class="col text-center">
								<img src="/images/direccion.png" alt="" />
							</div>
						</div>
					</div>
					<div class="patient-info">
						<div class="border-bottom border-black mt-2"></div>
						<div class="row mt-3 text-center">
							<div class="col">
								<div class="d-inline fw-bold">Paciente: {{ profile?.firstName }}</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">CI: {{ profile?.ci }}</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Edad: {{ profile?.age }}</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Sexo: {{ profile?.genre === "M" ? "Masculino" : "Femenino" }}</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Fecha: {{ day }}/{{ month }}/{{ year }}</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bacteriologico" ref="bacteriologico">
					<h1 class="text-center mt-5 mb-2">Estudio Bacteriológico</h1>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Examen:</div>
						<div class="col-8 border border-black">{{ profileNames ? profileNames[0] : null }}</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Germen:</div>
						<div class="col-8 border border-black">
							<select class="w-100" name="germen" id="germen">
								<option value="">select germen</option>
								<option v-for="(germen, index) in germs" :key="index" :value="germen.nombre">{{ germen.nombre }}</option>
							</select>
						</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Contaje:</div>
						<div class="col-8 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto mb-5">
						<div class="col-4 border border-black">Observaciones:</div>
						<div class="col-8 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="Antibiograma" ref="antibiograma">
					<h1 class="text-center mb-2">Antibiograma</h1>
					<div class="sensibles mb-4">
						<h3>Sensibles:</h3>
						<div class="row w-100 m-auto" ref="sensibles">
							<div class="col-8 border border-black" ref="dropdown1">
								<select class="w-100" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
						</div>
						<div class="agregarSensible text-center">
							<button @click="agregarSensible" class="btn btn-primary mt-2">Agregar Antibiótico</button>
						</div>
					</div>

					<div class="resistentes">
						<h3>Resistentes:</h3>
						<div class="row w-100 m-auto" ref="resistentes">
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
						</div>
						<div class="agregarResistente text-center mb-5">
							<button @click="agregarResistente" class="btn btn-primary mt-2">Agregar Antibiótico</button>
						</div>
					</div>
				</div>
			</div>
			<div class="d-flex justify-content-center mb-4">
				<button class="btn btn-primary" @click="generatePDF">Generate PDF</button>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonPage, IonContent } from "@ionic/vue";
	import html2pdf from "html2pdf.js";
	import { ref, onMounted } from "vue";
	import { useRoute } from "vue-router";
	import { profileStore } from "@/stores/profileStore";

	let html: string = "";
	const urocultivoPDF = ref();
	const sensibles = ref();
	const resistentes = ref();
	const dropdown1 = ref();
	const headerPatientInfo = ref();
	const bacteriologico = ref();
	const antibiograma = ref();
	const route = useRoute();
	const order = ref();
	const profile = ref();
	const profileNames = ref();
	const today = new Date();
	const day = today.getDate();
	const month = today.getMonth() + 1;
	const year = today.getFullYear();
	const store = profileStore();
	const germs = ref();
	const antibioticos = ref();

	onMounted(async () => {
		order.value = route.query;
		profile.value = JSON.parse(order.value.profile);
		profileNames.value = JSON.parse(order.value.profileNames);
		germs.value = await store.fecthBacterium();
		antibioticos.value = await store.fecthAntibiotics();
	});

	function agregarSensible() {
		const dropdown1Copy = dropdown1.value.cloneNode(true);
		sensibles.value.appendChild(dropdown1Copy);
	}

	function agregarResistente() {
		const dropdown1Copy = dropdown1.value.cloneNode(true);
		resistentes.value.appendChild(dropdown1Copy);
	}

	const generatePDF = async () => {
		html = headerPatientInfo.value.innerHTML;
		const bacteriologicoCopy = bacteriologico.value.cloneNode(true);
		const germen = bacteriologico.value.querySelector("#germen").value;
		const bacteriologicoSelect = bacteriologicoCopy.querySelector("select");
		const bacteriologicoInputs = bacteriologicoCopy.querySelectorAll("input");

		// cambiar inputs por spans
		bacteriologicoInputs.forEach((input: any) => {
			const inputValue = input.value;
			input.outerHTML = `<span>${inputValue}</span>`;
		});

		// cambiar select por span
		bacteriologicoSelect.outerHTML = `<span>${germen}</span>`;
		html += bacteriologicoCopy.innerHTML;

		// antibiograma
		const antibiogramaCopy = antibiograma.value.cloneNode(true);
		// quitar botones del PDF
		const agregarSensibleButton = antibiogramaCopy.querySelector(".agregarSensible");
		const agregarResistenteButton = antibiogramaCopy.querySelector(".agregarResistente");
		agregarSensibleButton.remove();
		agregarResistenteButton.remove();

		const sensiblesValues: string[] = [];
		const resistentesValues: string[] = [];
		const sensiblesSelects = sensibles.value.querySelectorAll("select");
		const resistentesSelects = resistentes.value.querySelectorAll("select");
		const sensiblesSelectsCopies = antibiogramaCopy.querySelectorAll(".sensibles select");
		const resistentesSelectsCopies = antibiogramaCopy.querySelectorAll(".resistentes select");

		sensiblesSelects.forEach((item: any) => {
			if (item.value) {
				sensiblesValues.push(item.value);
			} else {
				sensiblesValues.push("N/A");
			}
		});

		resistentesSelects.forEach((item: any) => {
			if (item.value) {
				resistentesValues.push(item.value);
			} else {
				resistentesValues.push("N/A");
			}
		});

		// cambiar selects de tabla sensibles por span
		sensiblesSelectsCopies.forEach((item: any, index: number) => {
			if (sensiblesValues[index] != "N/A") {
				item.outerHTML = `<span>${sensiblesValues[index]}</span>`;
			} else {
				item.outerHTML = `<span style="opacity: 0;">${sensiblesValues[index]}</span>`;
			}
		});

		// cambiar selects de tabla resistentes por span
		resistentesSelectsCopies.forEach((item: any, index: number) => {
			if (resistentesValues[index] != "N/A") {
				item.outerHTML = `<span>${resistentesValues[index]}</span>`;
			} else {
				item.outerHTML = `<span style="opacity: 0;">${resistentesValues[index]}</span>`;
			}
		});

		html += antibiogramaCopy.innerHTML;

		const options = {
			margin: 14,
			filename: "Urocultivo",
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		const element = html;

		html2pdf().from(element).set(options).save();
		html = "";
	};
</script>
<style scoped></style>
