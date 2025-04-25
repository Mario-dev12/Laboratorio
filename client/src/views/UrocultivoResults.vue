<template>
	<ion-page>
		<ion-content>
			<div class="container" ref="urocultivoPDF">
				<div class="info" ref="headerPatientInfo">
					<div class="header">
						<div class="row">
							<div class="col text-center">
								<img src="/images/laboratorio.png" alt="" style="width: 55%" />
							</div>
							<div class="col text-center">
								<img src="/images/direccion.png" alt="" style="width: 80%" />
							</div>
						</div>
					</div>
					<div class="patient-info">
						<div class="border-bottom border-black mt-1"></div>
						<div class="row mt-2">
							<div class="col">
								<div class="d-inline fw-bold">Paciente:</div>
								{{ profile?.firstName }} {{ profile?.lastName }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">CI:</div>
								{{ profile?.ci }}
							</div>
							<div v-if="profile?.doctor" class="col">
								<div class="d-inline fw-bold">Dr:</div>
								{{ profile?.doctor }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Edad:</div>
								{{ profile?.age }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Sexo:</div>
								{{ profile?.genre === "M" ? "Masculino" : "Femenino" }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Fecha:</div>
								{{ day }}/{{ month }}/{{ year }}
							</div>
						</div>
					</div>
				</div>
				<div class="bacteriologico" ref="bacteriologico">
					<h3 class="text-center mt-5 mb-2">Estudio Bacteriológico</h3>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Examen:</div>
						<div class="col-8 border border-black">{{ profileNames ? profileNames[0] : null }}</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Germen:</div>
						<div v-if="resultData" class="col-8 border border-black">
							<select v-model="resultData.nombreBacteria" class="custom-select" name="germen" id="germen">
								<option value="">Seleccionar Germen</option>
								<option v-for="(germen, index) in germs" :key="index" :value="germen.nombre">{{ germen.nombre }}</option>
							</select>
						</div>
						<div v-else class="col-8 border border-black">
							<select class="custom-select" name="germen" id="germen">
								<option value="">Seleccionar Germen</option>
								<option v-for="(germen, index) in germs" :key="index" :value="germen.nombre">{{ germen.nombre }}</option>
							</select>
						</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Contaje:</div>
						<div v-if="resultData" class="col-8 border border-black">
							<input v-model="resultData.contaje" class="w-100 border-0" type="text" />
						</div>
						<div v-else class="col-8 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto mb-3">
						<div class="col-4 border border-black">Observaciones:</div>
						<div v-if="resultData" class="col-8 border border-black">
							<input v-model="resultData.observacion" class="w-100 border-0" type="text" />
						</div>
						<div v-else class="col-8 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="Antibiograma" ref="antibiograma">
					<h3 class="text-center mb-2">Antibiograma</h3>
					<div v-if="resultSensibles" class="sensibles" style="margin-left: 10px">
						<h5>Sensibles:</h5>
						<div class="row w-100 m-auto" ref="sensibles">
							<div v-for="(selected, index) in resultSensibles" :key="index" class="col-8 border border-black">
								<select
									class="custom-select"
									name="germen"
									:id="'germen' + index"
									v-model="resultSensibles[index].nombreAntibiotico">
									<option value="">Seleccionar Antibiótico</option>
									<option
										v-for="(antibiotico, index) in antibioticos"
										:key="index"
										:value="antibiotico.nombre"
										:disabled="resultSensibles.includes(antibiotico.nombre)">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
						</div>

						<div class="agregarSensible text-center mb-2">
							<button @click="agregarSensible" class="btn btn-primary mt-2">Agregar Antibiótico</button>
						</div>
					</div>

					<div v-else class="sensibles" style="margin-left: 10px">
						<h5>Sensibles:</h5>
						<div class="row w-100 m-auto" ref="sensibles">
							<div class="col-8 border border-black" ref="dropdown1">
								<select class="custom-select" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="custom-select" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="custom-select" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
						</div>
						<div class="agregarSensible text-center mb-2">
							<button @click="agregarSensible" class="btn btn-primary mt-2">Agregar Antibiótico</button>
						</div>
					</div>

					<div v-if="resultResistentes" class="resistentes" style="margin-left: 10px">
						<h5>Resistentes:</h5>
						<div class="row w-100 m-auto" ref="resistentes">
							<div v-for="(selected, index) in resultResistentes" :key="index" class="col-8 border border-black">
								<select
									class="custom-select"
									name="germen"
									:id="'germen' + index"
									v-model="resultResistentes[index].nombreAntibiotico">
									<option value="">Seleccionar Antibiótico</option>
									<option
										v-for="(antibiotico, index) in antibioticos"
										:key="index"
										:value="antibiotico.nombre"
										:disabled="resultResistentes.includes(antibiotico.nombre)">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
						</div>
						<div class="agregarResistente text-center mb-2">
							<button @click="agregarResistente" class="btn btn-primary mt-2">Agregar Antibiótico</button>
						</div>
					</div>

					<div v-else class="resistentes" style="margin-left: 10px">
						<h5>Resistentes:</h5>
						<div class="row w-100 m-auto" ref="resistentes">
							<div class="col-8 border border-black">
								<select class="custom-select" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="custom-select" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
							<div class="col-8 border border-black">
								<select class="custom-select" name="germen" id="germen">
									<option value="">Seleccionar Antibiótico</option>
									<option v-for="(antibiotico, index) in antibioticos" :key="index" :value="antibiotico.nombre">
										{{ antibiotico.nombre }}
									</option>
								</select>
							</div>
						</div>
						<div class="agregarResistente text-center mb-2">
							<button @click="agregarResistente" class="btn btn-primary mt-2">Agregar Antibiótico</button>
						</div>
					</div>
				</div>
				<div class="firma-sello" ref="firmaSello">
					<div class="row justify-content-end">
						<div class="sello-img col-4"><img class="h-100 w-100" src="/images/selloLab3.png" alt="" /></div>
					</div>
					<div class="row justify-content-end">
						<div class="firma-img col-4">
							<img class="h-100 w-100" style="margin-left: 25px" src="/images/firmaLab3-sinfondo.png" alt="" />
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<button class="col btn btn-primary me-1" @click="guardarCambios">Guardar Cambios</button>
					<button class="col btn btn-primary me-1" @click="generatePDF">Generar PDF</button>
					<button class="col btn btn-primary me-1" @click="sendEmail">Enviar por Correo</button>
					<button class="col btn btn-primary me-1" @click="sharePDFViaWhatsApp">Compartir PDF por WhatsApp</button>
					<button class="col btn btn-primary me-1" @click="enviarCorreo">Compartir PDF por Mailto</button>
					<button class="col btn btn-primary me-1" @click="printPDF">Imprimir PDF</button>
					<button class="col btn btn-primary me-1" @click="pdfCover">Imprimir Portada</button>
				</div>
			</div>
			<ion-toast
				:class="toast.class"
				:icon="toast.icon"
				:is-open="isOpen"
				:message="toast.message"
				duration="2000"
				@didDismiss="setOpen(false)"
				position="top">
			</ion-toast>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonPage, IonContent, IonToast } from "@ionic/vue";
	import html2pdf from "html2pdf.js";
	import { ref, onMounted } from "vue";
	import { useRoute } from "vue-router";
	import { profileStore } from "@/stores/profileStore";
	import { useRouter } from "vue-router";
	import { orderStore } from "@/stores/orderStore";
	import { mailStore } from "@/stores/mailStore";
	import { checkboxOutline } from "ionicons/icons";

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
	const router = useRouter();
	const pdfFileName = ref();
	const ordersStore = orderStore();
	const mailsStore = mailStore();
	const print = ref(false);
	const result = ref();
	const resultData = ref();
	const resultSensibles = ref();
	const resultResistentes = ref();
	const firmaSello = ref();
	const isOpen = ref(false);

	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
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

	onMounted(async () => {
		order.value = route.query;
		profile.value = JSON.parse(order.value.profile);
		profileNames.value = JSON.parse(order.value.profileNames);
		germs.value = await store.fecthBacterium();
		antibioticos.value = await store.fecthAntibiotics();
		result.value = await store.fetchCultiveResult(profile.value.orders[0].idOrder, profileNames.value);
		resultData.value = result.value.resultado;
		resultSensibles.value = result.value.sensibles;
		resultResistentes.value = result.value.resistentes;
	});

	router.beforeEach(async (to, from, next) => {
		if (to.name === "UroResults") {
			order.value = to.query;
			profile.value = JSON.parse(order.value.profile);
			profileNames.value = JSON.parse(order.value.profileNames);
			germs.value = await store.fecthBacterium();
			antibioticos.value = await store.fecthAntibiotics();
			result.value = await store.fetchCultiveResult(profile.value.orders[0].idOrder, profileNames.value);
			resultData.value = result.value.resultado;
			resultSensibles.value = result.value.sensibles;
			resultResistentes.value = result.value.resistentes;
		}
		next();
	});

	function agregarSensible() {
		if (resultSensibles.value) {
			resultSensibles.value.push([]);
		} else {
			const dropdown1Copy = dropdown1.value.cloneNode(true);
			sensibles.value.appendChild(dropdown1Copy);
		}
	}

	function agregarResistente() {
		if (resultResistentes.value) {
			resultResistentes.value.push([]);
		} else {
			const dropdown1Copy = dropdown1.value.cloneNode(true);
			resistentes.value.appendChild(dropdown1Copy);
		}
	}

	const generatePDFWithoutSignature: any = async () => {
		html = headerPatientInfo.value.innerHTML;
		const bacteriologicoCopy = bacteriologico.value.cloneNode(true);
		const germen = bacteriologico.value.querySelector("#germen").value;
		const bacteriologicoSelect = bacteriologicoCopy.querySelector("select");
		const bacteriologicoInputs = bacteriologicoCopy.querySelectorAll("input");
		const divFirmaSelloCopy = firmaSello.value.cloneNode(true);

		bacteriologicoInputs.forEach((input: any) => {
			const inputValue = input.value;
			input.outerHTML = `<span>${inputValue}</span>`;
		});

		bacteriologicoSelect.outerHTML = `<span>${germen}</span>`;
		html += bacteriologicoCopy.innerHTML;

		const antibiogramaCopy = antibiograma.value.cloneNode(true);
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

		sensiblesSelectsCopies.forEach((item: any, index: number) => {
			if (sensiblesValues[index] != "N/A") {
				item.outerHTML = `<span>${sensiblesValues[index]}</span>`;
			} else {
				item.outerHTML = `<span style="opacity: 0;">${sensiblesValues[index]}</span>`;
			}
		});

		resistentesSelectsCopies.forEach((item: any, index: number) => {
			if (resistentesValues[index] != "N/A") {
				item.outerHTML = `<span>${resistentesValues[index]}</span>`;
			} else {
				item.outerHTML = `<span style="opacity: 0;">${resistentesValues[index]}</span>`;
			}
		});

		html += antibiogramaCopy.innerHTML;

		html += divFirmaSelloCopy.innerHTML;

		const firstName = profile.value.firstName;
		const lastName = profile.value.lastName;

		const today = new Date();
		const year = today.getFullYear();
		const month = String(today.getMonth() + 1).padStart(2, "0");
		const day = String(today.getDate()).padStart(2, "0");
		const formattedDate = `${day}-${month}-${year}`;

		const options = {
			margin: 1,
			filename: `Urocultivo_${lastName}_${firstName}_${formattedDate}.pdf`,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		pdfFileName.value = options.filename;

		const element = html;

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

	const generatePDF: any = async () => {
		html = headerPatientInfo.value.innerHTML;
		const bacteriologicoCopy = bacteriologico.value.cloneNode(true);
		const germen = bacteriologico.value.querySelector("#germen").value;
		const bacteriologicoSelect = bacteriologicoCopy.querySelector("select");
		const bacteriologicoInputs = bacteriologicoCopy.querySelectorAll("input");

		bacteriologicoInputs.forEach((input: any) => {
			const inputValue = input.value;
			input.outerHTML = `<span>${inputValue}</span>`;
		});

		bacteriologicoSelect.outerHTML = `<span>${germen}</span>`;
		html += bacteriologicoCopy.innerHTML;

		const antibiogramaCopy = antibiograma.value.cloneNode(true);
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

		sensiblesSelectsCopies.forEach((item: any, index: number) => {
			if (sensiblesValues[index] != "N/A") {
				item.outerHTML = `<span>${sensiblesValues[index]}</span>`;
			} else {
				item.outerHTML = `<span style="opacity: 0;">${sensiblesValues[index]}</span>`;
			}
		});

		resistentesSelectsCopies.forEach((item: any, index: number) => {
			if (resistentesValues[index] != "N/A") {
				item.outerHTML = `<span>${resistentesValues[index]}</span>`;
			} else {
				item.outerHTML = `<span style="opacity: 0;">${resistentesValues[index]}</span>`;
			}
		});

		html += antibiogramaCopy.innerHTML;

		const firstName = profile.value.firstName;
		const lastName = profile.value.lastName;

		const today = new Date();
		const year = today.getFullYear();
		const month = String(today.getMonth() + 1).padStart(2, "0");
		const day = String(today.getDate()).padStart(2, "0");
		const formattedDate = `${day}-${month}-${year}`;

		const options = {
			margin: 14,
			filename: `Urocultivo_${lastName}_${firstName}_${formattedDate}.pdf`,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		pdfFileName.value = options.filename;

		const element = html;

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

	async function guardarCambios() {
		const bacteriologicoCopy = bacteriologico.value.cloneNode(true);
		const germen = bacteriologico.value.querySelector("#germen").value;
		const bacteriologicoInputs = bacteriologicoCopy.querySelectorAll("input");
		const contaje = bacteriologicoInputs[0].value;
		const observaciones = bacteriologicoInputs[1].value;
		const sensiblesValues: string[] = [];
		const resistentesValues: string[] = [];
		const sensiblesSelects = sensibles.value.querySelectorAll("select");
		const resistentesSelects = resistentes.value.querySelectorAll("select");

		sensiblesSelects.forEach((item: any) => {
			if (item.value) {
				sensiblesValues.push(item.value);
			}
		});

		resistentesSelects.forEach((item: any) => {
			if (item.value) {
				resistentesValues.push(item.value);
			}
		});

		const data = {
			idOrder: profile.value.orders[0].idOrder,
			idBacteria: germen,
			contaje: contaje,
			observacion: observaciones,
		};

		await store.createCultiveResults(data, sensiblesValues, resistentesValues);

		showToast("Cambios guradados exitosamnte!", "creado", checkboxOutline);
	}

	async function sendEmail() {
		const profileId = profile.value.orders[0].idOrder;
		const emailData = {
			to: profile.value.email,
			subject: "Resultados Exámenes",
			text: "Adjunto los resultados de los exámenes. Por favor confirmar la llegada de este correo. Gracias de antemano",
			attachment: pdfFileName.value,
		};

		const data = {
			id: profileId,
			status: "Pendiente de imprimir",
		};
		await ordersStore.updateStatusOrder(profileId, data);

		mailsStore.sendEmail(emailData);
	}

	const sharePDFViaWhatsApp = async () => {
		const profileId = profile.value.orders[0].idOrder;
		const data = {
			id: profileId,
			status: "Pendiente de imprimir",
		};
		await ordersStore.updateStatusOrder(profileId, data);
		await generatePDFWithoutSignature();
		const message = `Adjuntos resultados del laboratorio`
		if (!profile.value.phone || profile.value.phone === "" || profile.value.phone === undefined || profile.value.phone === null) {
			const whatsappUrl = `https://web.whatsapp.com/send`;
			window.open(whatsappUrl, "_blank");
		} else {
			const whatsappUrl = `https://web.whatsapp.com/send?phone=${profile.value.phone.substring(1)}&text=${encodeURIComponent(
				message
			)}`;
			window.open(whatsappUrl, "_blank");
		}
	};

	const enviarCorreo = async () => {
		const profileId = profile.value.orders[0].idOrder;
		const data = {
			id: profileId,
			status: "Pendiente de imprimir",
		};
		await ordersStore.updateStatusOrder(profileId, data);
		const recipientEmail = "labmadreemilia@gmail.com";
		const subject = "Resultados Exámenes";
		const body = "Adjunto los resultados de los exámenes. Por favor confirmar la llegada de este correo. Gracias de antemano";
		const mailtoLink = `https://mail.google.com/mail/?view=cm&fs=1&to=${recipientEmail}&su=${encodeURIComponent(
			subject
		)}&body=${encodeURIComponent(body)}`;
		window.open(mailtoLink, "_blank");
	};

	const printPDF = async () => {
		print.value = true;
		const pdfBlob = await generatePDF();

		const pdfUrl = URL.createObjectURL(pdfBlob);

		const printWindow = window.open(pdfUrl);

		print.value = false;

		if (printWindow) {
			printWindow.onload = function () {
				printWindow.print();
				printWindow.onafterprint = function () {
					printWindow.close();
				};
			};
		} else {
			console.error("No se pudo abrir la ventana de impresión.");
		}
	};

	const pdfCover = async () => {
		const profileRefCopy = headerPatientInfo.value.cloneNode(true);

		html = profileRefCopy.innerHTML;

		const element = html;

		const filename = `portada.pdf`;

		const options = {
			margin: 6,
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		html2pdf().from(element).set(options).save();
	};
</script>
<style scoped>
	.custom-select {
		width: 100%;
		border: none;
		outline: none;
		box-shadow: none;
	}

	.col-8 {
		position: relative;
	}

	.firma-img {
		height: 65px;
		width: 180px;
	}

	.sello-img {
		height: 50px;
		width: 150px;
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
