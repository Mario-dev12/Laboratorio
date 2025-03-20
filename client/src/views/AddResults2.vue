<template>
	<ion-page>
		<ion-content>
			<div class="container">
				<div class="perfiles mt-3 mb-3">
					<h4>Perfiles</h4>
					<div class="row w-100 m-auto gap-2">
						<div
							class="col btn btn-light"
							v-for="(profileName, index) in profileNames"
							:key="index"
							@click="handleSection(index)">
							{{ profileName }}
						</div>
					</div>
				</div>
				<div ref="profileRef" id="profile">
					<div class="patient-info">
						<div class="row">
							<div class="col">
								<img src="/images/laboratorio.png" alt="" />
							</div>
							<div class="col">
								<img src="/images/direccion.png" alt="" />
							</div>
						</div>
						<div class="border-bottom border-black mt-2"></div>
						<div class="row mt-3">
							<div class="col">
								<div class="d-inline fw-bold">Paciente:</div>
								{{ order?.firstName }} {{ order?.lastName }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">CI:</div>
								{{ order?.ci }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Edad:</div>
								{{ order?.age }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Sexo:</div>
								{{ order?.genre === "M" ? "Masculino" : "Femenino" }}
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Fecha:</div>
								{{ day }}/{{ month }}/{{ year }}
							</div>
						</div>
					</div>
					<div class="profile-content mt-5" v-for="(profile, indx) in profilesData" :key="indx">
						<div class="profile-sections mt-4" v-show="showProfile[indx]" ref="profileRef2">
							<div class="text-center">
								<h2>{{ profileNames[indx] }}</h2>
							</div>
							<div class="profile-tables mb-5" v-for="([key, section], i) in profile ? Object.entries(profile) : null" :key="i">
								<h3>{{ key }}</h3>
								<div class="table-responsive">
									<table class="table table-hover table-striped">
										<thead>
											<tr>
												<th scope="col" class="col-3">Nombre</th>
												<th scope="col" class="col-3">Resultados</th>
												<th scope="col" class="col-3">Unidad</th>
												<th scope="col" class="col-3">Valor Referencial</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="(item, index) in (section as Section).resultado" :key="index">
												<td ref="campoNames">{{ item.nombre }}</td>
												<td>
													<input type="text" ref="campoResult" @change="checkInputValue($event, index, section)" />
												</td>
												<td>{{ item.unidad }}</td>
												<td class="valor-referencial" ref="valorReferencial">{{ item.valor_referencial }}</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row mb-3">
					<button class="col btn btn-primary me-1" @click="guardarCambios">Guardar Cambios</button>
					<button class="col btn btn-primary me-1" @click="generatePDF">Crear PDF</button>
					<button class="col btn btn-primary me-1" @click="sendEmail">Enviar por Correo</button>
					<button class="col btn btn-primary me-1" @click="sharePDFViaWhatsApp">Compartir PDF por WhatsApp</button>
					<button class="col btn btn-primary me-1" @click="enviarCorreo">Compartir PDF por Mailto</button>
					<button class="col btn btn-primary me-1" @click="printPDF">Imprimir PDF</button>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonPage, IonContent } from "@ionic/vue";
	import { profileStore } from "@/stores/profileStore";
	import { ref, onMounted } from "vue";
	import html2pdf from "html2pdf.js";
	import { useRoute } from "vue-router";
	import { mailStore } from "@/stores/mailStore";
	import { examStore } from "@/stores/examStore";
	import { orderStore } from "@/stores/orderStore";
	import { useRouter } from "vue-router";

	interface Item {
		nombre: string;
		unidad: string;
		valor_referencial: string;
	}

	interface Section {
		resultado: Item[];
	}

	const router = useRouter();
	const examsStore = examStore();
	const ordersStore = orderStore();
	const profilesStore = profileStore();
	const route = useRoute();
	let profileNames: any = "";
	const profilesData = ref<any[]>([]);
	const sectionNames = ref<any[]>([]);
	const sectionData = ref();
	const tableInfo = ref();
	const showProfile = ref<boolean[]>([]);
	const campoNames = ref();
	const campoResult = ref();
	const profileRef = ref();
	const order = ref();
	const profileRef2 = ref();
	let html: string = "";
	const ordersArray = ref();
	const mailsStore = mailStore();
	const valorReferencial = ref();
	const pdfFileName = ref();
	const today = new Date();
	const day = today.getDate();
	const month = today.getMonth() + 1;
	const year = today.getFullYear();
	const profileName = ref();

	onMounted(async () => {
		order.value = route.query.profile;
		order.value = JSON.parse(order.value);
		ordersArray.value = order.value.orders;

		profileNames = route.query.profileNames;
		profileNames = JSON.parse(profileNames);
		for (const profile of profileNames) {
			const profileSection = await profilesStore.fetchProfileByInputsName(profile);
			profilesData.value.push(profileSection);
		}
		sectionData.value = profilesData.value[0];
		sectionNames.value = profilesData.value;
		showProfile.value = new Array(profileNames.length).fill(false);
		showProfile.value[0] = true;
	});

	router.beforeEach(async (to, from, next) => {
		profilesData.value = [];
		if (to.name === "Results2") {
			order.value = to.query.profile;
			order.value = JSON.parse(order.value);
			ordersArray.value = order.value.orders;

			profileNames = to.query.profileNames;
			profileNames = JSON.parse(profileNames);
			for (const profile of profileNames) {
				const profileSection = await profilesStore.fetchProfileByInputsName(profile);
				profilesData.value.push(profileSection);
			}
			sectionData.value = profilesData.value[0];
			sectionNames.value = profilesData.value;
			showProfile.value = new Array(profileNames.length).fill(false);
			showProfile.value[0] = true;
		}
		next();
	});

	const checkInputValue = (event: Event, index: number, section: any) => {
		const personAge = order.value.age;
		const personGenre = order.value.genre;
		const valorReferencialString = section.resultado[index].valor_referencial;
		const valorReferencialNumber = valorReferencialString.match(/(\d+(?:,\d+)?)/g);
		const parsedNumbers = valorReferencialNumber?.map((numStr: any) => parseFloat(numStr.replace(",", ".")));
		let inputValue = (event.target as HTMLInputElement).value;

		if (!isNaN(Number(inputValue.replace(",", ".")))) {
			inputValue = inputValue.replace(",", ".");
		}

		if (parsedNumbers) {
			if (parsedNumbers.length === 2) {
				if (Number(inputValue) < parsedNumbers[0] || Number(inputValue) > parsedNumbers[1]) {
					(event.target as HTMLInputElement).style.color = "red";
					(event.target as HTMLInputElement).style.borderColor = "red";
				} else {
					(event.target as HTMLInputElement).style.color = "green";
					(event.target as HTMLInputElement).style.borderColor = "lightgreen";
				}
			}

			if (parsedNumbers.length === 1) {
				if (valorReferencialString.includes("menor")) {
					if (Number(inputValue) < parsedNumbers[0]) {
						(event.target as HTMLInputElement).style.color = "green";
						(event.target as HTMLInputElement).style.borderColor = "lightgreen";
					} else {
						(event.target as HTMLInputElement).style.color = "red";
						(event.target as HTMLInputElement).style.borderColor = "red";
					}
				} else if (valorReferencialString.includes("Hasta")) {
					if (Number(inputValue) > parsedNumbers[0]) {
						(event.target as HTMLInputElement).style.color = "red";
						(event.target as HTMLInputElement).style.borderColor = "red";
					} else {
						(event.target as HTMLInputElement).style.color = "green";
						(event.target as HTMLInputElement).style.borderColor = "lightgreen";
					}
				}
			}

			if (parsedNumbers.length === 4) {
				if (valorReferencialString.includes("Hombre")) {
					if (personGenre === "M") {
						if (Number(inputValue) < parsedNumbers[0] || Number(inputValue) > parsedNumbers[1]) {
							(event.target as HTMLInputElement).style.color = "red";
							(event.target as HTMLInputElement).style.borderColor = "red";
						} else {
							(event.target as HTMLInputElement).style.color = "green";
							(event.target as HTMLInputElement).style.borderColor = "lightgreen";
						}
					} else if (personGenre === "F") {
						if (Number(inputValue) < parsedNumbers[2] || Number(inputValue) > parsedNumbers[3]) {
							(event.target as HTMLInputElement).style.color = "red";
							(event.target as HTMLInputElement).style.borderColor = "red";
						} else {
							(event.target as HTMLInputElement).style.color = "green";
							(event.target as HTMLInputElement).style.borderColor = "lightgreen";
						}
					}
				} else if (valorReferencialString.includes("Adulto")) {
					if (personAge > 17) {
						if (Number(inputValue) < parsedNumbers[0] || Number(inputValue) > parsedNumbers[1]) {
							(event.target as HTMLInputElement).style.color = "red";
							(event.target as HTMLInputElement).style.borderColor = "red";
						} else {
							(event.target as HTMLInputElement).style.color = "green";
							(event.target as HTMLInputElement).style.borderColor = "lightgreen";
						}
					} else {
						if (Number(inputValue) < parsedNumbers[2] || Number(inputValue) > parsedNumbers[3]) {
							(event.target as HTMLInputElement).style.color = "red";
							(event.target as HTMLInputElement).style.borderColor = "red";
						} else {
							(event.target as HTMLInputElement).style.color = "green";
							(event.target as HTMLInputElement).style.borderColor = "lightgreen";
						}
					}
				}
			}

			if (!inputValue) {
				(event.target as HTMLInputElement).style.color = "black";
				(event.target as HTMLInputElement).style.borderColor = "black";
			}
		}
	};

	function handleSection(index: number) {
		sectionData.value = profilesData.value[index];
		tableInfo.value = "";
		showProfile.value.forEach((element: boolean, i: number) => {
			if (i === index) {
				showProfile.value[i] = true;
			} else {
				showProfile.value[i] = false;
			}
		});
		sectionNames.value = Object.keys(sectionData.value);
	}

	const getHtmlWithInputValues = (element: any) => {
		const inputs = element.querySelectorAll("input, textarea");

		// Iterate over inputs to replace with their values
		inputs.forEach((input: any) => {
			const value = input.value; // Get current value of the input
			input.outerHTML = `<span>${value}</span>`; // Replace input with its value
		});

		// Return the updated HTML content
		return element.innerHTML;
	};

	const guardarCambios = () => {
		const testsResults: { [key: string]: any[] } = {};
		profileNames.forEach((name: string) => {
			testsResults[name] = [];
		});

		if (profileRef2.value) {
			// Loop por cada perfil
			profileRef2.value.forEach(async (item: any, index: number) => {
				let results: { orderId: number; profileName: string; fields: any[] };
				results = {
					orderId: 0,
					profileName: "",
					fields: [],
				};
				const profileFields: any[] = [];
				const testSections: { [key: string]: any[] } = {};
				const sections = item.querySelectorAll(".profile-tables");

				// Loop por cada seccion del perfil
				sections.forEach((table: any) => {
					const tableName = table.querySelector("h3");
					const tableData = table.querySelectorAll("tbody tr");
					testSections[tableName.innerHTML] = [];

					tableData.forEach((tr: any) => {
						const dataRow = {
							fieldName: "",
							inputValue: 0,
							Unit: "",
						};
						tr.children.forEach((td: any, i: number) => {
							if (i === 0) {
								dataRow.fieldName = td.innerHTML;
							}
							if (i === 1) {
								const inputElement = td.querySelector("input");
								dataRow.inputValue = inputElement.value;
							}
							if (i === 2) {
								dataRow.Unit = td.innerHTML;
							}
						});
						testSections[tableName.innerHTML].push(dataRow);
						profileFields.push(dataRow);
					});
				});
				Object.values(testsResults)[index].push(testSections);

				results = {
					orderId: ordersArray.value[index].idOrder,
					profileName: profileNames[index],
					fields: profileFields,
				};
				const data = {
					id: ordersArray.value[index].idOrder,
					status: "Pendiente de enviar",
				};
				// hacer llamado al store aqui
				await examsStore.createExamResults(results);
				await ordersStore.updateStatusOrder(ordersArray.value[index].idOrder, data);
			});
		}
	};

	const generatePDF = async () => {
		const profileRefCopy = profileRef.value.cloneNode(true);
		const patientInfoDivCopy = profileRefCopy.querySelector(".patient-info");

		const profileContentDivs = profileRefCopy.querySelectorAll(".profile-content");

		html = patientInfoDivCopy.innerHTML;

		profileContentDivs.forEach((item: any) => {
			const childrenCopy = item.children[0].cloneNode(true);
			childrenCopy.style.display = "block";

			html += getHtmlWithInputValues(childrenCopy);
		});
		const element = html;

		const firstName = order.value.firstName;
		const lastName = order.value.lastName;

		const today = new Date();
		const year = today.getFullYear();
		const month = String(today.getMonth() + 1).padStart(2, "0");
		const day = String(today.getDate()).padStart(2, "0");
		const formattedDate = `${day}-${month}-${year}`;

		const filename = `${lastName}_${firstName}_${formattedDate}.pdf`;
		profileName.value = `${lastName}_${firstName}_${formattedDate}.pdf`;

		const options = {
			margin: 6,
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		pdfFileName.value = options.filename;

		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Pendiente de enviar",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}

		html2pdf().from(element).set(options).save();
		html = "";
	};

	const generatePDF2 = async (): Promise<Blob> => {
		const profileRefCopy = profileRef.value.cloneNode(true);

		profileRefCopy.children.forEach((item: any) => {
			const childrenCopy = item.children[0].cloneNode(true);
			childrenCopy.style.display = "block";

			html += getHtmlWithInputValues(childrenCopy); // Asegúrate de tener esta función definida
		});

		const element = html;

		const firstName = order.value.firstName;
		const lastName = order.value.lastName;

		const today = new Date();
		const year = today.getFullYear();
		const month = String(today.getMonth() + 1).padStart(2, "0");
		const day = String(today.getDate()).padStart(2, "0");
		const formattedDate = `${day}-${month}-${year}`;

		const filename = `${lastName}_${firstName}_${formattedDate}.pdf`;
		profileName.value = filename;

		const options = {
			margin: 1,
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "in", format: "letter", orientation: "portrait" },
		};

		pdfFileName.value = options.filename;

		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Completado",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}

		// Usamos una Promise para esperar a que se genere el Blob
		return new Promise((resolve, reject) => {
			html2pdf()
				.from(element)
				.set(options)
				.toPdf()
				.get("pdf")
				.then((pdf: { output: (arg0: string) => any }) => {
					// Obtener directamente el Blob
					const blob = pdf.output("blob");
					resolve(blob);
				})
				.catch((error: any) => {
					console.error("Error generando el PDF:", error);
					reject(error);
				});
		});
	};

	const sharePDFViaWhatsApp = async () => {
		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Pendiente de imprimir",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}
		await generatePDF();
		const message = `Echa un vistazo a este PDF`;
		const whatsappUrl = `https://web.whatsapp.com/send?phone=${order.value.phone.substring(1)}&text=${encodeURIComponent(
			message
		)}`;
		window.open(whatsappUrl, "_blank");
	};

	const enviarCorreo = async () => {
		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Pendiente de imprimir",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}
		const recipientEmail = "mario12dev@gmail.com";
		const subject = "Prueba";
		const body = "Este es un correo de prueba.";
		const mailtoLink = `https://mail.google.com/mail/?view=cm&fs=1&to=${recipientEmail}&su=${encodeURIComponent(
			subject
		)}&body=${encodeURIComponent(body)}`;
		window.open(mailtoLink, "_blank");
	};

	// Nodemailer

	async function sendEmail() {
		const emailData = {
			to: "francorm007@gmail.com",
			subject: "email test",
			text: "prueba desde la app del laboratorio",
			attachment: pdfFileName.value,
		};

		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Pendiente de imprimir",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}

		mailsStore.sendEmail(emailData);
	}

	const printPDF = async () => {
		// Generar PDF
		const pdfBlob = await generatePDF2();

		// Crear un objeto URL para el Blob
		const pdfUrl = URL.createObjectURL(pdfBlob);

		// Abrir el PDF en una nueva ventana
		const printWindow = window.open(pdfUrl);

		if (printWindow) {
			// Imprimir el PDF cuando la ventana esté cargada
			printWindow.onload = function () {
				printWindow.print();
				printWindow.onafterprint = function () {
					// Cerrar la ventana después de imprimir
					printWindow.close();
				};
			};
		} else {
			console.error("No se pudo abrir la ventana de impresión.");
		}
	};

	// const sendMailNodeMailer = async () => {
	// 	const data = {
	// 		to: "mario12dev@gmail.com",
	// 		subject: "Asunto del correo",
	// 		text: "Este es el cuerpo del mensaje.",
	// 		html: "<p>Este es el cuerpo del mensaje.</p>", // Usar HTML real
	// 		attachment: null,
	// 	};

	// 	const data = {
	// 		to: "mario12dev@gmail.com",
	// 		from: "mario12dev@gmail.com",
	// 		subject: "Asunto del correo",
	// 		message: 'This is a test email sent from Next.js using Elastic Email.',
	// 	};
	// 	await mailsStore.sendEmail(data);
	// };
</script>

<style scoped></style>
