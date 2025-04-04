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
												<td ref="campoNames" class="align-middle">{{ item.nombre }}</td>
												<td class="align-middle">
													<input
														type="text"
														ref="campoResult"
														v-model="item.valor"
														@change="checkInputValue($event, index, section)" />
												</td>
												<td class="text-center align-middle">{{ item.unidad }}</td>
												<td class="valor-referencial align-middle" ref="valorReferencial">
													<span v-html="formatValorReferencial(item.valor_referencial)"></span>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
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
					<button class="col btn btn-primary me-1" @click="pdfWithoutSignature">Crear PDF</button>
					<button class="col btn btn-primary me-1" @click="sendEmail">Enviar por Correo</button>
					<button class="col btn btn-primary me-1" @click="sharePDFViaWhatsApp">Compartir PDF por WhatsApp</button>
					<button class="col btn btn-primary me-1" @click="enviarCorreo">Compartir PDF por Mailto</button>
					<button class="col btn btn-primary me-1" @click="printPDF">Imprimir PDF</button>
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
	import { profileStore } from "@/stores/profileStore";
	import { ref, onMounted } from "vue";
	import html2pdf from "html2pdf.js";
	import { useRoute } from "vue-router";
	import { mailStore } from "@/stores/mailStore";
	import { examStore } from "@/stores/examStore";
	import { orderStore } from "@/stores/orderStore";
	import { useRouter } from "vue-router";
	import { Parser } from "expr-eval";
	import { checkboxOutline } from "ionicons/icons";

	interface Item {
		nombre: string;
		unidad: string;
		valor_referencial: string;
		calculado: string;
		valor: any;
		restricciones: any;
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
	const isOpen = ref(false);
	const firmaSello = ref();

	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
	});

	const setOpen = (state: boolean) => {
		isOpen.value = state;
	};

	function formatValorReferencial(valor: string): string {
		return valor.replace(/;/g, ";<br/>");
	}

	const showToast = (message: string, style: string, icon: any) => {
		toast.value.message = message;
		toast.value.isOpen = true;
		toast.value.class = style;
		toast.value.icon = icon;
		setOpen(true);
	};

	onMounted(async () => {
		order.value = route.query.profile;
		order.value = JSON.parse(order.value);
		ordersArray.value = order.value.orders;

		profileNames = route.query.profileNames;
		profileNames = JSON.parse(profileNames);
		/*for (const profile of profileNames) {
			const profileSection = await profilesStore.fetchProfileByInputsName(profile);
			profilesData.value.push(profileSection);
			}*/
		const filteredSections: any[] = [];
		const seenKeys = new Set();
		for (const profile of ordersArray.value) {
			const profileSection2 = await profilesStore.fetchProfileByInputsName2(profile.profiles[0].profileName, profile.idOrder);
			const filteredSection: any = {};
			for (const [key, value] of Object.entries(profileSection2)) {
				if (!seenKeys.has(key)) {
					filteredSection[key] = value;
					seenKeys.add(key);
				}
			}

			filteredSections.push(filteredSection);
		}
		profilesData.value = filteredSections;

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

			const filteredSections: any[] = [];
			const seenKeys = new Set();
			for (const profile of ordersArray.value) {
				const profileSection2 = await profilesStore.fetchProfileByInputsName2(profile.profiles[0].profileName, profile.idOrder);
				const filteredSection: any = {};
				for (const [key, value] of Object.entries(profileSection2)) {
					if (!seenKeys.has(key)) {
						filteredSection[key] = value;
						seenKeys.add(key);
					}
				}

				filteredSections.push(filteredSection);
			}
			profilesData.value = filteredSections;

			sectionData.value = profilesData.value[0];
			sectionNames.value = profilesData.value;
			showProfile.value = new Array(profileNames.length).fill(false);
			showProfile.value[0] = true;
		}
		next();
	});

	const checkInputValue = async (event: Event, index: number, section: any) => {
		const inputElement = event.target as HTMLInputElement;
		const personAge = order.value.age;
		const personGenre = order.value.genre;
		const valorReferencialString = section.resultado[index].valor_referencial;
		const valorReferencialNumber = valorReferencialString.match(/(\d+(?:,\d+)?)/g);
		const parsedNumbers = valorReferencialNumber?.map((numStr: any) => parseFloat(numStr.replace(",", ".")));
		let inputValue = inputElement.value;

		if (!isNaN(Number(inputValue.replace(",", ".")))) {
			inputValue = inputValue.replace(",", ".");
		}

		if (parsedNumbers) {
			if (parsedNumbers.length === 2) {
				if (Number(inputValue) < parsedNumbers[0] || Number(inputValue) > parsedNumbers[1]) {
					inputElement.style.color = "red";
					inputElement.style.borderColor = "red";
				} else {
					inputElement.style.color = "green";
					inputElement.style.borderColor = "lightgreen";
				}
			}

			if (parsedNumbers.length === 1) {
				if (valorReferencialString.includes("menor")) {
					if (Number(inputValue) < parsedNumbers[0]) {
						inputElement.style.color = "green";
						inputElement.style.borderColor = "lightgreen";
					} else {
						inputElement.style.color = "red";
						inputElement.style.borderColor = "red";
					}
				} else if (valorReferencialString.includes("Hasta")) {
					if (Number(inputValue) > parsedNumbers[0]) {
						inputElement.style.color = "red";
						inputElement.style.borderColor = "red";
					} else {
						inputElement.style.color = "green";
						inputElement.style.borderColor = "lightgreen";
					}
				}
			}

			if (parsedNumbers.length === 4) {
				if (valorReferencialString.includes("Hombre")) {
					const validRange = personGenre === "M" ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
					if (Number(inputValue) < validRange[0] || Number(inputValue) > validRange[1]) {
						inputElement.style.color = "red";
						inputElement.style.borderColor = "red";
					} else {
						inputElement.style.color = "green";
						inputElement.style.borderColor = "lightgreen";
					}
				} else if (valorReferencialString.includes("Adulto")) {
					const validRange = personAge > 17 ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
					if (Number(inputValue) < validRange[0] || Number(inputValue) > validRange[1]) {
						inputElement.style.color = "red";
						inputElement.style.borderColor = "red";
					} else {
						inputElement.style.color = "green";
						inputElement.style.borderColor = "lightgreen";
					}
				}
			}

			if (parsedNumbers.length === 6) {
				let minRange = Infinity;
				let maxRange = -Infinity;

				try {
					const matches = valorReferencialString.match(/(-?\d+(\.\d+)?)\s*x10\^([-+]?\d+)|(-?\d+(\.\d+)?)/g);

					const exponentMatches = valorReferencialString.match(/x10\^([-+]?\d+)/g);

					let exponentFactor = 1;

					if (exponentMatches) {
						for (const exp of exponentMatches) {
							const exponent = parseInt(exp.replace("x10^", ""), 10);
							exponentFactor *= Math.pow(10, exponent);
						}
					}

					if (matches) {
						for (const match of matches) {
							const matchScience = /(-?\d+(\.\d+)?)\s*x10\^([-+]?\d+)/.exec(match);
							if (matchScience) {
								const base = parseFloat(matchScience[1]);
								const exponent = parseInt(matchScience[3], 10);
								const value = base * Math.pow(10, exponent);
								minRange = Math.min(minRange, value);
								maxRange = Math.max(maxRange, value);
							} else {
								const value = parseFloat(match) * exponentFactor;
								minRange = Math.min(minRange, value);
								maxRange = Math.max(maxRange, value);
							}
						}
					}

					if (!isNaN(Number(inputValue))) {
						if (Number(inputValue) < minRange || Number(inputValue) > maxRange) {
							inputElement.style.color = "red";
							inputElement.style.borderColor = "red";
						} else {
							inputElement.style.color = "green";
							inputElement.style.borderColor = "lightgreen";
						}
					} else {
						inputElement.style.color = "red";
						inputElement.style.borderColor = "red";
					}
				} catch (error) {
					console.error("Error al evaluar la fórmula:", error);
					inputElement.style.color = "red";
					inputElement.style.borderColor = "red";
				}
			}

			if (!inputValue) {
				inputElement.style.color = "black";
				inputElement.style.borderColor = "black";
			}

			section.resultado[index].valor = Number(inputValue);

			await calcularResultados(section);
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

		inputs.forEach((input: any) => {
			const value = input.value;
			input.outerHTML = `<span>${value}</span>`;
		});

		return element.innerHTML;
	};

	const guardarCambios = () => {
		const testsResults: { [key: string]: any[] } = {};
		profileNames.forEach((name: string) => {
			testsResults[name] = [];
		});

		if (profileRef2.value) {
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
				await examsStore.createExamResults(results);
				await ordersStore.updateStatusOrder(ordersArray.value[index].idOrder, data);
			});
			showToast("Cambios guradados exitosamnte!", "creado", checkboxOutline);
		}
	};

	const generatePDF = async () => {
		const profileRefCopy = profileRef.value.cloneNode(true);
		const patientInfoDivCopy = profileRefCopy.querySelector(".patient-info");
		const divFirmaSelloCopy = firmaSello.value.cloneNode(true);

		const profileContentDivs = profileRefCopy.querySelectorAll(".profile-content");

		html = patientInfoDivCopy.innerHTML;

		profileContentDivs.forEach((item: any) => {
			const childrenCopy = item.children[0].cloneNode(true);
			// childrenCopy.style.display = "block";

			html += getHtmlWithInputValues(childrenCopy);
		});
		html += divFirmaSelloCopy.innerHTML;
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
			margin: 14,
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

	// generar pdf sin firma y sello
	const pdfWithoutSignature = async () => {
		const profileRefCopy = profileRef.value.cloneNode(true);
		const patientInfoDivCopy = profileRefCopy.querySelector(".patient-info");
		const profileContentDivs = profileRefCopy.querySelectorAll(".profile-content");

		html = patientInfoDivCopy.innerHTML;

		profileContentDivs.forEach((item: any) => {
			const childrenCopy = item.children[0].cloneNode(true);

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
		const pdfBlob = await generatePDF2();

		const pdfUrl = URL.createObjectURL(pdfBlob);

		const printWindow = window.open(pdfUrl);

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

	const aplicarFormula = (formula: string, valores: { [x: string]: any }) => {
		const parser = new Parser();
		const evaluableFormula = formula.replace(/(\w+)/g, (match) => {
			if (valores.hasOwnProperty(match)) {
				return valores[match];
			}
			return match;
		});

		try {
			if (!evaluableFormula.includes("undefined")) {
				return parser.evaluate(evaluableFormula);
			}
		} catch (error) {
			console.error("Error al evaluar la fórmula:", error);
			return null;
		}
	};

	const aplicarRestriccion = (formula: string, valores: { [x: string]: any }) => {
		const parser = new Parser();
		const evaluableFormula = formula.replace(/(\w+)/g, (match) => {
			if (valores.hasOwnProperty(match)) {
				return valores[match];
			}
			return match;
		});

		try {
			const equalSignIndex = evaluableFormula.indexOf("=");
			if (equalSignIndex !== -1) {
				const izquierda = evaluableFormula.slice(0, equalSignIndex);
				const derecha = evaluableFormula.slice(equalSignIndex + 1).trim();

				const resultadoIzquierda = parser.evaluate(izquierda);
				const resultadoDerecha = parseFloat(derecha);

				if (resultadoIzquierda !== resultadoDerecha) {
					alert(`Error: la suma debe ser igual a ${resultadoDerecha}. Revise las entradas de los campos.`);
					return null;
				}

				return resultadoIzquierda;
			}
		} catch (error) {
			console.error("Error al evaluar la fórmula:", error);
			return null;
		}
	};

	const calcularResultados = async (seccion: { resultado: any[] }) => {
		const valores: Record<string, any> = {};

		seccion.resultado.forEach((item: { valor: any; nombre: string | number }) => {
			if (item.valor) {
				valores[item.nombre] = item.valor;
			}
		});

		seccion.resultado.forEach((item: { calculado: string; valor: any; restricciones: any }, index: number) => {
			if (item.calculado) {
				for (const restriccion of item.restricciones) {
					aplicarRestriccion(restriccion, valores);
				}
				item.valor = aplicarFormula(item.calculado, valores);

				if (item.valor) {
					const inputElement = campoResult.value[index];
					const inputValue = item.valor;
					const personAge = order.value.age;
					const personGenre = order.value.genre;
					const valorReferencialString = seccion.resultado[index].valor_referencial;
					const valorReferencialNumber = valorReferencialString.match(/(\d+(?:,\d+)?)/g);
					const parsedNumbers = valorReferencialNumber?.map((numStr: any) => parseFloat(numStr.replace(",", ".")));

					if (parsedNumbers) {
						if (parsedNumbers.length === 2) {
							if (Number(inputValue) < parsedNumbers[0] || Number(inputValue) > parsedNumbers[1]) {
								inputElement.style.color = "red";
								inputElement.style.borderColor = "red";
							} else {
								inputElement.style.color = "green";
								inputElement.style.borderColor = "lightgreen";
							}
						}

						if (parsedNumbers.length === 1) {
							if (valorReferencialString.includes("menor")) {
								if (Number(inputValue) < parsedNumbers[0]) {
									inputElement.style.color = "green";
									inputElement.style.borderColor = "lightgreen";
								} else {
									inputElement.style.color = "red";
									inputElement.style.borderColor = "red";
								}
							} else if (valorReferencialString.includes("Hasta")) {
								if (Number(inputValue) > parsedNumbers[0]) {
									inputElement.style.color = "red";
									inputElement.style.borderColor = "red";
								} else {
									inputElement.style.color = "green";
									inputElement.style.borderColor = "lightgreen";
								}
							}
						}

						if (parsedNumbers.length === 4) {
							if (valorReferencialString.includes("Hombre")) {
								const validRange =
									personGenre === "M" ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
								if (Number(inputValue) < validRange[0] || Number(inputValue) > validRange[1]) {
									inputElement.style.color = "red";
									inputElement.style.borderColor = "red";
								} else {
									inputElement.style.color = "green";
									inputElement.style.borderColor = "lightgreen";
								}
							} else if (valorReferencialString.includes("Adulto")) {
								const validRange = personAge > 17 ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
								if (Number(inputValue) < validRange[0] || Number(inputValue) > validRange[1]) {
									inputElement.style.color = "red";
									inputElement.style.borderColor = "red";
								} else {
									inputElement.style.color = "green";
									inputElement.style.borderColor = "lightgreen";
								}
							}
						}

						if (!inputValue) {
							inputElement.style.color = "black";
							inputElement.style.borderColor = "black";
						}
					}
				}
			}
		});
	};
</script>

<style scoped>
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

	.firma-img {
		height: 65px;
		width: 180px;
	}

	.sello-img {
		height: 50px;
		width: 150px;
	}
</style>
