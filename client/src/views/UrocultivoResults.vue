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
				</div>
				<div class="Antibiograma mt-5">
					<h1 class="text-center mb-2">Antibiograma</h1>
					<div class="sensibles">
						<h3>Sensibles:</h3>
						<div class="row mb-5 w-100 m-auto">
							<div class="col-8 border border-black">Piperaciclina</div>
							<div class="col-8 border border-black">Piperaciclina</div>
							<div class="col-8 border border-black">Piperaciclina</div>
							<div class="col-8 border border-black">Piperaciclina</div>
							<div class="col-8 border border-black">Piperaciclina</div>
						</div>
					</div>
					<div class="resistentes">
						<h3>Resistentes:</h3>
						<div class="row mb-5 w-100 m-auto">
							<div class="col-8 border border-black">Sulfametoxazol</div>
							<div class="col-8 border border-black">Sulfametoxazol</div>
							<div class="col-8 border border-black">Sulfametoxazol</div>
							<div class="col-8 border border-black">Sulfametoxazol</div>
							<div class="col-8 border border-black">Sulfametoxazol</div>
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
	import { ref } from "vue";

	let html: string = "";
	const urocultivoPDF = ref();

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
</script>
<style scoped></style>
