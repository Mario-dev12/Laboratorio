<template>
	<ion-page>
		<ion-content>
			<div class="container espermatogramaPDF" ref="espermatograma">
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
				<div class="espermatograma mt-5">
					<h3 class="text-center">Espermatograma</h3>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Volumen:</div>
						<div v-if="resultEspermatograma" class="col-3 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.volumen" />
						</div>
						<div v-else class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Hora de Recolección:</div>
						<div v-if="resultEspermatograma" class="col-2 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.hora_recoleccion" />
						</div>
						<div v-else class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Contaje:</div>
						<div v-if="resultEspermatograma" class="col-3 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.contaje" />
						</div>
						<div v-else class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Densidad:</div>
						<div v-if="resultEspermatograma" class="col-2 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.densidad" />
						</div>
						<div v-else class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Liquefacción:</div>
						<div v-if="resultEspermatograma" class="col-3 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.liquefaccion" />
						</div>
						<div v-else class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Abstinencia:</div>
						<div v-if="resultEspermatograma" class="col-2 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.abstinencia" />
						</div>
						<div v-else class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">PH:</div>
						<div v-if="resultEspermatograma" class="col-3 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.ph" />
						</div>
						<div v-else class="col-3 border border-black"><input class="w-100 border-0" type="text" /></div>
						<div class="col-4 border border-black">Color:</div>
						<div v-if="resultEspermatograma" class="col-2 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.color" />
						</div>
						<div v-else class="col-2 border border-black"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Aspecto Macroscópico:</div>
						<div v-if="resultEspermatograma" class="col-8 border border-black">
							<input class="w-100 border-0" type="text" v-model="resultEspermatograma.aspecto_macroscopico" />
						</div>
						<div v-else class="col-8 border border-black"><input class="w-100 border-0" type="text" /></div>
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
						<div v-if="resultMotilidad" class="col border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMotilidad.progresivo_rapido" />
						</div>
						<div v-else class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div v-if="resultMotilidad" class="col border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMotilidad.progresivo_lento" />
						</div>
						<div v-else class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div v-if="resultMotilidad" class="col border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMotilidad.no_progresivo" />
						</div>
						<div v-else class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div v-if="resultMotilidad" class="col border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMotilidad.lento" />
						</div>
						<div v-else class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
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
						<div class="col-4 border border-black text-center" style="font-weight: bold">60%</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Tapering</div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">25%</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Microcefalos</div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">8%</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Macrocefalo</div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">7%</div>
						<div class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Observaciones</div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">Leucocitos:</div>
						<div v-if="resultMorfologia" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMorfologia.leucocitos" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">Hematies:</div>
						<div v-if="resultMorfologia" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMorfologia.hematies" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">Celulas EPI:</div>
						<div v-if="resultMorfologia" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMorfologia.celulas_epi" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">Bacterias:</div>
						<div v-if="resultMorfologia" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMorfologia.bacterias" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">Mucina:</div>
						<div v-if="resultMorfologia" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultMorfologia.mucina" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center" style="font-weight: bold">Cristales</div>
						<div v-if="resultMorfologia" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="result.morfologia.cristales" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
				</div>
				<div class="eosina mb-5">
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center fw-bold">Test De Eosina</div>
						<div class="col-4 border border-black text-center fw-bold">Resultado</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Vivos Moviles</div>
						<div v-if="resultTestEosina" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultTestEosina.vivos_moviles" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Vivos Inmobiles</div>
						<div v-if="resultTestEosina" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultTestEosina.vivos_inmoviles" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Muertos</div>
						<div v-if="resultTestEosina" class="col-4 border border-black text-center">
							<input class="w-100 border-0" type="text" v-model="resultTestEosina.muertos" />
						</div>
						<div v-else class="col-4 border border-black text-center"><input class="w-100 border-0" type="text" /></div>
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
				<div class="row mb-3 pdfButton">
					<button class="col btn btn-primary me-1" @click="guardarCambios">Guardar Cambios</button>
					<button class="col btn btn-primary me-1" @click="generatePDF">Generar PDF</button>
					<button class="col btn btn-primary me-1" @click="sendEmail">Enviar por Correo</button>
					<button class="col btn btn-primary me-1" @click="sharePDFViaWhatsApp">Compartir PDF por WhatsApp</button>
					<button class="col btn btn-primary me-1" @click="enviarCorreo">Compartir PDF por Mailto</button>
					<button class="col btn btn-primary me-1" @click="printPDF">Imprimir PDF</button>
					<button class="col btn btn-primary me-1" @click="pdfCover">Imprimir Portada</button>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonPage, IonContent } from "@ionic/vue";
	import html2pdf from "html2pdf.js";
	import { ref, onMounted } from "vue";
	import { useRoute } from "vue-router";
	import { useRouter } from "vue-router";
	import { orderStore } from "@/stores/orderStore";
	import { mailStore } from "@/stores/mailStore";
	import { profileStore } from "@/stores/profileStore";

	const espermatograma = ref();
	let html: string = "";
	const print = ref(false);
	const profile = ref();
	const order = ref();
	const result = ref();
	const route = useRoute();
	const router = useRouter();
	const today = new Date();
	const day = today.getDate();
	const month = today.getMonth() + 1;
	const year = today.getFullYear();
	const pdfFileName = ref();
	const ordersStore = orderStore();
	const mailsStore = mailStore();
	const firmaSello = ref();
	const headerPatientInfo = ref();
	const store = profileStore();
	const profileNames = ref();
	const resultEspermatograma = ref();
	const resultMotilidad = ref();
	const resultMorfologia = ref();
	const resultTestEosina = ref();

	onMounted(async () => {
		order.value = route.query;
		profile.value = JSON.parse(order.value.profile);
		profileNames.value = JSON.parse(order.value.profileNames);
		result.value = await store.fetchSpermiogramResult(profile.value.orders[0].idOrder, profileNames.value);
		resultEspermatograma.value = result.value.espermatograma;
		resultMotilidad.value = result.value.motilidad;
		resultMorfologia.value = result.value.morfologia;
		resultTestEosina.value = result.value.test_eosina;
	});

	router.beforeEach(async (to, from, next) => {
		if (to.name === "Espermatograma") {
			order.value = route.query;
			profile.value = JSON.parse(order.value.profile);
			profileNames.value = JSON.parse(order.value.profileNames);
			result.value = await store.fetchSpermiogramResult(profile.value.orders[0].idOrder, profileNames.value);
			resultEspermatograma.value = result.value.espermatograma;
			resultMotilidad.value = result.value.motilidad;
			resultMorfologia.value = result.value.morfologia;
			resultTestEosina.value = result.value.test_eosina;
		}
		next();
	});

	const generatePDF: any = () => {
		const espermatogramaCopy = espermatograma.value.cloneNode("true");
		const espermatogramaInputs = espermatogramaCopy.querySelectorAll("input");
		const button = espermatogramaCopy.querySelector(".pdfButton");
		const formaDiv = espermatogramaCopy.querySelector(".firma-sello");
		formaDiv.remove();
		button.remove();
		espermatogramaInputs.forEach((input: any) => {
			const inputValue = input.value;
			if (input.value) {
				input.outerHTML = `<span>${inputValue}</span>`;
			} else {
				input.outerHTML = `<span style="opacity: 0;">N/A</span>`;
			}
		});

		html = espermatogramaCopy.innerHTML;

		const element = html;

		const firstName = profile.value.firstName;
		const lastName = profile.value.lastName;

		const today = new Date();
		const year = today.getFullYear();
		const month = String(today.getMonth() + 1).padStart(2, "0");
		const day = String(today.getDate()).padStart(2, "0");
		const formattedDate = `${day}-${month}-${year}`;

		const options = {
			margin: 5,
			filename: `Espermatograma__${lastName}_${firstName}_${formattedDate}.pdf`,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		pdfFileName.value = options.filename;

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

	const generatePDFWithoutSignature = () => {
		const espermatogramaCopy = espermatograma.value.cloneNode("true");
		const espermatogramaInputs = espermatogramaCopy.querySelectorAll("input");
		const button = espermatogramaCopy.querySelector(".pdfButton");
		button.remove();

		espermatogramaInputs.forEach((input: any) => {
			const inputValue = input.value;
			if (input.value) {
				input.outerHTML = `<span>${inputValue}</span>`;
			} else {
				input.outerHTML = `<span style="opacity: 0;">N/A</span>`;
			}
		});

		html = espermatogramaCopy.innerHTML;

		const element = html;

		const firstName = profile.value.firstName;
		const lastName = profile.value.lastName;

		const today = new Date();
		const year = today.getFullYear();
		const month = String(today.getMonth() + 1).padStart(2, "0");
		const day = String(today.getDate()).padStart(2, "0");
		const formattedDate = `${day}-${month}-${year}`;

		const options = {
			margin: 5,
			filename: `Espermatograma__${lastName}_${firstName}_${formattedDate}.pdf`,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		pdfFileName.value = options.filename;

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

	const guardarCambios = async () => {
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
			aspectoMacro: "",
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
				inputValues.push("");
			}
		});

		Object.keys(data).forEach((key, index) => {
			data[key as keyof typeof data] = inputValues[index];
		});

		await store.createSpermiogramResults(data, profile.value.orders[0].idOrder);
	};

	async function sendEmail() {
		const profileId = profile.value.orders[0].idOrder;
		const emailData = {
			to: "francorm007@gmail.com",
			subject: "email test",
			text: "prueba desde la app del laboratorio",
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
		const message = `Echa un vistazo a este PDF`;
		const whatsappUrl = `https://web.whatsapp.com/send?phone=${profile.value.phone.substring(1)}&text=${encodeURIComponent(
			message
		)}`;
		window.open(whatsappUrl, "_blank");
	};

	const enviarCorreo = async () => {
		const profileId = profile.value.orders[0].idOrder;
		const data = {
			id: profileId,
			status: "Pendiente de imprimir",
		};
		await ordersStore.updateStatusOrder(profileId, data);
		const recipientEmail = "mario12dev@gmail.com";
		const subject = "Prueba";
		const body = "Este es un correo de prueba.";
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
	.firma-img {
		height: 65px;
		width: 180px;
	}

	.sello-img {
		height: 50px;
		width: 150px;
	}
</style>
