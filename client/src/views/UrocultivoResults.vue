<template>
	<ion-page>
		<ion-content>
			<div class="container" ref="urocultivoPDF">
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
					<div class="row mt-3">
						<div class="col">
							<div class="d-inline fw-bold">Paciente:</div>
						</div>
						<div class="col">
							<div class="d-inline fw-bold">CI:</div>
						</div>
						<div class="col">
							<div class="d-inline fw-bold">Edad:</div>
						</div>
						<div class="col">
							<div class="d-inline fw-bold">Sexo:</div>
						</div>
						<div class="col">
							<div class="d-inline fw-bold">Fecha:</div>
						</div>
					</div>
				</div>
				<div class="bacteriologico mt-5 mb-5">
					<h1 class="text-center mb-2">Estudio Bacteriologico</h1>
					<div class="row p-2 w-100 m-auto">
						<div class="col-4 border border-black">Examen:</div>
						<div class="col-8 border border-black">Urocultivo y Antibiograma</div>
					</div>
					<div class="row p-2 w-100 m-auto">
						<div class="col-4 border border-black">Germen:</div>
						<div class="col-8 border border-black">
							<select class="w-100" name="germen" id="germen">
								<option value="">select germen</option>
								<option v-for="(germen, index) in germenes" :key="index" :value="germen">{{ germen }}</option>
							</select>
						</div>
					</div>
					<div class="row p-2 w-100 m-auto">
						<div class="col-4 border border-black">Contaje:</div>
						<div class="col-8 border border-black p-0"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row p-2 w-100 m-auto">
						<div class="col-4 border border-black">Observaciones:</div>
						<div class="col-8 border border-black p-0"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="Antibiograma mt-5">
					<h1 class="text-center mb-2">Antibiograma</h1>
					<div class="sensibles">
						<h3>Sensibles:</h3>
						<div class="row w-100 m-auto" ref="sensibles">
							<div class="col-8 border border-black" ref="dropdown1">
								<select class="w-100" name="germen" id="germen">
									<option value="">select antibiotico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico">
										{{ antibiotico }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">select antibiotico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico">
										{{ antibiotico }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">select antibiotico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico">
										{{ antibiotico }}
									</option>
								</select>
							</div>
						</div>
					</div>
					<div class="text-center mb-5">
						<button @click="agregarSensible" class="btn btn-primary mt-2">agregar antibiotico</button>
					</div>

					<div class="resistentes">
						<h3>Resistentes:</h3>
						<div class="row w-100 m-auto" ref="resistentes">
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">select antibiotico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico">
										{{ antibiotico }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">select antibiotico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico">
										{{ antibiotico }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="w-100" name="germen" id="germen">
									<option value="">select antibiotico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico">
										{{ antibiotico }}
									</option>
								</select>
							</div>
						</div>
					</div>
					<div class="text-center mb-5">
						<button @click="agregarResistente" class="btn btn-primary mt-2">agregar antibiotico</button>
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
	import { ref } from "vue";

	let html: string = "";
	const urocultivoPDF = ref();
	const sensibles = ref();
	const resistentes = ref();
	const dropdown1 = ref();

	const germenes: string[] = ["germen1", "germen2", "germen3"];
	const antibioticos: string[] = ["anti1", "anti2", "anti3", "anti4"];

	const generatePDF = async () => {
		html = urocultivoPDF.value.innerHTML;

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

	function agregarSensible() {
		const dropdown1Copy = dropdown1.value.cloneNode(true);
		sensibles.value.appendChild(dropdown1Copy);
	}

	function agregarResistente() {
		const dropdown1Copy = dropdown1.value.cloneNode(true);
		resistentes.value.appendChild(dropdown1Copy);
	}
</script>
<style scoped></style>
