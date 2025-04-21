<template>
	<ion-page>
		<ion-content>
			<div class="container espermatogramaPDF" ref="espermatograma">
				<div class="info" ref="headerPatientInfo">
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
						<div class="border-bottom border-black mt-1"></div>
						<div class="row mt-2">
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
				</div>
				<div class="espermatograma mt-5">
					<h2 class="text-center">Espermatograma</h2>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Volumen:</div>
						<div class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Hora de Recolección:</div>
						<div class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Contaje:</div>
						<div class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Densidad:</div>
						<div class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Liquefacción:</div>
						<div class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Abstinencia:</div>
						<div class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">PH:</div>
						<div class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Color:</div>
						<div class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Aspecto Microscópico:</div>
						<div class="col-8 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="motilidad mt-5">
					<div class="row px-2 w-100 m-auto">
						<div class="col border border-black text-center fw-bold">Motilidad</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col border border-black text-center">Progresivo Rapido</div>
						<div class="col border border-black text-center">Progresivo Lento</div>
						<div class="col border border-black text-center">No Progresivo</div>
						<div class="col border border-black text-center">Lento</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="Morfología mt-5 mb-5">
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center fw-bold">Morfología</div>
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center fw-bold">Elementos</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Normales:</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Tapering</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Microcefalos</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Macrocefalo</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Observaciones</div>
						<div class="col-4 border border-black text-center">Leucocitos:</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Hematies:</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Celulas EPI:</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Bacterias:</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Mucina:</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Cristales</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="eosina mb-5">
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center fw-bold">Test De Eosina</div>
						<div class="col-4 border border-black text-center fw-bold">Resultado</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Vivos Moviles</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Vivos Inmobiles</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Muertos</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="text-center pdfButton"><button class="btn btn-primary" @click="generatePDF">Create PDF</button></div>
				<div class="text-center pdfButton"><button class="btn btn-primary" @click="guardarCambios">Guardar</button></div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonPage, IonContent } from "@ionic/vue";
	import html2pdf from "html2pdf.js";
	import { ref, onMounted } from "vue";

	const espermatograma = ref();
	let html: string = "";
	const print = ref(false);

	const generatePDF = () => {
		const espermatogramaCopy = espermatograma.value.cloneNode("true");
		const espermatogramaInputs = espermatogramaCopy.querySelectorAll("input");
		const button = espermatogramaCopy.querySelector(".pdfButton");
		button.remove();
		console.log(espermatogramaInputs);
		espermatogramaInputs.forEach((input: any) => {
			const inputValue = input.value;
			input.outerHTML = `<span>${inputValue}</span>`;
		});

		html = espermatogramaCopy.innerHTML;

		const element = html;

		const options = {
			margin: 5,
			filename: `Espermatograma.pdf`,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		if (!print.value) {
			html2pdf().from(element).set(options).save();
			html = "";
		} else {
			return new Promise((resolve, reject) => {
				html2pdf()
					.from(element)
					.set(options)
					.toPdf()
					.get("pdf")
					.then((pdf: { output: (arg0: string) => any }) => {
						const blob = pdf.output("blob");
						resolve(blob);
					})
					.catch((error: any) => {
						console.error("Error generando el PDF:", error);
						reject(error);
					});
			});
		}
	};

	const guardarCambios = () => {
		const espermatogramaCopy = espermatograma.value.cloneNode("true");
		const espermatogramaInputs = espermatogramaCopy.querySelectorAll("input");
		const inputValues: string[] = [];
		const data: { [key: string]: any } = {
			volumen: "",
			recoleccion: "",
			contaje: "",
			densidad: "",
			liquefaccion: "",
			abstinencia: "",
			ph: "",
			color: "",
			aspectoMicro: "",
			progresivoRapido: "",
			progresivoLento: "",
			noProgresivo: "",
			lento: "",
			normales: "",
			tapering: "",
			microcefalos: "",
			macrocefalo: "",
			leucocitos: "",
			hematies: "",
			celulasEPI: "",
			bacterias: "",
			mucina: "",
			cristales: "",
			vivosMobiles: "",
			vivosInmobiles: "",
			muertos: "",
		};

		espermatogramaInputs.forEach((item: any) => {
			if (item.value) {
				inputValues.push(item.value);
			} else {
				inputValues.push("N/A");
			}
		});

		console.log(inputValues);

		Object.keys(data).forEach((key, index) => {
			data[key as keyof typeof data] = inputValues[index];
		});

		console.log(data);
	};
</script>

<style scoped></style>
