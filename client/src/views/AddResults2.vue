<template>
	<ion-page>
		<ion-content>
			<div class="container">
				<div class="perfiles mt-3 mb-3">
					<h4>Perfiles</h4>
					<div class="row w-100 m-auto gap-2">
						<div
							class="col btn btn-light"
							v-for="(profileName, index) in profileNamesOrdered"
							:key="index"
							@click="handleSection(index)">
							{{ profileName }}
						</div>
					</div>
				</div>
				<div ref="profileRef" id="profile">
					<div class="patient-info">
						<div class="row">
							<div class="col-5 text-center">
								<img src="/images/12.png" alt="" style="height: 60px" />
							</div>
							<div class="col-4 text-center">
								<img src="/images/13.png" alt="" style="height: 60px" />
							</div>
						</div>
						<div class="border-bottom border-black"></div>
						<div class="mt-1 text-center d-flex">
							<div class="me-3">
								<div class="d-inline fw-bold size">Paciente:</div>
								<span class="size"> {{ order?.firstName }} {{ order?.lastName }} </span>
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold size">CI:</div>
								<span class="size"> {{ order?.ci }} </span>
							</div>
							<div v-if="order?.doctor" class="me-3">
								<div class="d-inline fw-bold size">Dr:</div>
								<span class="size"> {{ order?.doctor }} </span>
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold size">Edad:</div>
								<span class="size"> {{ order?.age }} </span>
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold size">Sexo:</div>
								<span class="size"> {{ order?.genre === "M" ? "Masculino" : "Femenino" }} </span>
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold size">Fecha:</div>
								<span class="size"> {{ day }}/{{ month }}/{{ year }} </span>
							</div>
						</div>
					</div>

					<div class="profile-content" v-for="(profile, indx) in profilesData" :key="indx" ref="profileRef2">
						<div class="profile-sections mt-1 size" v-show="showProfile[indx]">
							<div class="profile-tables">
								<div class="table-responsive">
									<table class="table table-hover table-striped m-0">
										<thead>
											<tr>
												<th scope="col" class="col-3 p-0">Nombre</th>
												<th scope="col" class="col-3 p-0">Resultados</th>
												<th scope="col" class="col-3 p-0">Unidad</th>
												<th scope="col" class="col-3 p-0">Valor Referencial</th>
											</tr>
										</thead>
										<tbody class="testTitle">
											<tr class="text-center">
												<td class="p-0" colspan="4">
													<h4 class="m-0 text-nowrap title-size">{{ profileNamesOrdered[indx] }}</h4>
												</td>
											</tr>
										</tbody>
										<tbody
											class="sectionData"
											v-for="([key, section], i) in profile ? Object.entries(profile) : null"
											:key="i"
											ref="sectionRef">
											<tr class="text-center">
												<td class="p-0" colspan="4">
													<h5 class="m-0 text-nowrap subtitle-size">{{ key }}</h5>
												</td>
											</tr>
											<tr class="rowData p-0" v-for="(item, index) in (section as Section).resultado" :key="index">
												<td ref="campoNames" class="align-middle p-0">{{ item.nombre }}</td>
												<td class="align-middle inputElement p-0">
													<input
														class="p-0"
														type="text"
														ref="campoResult"
														v-model="item.valor"
														@change="checkInputValue($event, index, section, i)" />
												</td>
												<td class="unidad align-middle p-0">{{ item.unidad }}</td>
												<td class="valor-referencial align-middle p-0" ref="valorReferencial">
													<span class="text-nowrap" v-html="item.valor_referencial"></span>
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
	import { profileStore } from "@/stores/profileStore";
	import { ref, onMounted } from "vue";
	import { useRoute } from "vue-router";
	import { mailStore } from "@/stores/mailStore";
	import { examStore } from "@/stores/examStore";
	import { orderStore } from "@/stores/orderStore";
	import { useRouter } from "vue-router";
	import { Parser } from "expr-eval";
	import { checkboxOutline, alertCircleOutline } from "ionicons/icons";

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

	interface AnyKeyObject {
		[key: string]: any;
	}

	const router = useRouter();
	const examsStore = examStore();
	const ordersStore = orderStore();
	const profilesStore = profileStore();
	const route = useRoute();
	let profileNames: any = "";
	const profilesData = ref<any[]>([]);
	const sectionData = ref();
	const tableInfo = ref();
	const showProfile = ref<boolean[]>([]);
	const campoNames = ref();
	const campoResult = ref();
	const profileRef = ref();
	const order = ref();
	const profileRef2 = ref();
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
	const sectionRef = ref();
	let profileNamesOrdered: string[] = [];
	const alertShown = ref(false);

	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
	});

	const setOpen = (state: boolean) => {
		isOpen.value = state;
	};

	// function formatValorReferencial(valor: string): string {
	// 	return valor.replace(/;/g, ";<br/>");
	// }

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
		console.log(ordersArray.value);
		profileNamesOrdered = [];
		profileNames = route.query.profileNames;
		profileNames = JSON.parse(profileNames);
		const primarySectionsStrings: string[] = [
			"Hematología completa",
			"Hematología Completa",
			"HEMATOLOGÍA COMPLETA",
			"vsg",
			"Velocidad de Sedimentación Globular (V.S.G)",
			"VELOCIDAD DE SEDIMENTACIÓN GLOBULAR (V.S.G)",
			"Química Sanguinea",
			"Química Sanguínea",
			"QUÍMICA SANGUÍNEA",
		];

		const profilePrimarySections: number[] = [];
		const orderedProfiles: any[] = [];

		for (const profile of ordersArray.value) {
			const profilesAndSections: { [key: string]: any } = {};
			let primarySectionsCounter: number = 0;
			const profileSection2 = await profilesStore.fetchProfileByInputsName2(profile.profiles[0].profileName, profile.idOrder);
			const sectionKeys = Object.keys(profileSection2);

			const filteredSection: AnyKeyObject = {
				"Hematología completa": "",
				"Hematología Completa": "",
				"HEMATOLOGÍA COMPLETA": "",
				vsg: "",
				"Velocidad de Sedimentación Globular (V.S.G)": "",
				"VELOCIDAD DE SEDIMENTACIÓN GLOBULAR (V.S.G)": "",
				"Química Sanguinea": "",
				"Química Sanguínea": "",
				"QUÍMICA SANGUÍNEA": "",
			};

			//ordenar secciones
			for (const [key, value] of Object.entries(profileSection2)) {
				filteredSection[key] = value;
			}

			for (const [key, value] of Object.entries(filteredSection)) {
				if (!value) {
					delete filteredSection[key];
				}
			}

			profilesAndSections[profile.profiles[0].profileName] = filteredSection;

			//chequear cuantas secciones primarias tiene el perfil actual
			sectionKeys.forEach((name) => {
				const isPrimary = primarySectionsStrings.some((item) => name === item);
				if (isPrimary) {
					primarySectionsCounter++;
				}
			});

			if (!orderedProfiles.length) {
				orderedProfiles.push(profilesAndSections);
			} else {
				const morePrimarySections = profilePrimarySections.every((num) => primarySectionsCounter > num);
				if (morePrimarySections) {
					orderedProfiles.unshift(profilesAndSections);
				} else {
					orderedProfiles.push(profilesAndSections);
				}
			}

			//guardar cuantas secciones primarias tiene cada perfil
			profilePrimarySections.push(primarySectionsCounter);
		}

		orderedProfiles.forEach((item) => {
			profileNamesOrdered.push(Object.keys(item)[0]);
		});

		const newSections: any[] = [];

		orderedProfiles.forEach((item) => {
			const values = Object.values(item);
			newSections.push(values[0]);
		});

		profilesData.value = newSections;

		sectionData.value = profilesData.value[0];
		showProfile.value = new Array(profileNames.length).fill(false);
		showProfile.value[0] = true;
	});

	router.beforeEach(async (to, from, next) => {
		profilesData.value = [];
		profileNamesOrdered = [];
		if (to.name === "Results2") {
			order.value = to.query.profile;
			order.value = JSON.parse(order.value);
			ordersArray.value = order.value.orders;

			profileNames = to.query.profileNames;
			profileNames = JSON.parse(profileNames);
			const primarySectionsStrings: string[] = [
				"Hematología completa",
				"Hematología Completa",
				"HEMATOLOGÍA COMPLETA",
				"vsg",
				"Velocidad de Sedimentación Globular (V.S.G)",
				"VELOCIDAD DE SEDIMENTACIÓN GLOBULAR (V.S.G)",
				"Química Sanguinea",
				"Química Sanguínea",
				"QUÍMICA SANGUÍNEA",
			];

			// filtrar y ordenar secciones
			const profilePrimarySections: number[] = [];
			const orderedProfiles: any[] = [];

			for (const profile of ordersArray.value) {
				const profilesAndSections: { [key: string]: any } = {};
				let primarySectionsCounter: number = 0;
				const profileSection2 = await profilesStore.fetchProfileByInputsName2(profile.profiles[0].profileName, profile.idOrder);
				const sectionKeys = Object.keys(profileSection2);

				const filteredSection: AnyKeyObject = {
					"Hematología completa": "",
					"Hematología Completa": "",
					"HEMATOLOGÍA COMPLETA": "",
					vsg: "",
					"Velocidad de Sedimentación Globular (V.S.G)": "",
					"VELOCIDAD DE SEDIMENTACIÓN GLOBULAR (V.S.G)": "",
					"Química Sanguinea": "",
					"Química Sanguínea": "",
					"QUÍMICA SANGUÍNEA": "",
				};

				//ordenar secciones
				for (const [key, value] of Object.entries(profileSection2)) {
					filteredSection[key] = value;
				}

				for (const [key, value] of Object.entries(filteredSection)) {
					if (!value) {
						delete filteredSection[key];
					}
				}

				profilesAndSections[profile.profiles[0].profileName] = filteredSection;

				//chequear cuantas secciones primarias tiene el perfil actual
				sectionKeys.forEach((name) => {
					const isPrimary = primarySectionsStrings.some((item) => name === item);
					if (isPrimary) {
						primarySectionsCounter++;
					}
				});

				if (!orderedProfiles.length) {
					orderedProfiles.push(profilesAndSections);
				} else {
					const morePrimarySections = profilePrimarySections.every((num) => primarySectionsCounter > num);
					if (morePrimarySections) {
						orderedProfiles.unshift(profilesAndSections);
					} else {
						orderedProfiles.push(profilesAndSections);
					}
				}

				//guardar cuantas secciones primarias tiene cada perfil
				profilePrimarySections.push(primarySectionsCounter);
			}

			orderedProfiles.forEach((item) => {
				profileNamesOrdered.push(Object.keys(item)[0]);
			});

			const newSections: any[] = [];

			orderedProfiles.forEach((item) => {
				const values = Object.values(item);
				newSections.push(values[0]);
			});

			profilesData.value = newSections;

			sectionData.value = profilesData.value[0];
			showProfile.value = new Array(profileNames.length).fill(false);
			showProfile.value[0] = true;
		}
		next();
	});

	const checkInputValue = async (event: Event, index: number, section: any, sectionIndex: number) => {
		const inputElement = event.target as HTMLInputElement;
		const inputValue = inputElement.value.replace(",", ".");

		const setInputColor = (isValid: boolean) => {
			inputElement.style.color = isValid ? "green" : "red";
			inputElement.style.borderColor = isValid ? "lightgreen" : "red";
		};

		const hasLetters = /[a-zA-Z]/.test(inputValue);
		const hasNumbers = /\d/.test(inputValue);

		if (hasLetters && hasNumbers) {
			setInputColor(true);
			section.resultado[index].valor = inputValue;
			return;
		}

		const personAge = order.value.age;
		const personGenre = order.value.genre;
		const numericInput = parseFloat(inputValue);

		const parseScientific = (str: string) => {
			const match = /(-?\d+(\.\d+)?)\s*x10\^([-+]?\d+)/.exec(str);
			if (match) {
				return parseFloat(match[1]) * Math.pow(10, parseInt(match[3], 10));
			}
			return parseFloat(str);
		};

		if (Number.isNaN(numericInput)) {
			setInputColor(true);
			section.resultado[index].valor = inputValue;
			return;
		}

		const valorReferencialString = section.resultado[index].valor_referencial;
		const parsedNumbers = (() => {
			const matches = valorReferencialString.match(/(\d+(?:,\d+)?)/g);
			return matches?.map((numStr: string) => parseFloat(numStr.replace(",", ".")));
		})();

		const validateRange = (min: number, max: number): boolean => {
			return numericInput >= min && numericInput <= max;
		};

		let isValid = true;

		if (parsedNumbers) {
			switch (parsedNumbers.length) {
				case 1: {
					if (valorReferencialString.toLowerCase().includes("menor")) {
						isValid = numericInput < parsedNumbers[0];
					} else if (valorReferencialString.toLowerCase().includes("hasta")) {
						isValid = numericInput <= parsedNumbers[0];
					}
					break;
				}

				case 2: {
					isValid = validateRange(parsedNumbers[0], parsedNumbers[1]);
					if (valorReferencialString.toLowerCase().includes("hasta")) {
						isValid = numericInput >= parsedNumbers[0] && numericInput <= parsedNumbers[1];
					}
					break;
				}

				case 4: {
					let range: [number, number];
					const hasScientificNotation = valorReferencialString.match(/(-?\d+(\.\d+)?\s*x10\^[-+]?\d+)/);
					if (hasScientificNotation) {
						let minRange = Infinity;
						let maxRange = -Infinity;

						const matches = valorReferencialString.match(/(-?\d+(\.\d+)?\s*x10\^[-+]?\d+)|(-?\d+(\.\d+)?)/g);

						matches?.forEach((matchStr: any) => {
							const val = parseScientific(matchStr);
							if (val !== undefined && !Number.isNaN(val)) {
								minRange = Math.min(minRange, val);
								maxRange = Math.max(maxRange, val);
							}
						});

						isValid = validateRange(minRange, maxRange);
					} else {
						if (valorReferencialString.toLowerCase().includes("hombre")) {
							range = personGenre === "M" ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
						} else if (valorReferencialString.toLowerCase().includes("adulto")) {
							range = personAge > 17 ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
						} else {
							range = [parsedNumbers[0], parsedNumbers[1]];
						}
						isValid = validateRange(range[0], range[1]);
					}
					break;
				}

				case 6: {
					let minRange = Infinity;
					let maxRange = -Infinity;

					const matches = valorReferencialString.match(/(-?\d+(\.\d+)?\s*x10\^[-+]?\d+)|(-?\d+(\.\d+)?)/g);

					matches?.forEach((matchStr: any) => {
						const val = parseScientific(matchStr);
						if (val !== undefined && !Number.isNaN(val)) {
							minRange = Math.min(minRange, val);
							maxRange = Math.max(maxRange, val);
						}
					});

					isValid = validateRange(minRange, maxRange);
					break;
				}

				default: {
					break;
				}
			}
		}

		setInputColor(isValid);

		if (isValid) {
			section.resultado[index].valor = numericInput;
		} else {
			section.resultado[index].valor = numericInput;
		}
		let campoCalculadoLlenado = await calcularResultados(section, sectionIndex);

		do {
			campoCalculadoLlenado = await calcularResultados(section, sectionIndex);
		} while (campoCalculadoLlenado);

		if (section.resultado.length > 1) {
			await calcularResultados(section, sectionIndex);
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
	}

	const guardarCambios = async () => {
		const testsResults: { [key: string]: any[] } = {};
		profileNames.forEach((name: string) => {
			testsResults[name] = [];
		});

		if (profileRef2.value) {
			//loop por cada perfil
			await Promise.all(
				profileRef2.value.map(async (item: any) => {
					const profileFields: any[] = [];
					const testSections: { [key: string]: any[] } = {};
					const sections = item.querySelectorAll(".sectionData");

					const profileTitleElement = item.querySelector(".profile-tables .testTitle .title-size");
					const currentProfileName = profileTitleElement ? profileTitleElement.innerText.trim() : "";

					sections.forEach((table: any) => {
						const tableNameElement = table.querySelector("h5.subtitle-size");
						const tableName = tableNameElement ? tableNameElement.innerText.trim() : "";
						testSections[tableName] = [];

						const tableData = table.querySelectorAll("tbody tr.rowData");

						tableData.forEach((tr: any) => {
							const dataRow = {
								fieldName: "",
								inputValue: "",
								Unit: "",
							};

							const tds = tr.children;

							dataRow.fieldName = tds[0]?.innerText.trim() || "";
							const inputElement = tds[1]?.querySelector("input");
							dataRow.inputValue = inputElement ? inputElement.value : "";
							dataRow.Unit = tds[2]?.innerText.trim() || "";

							if (dataRow.fieldName) {
								profileFields.push(dataRow);
								if (testSections[tableName]) {
									testSections[tableName].push(dataRow);
								}
							}
						});
					});
					if (currentProfileName) {
						const order = ordersArray.value.find((order: any) => {
							return profileNames[ordersArray.value.indexOf(order)].trim() === currentProfileName.trim();
						});
						if (order) {
							const results = {
								orderId: order.idOrder,
								profileName: currentProfileName,
								fields: profileFields,
							};

							const data = {
								id: order.idOrder,
								status: "Pendiente de enviar",
							};

							await examsStore.createExamResults(results);
							await ordersStore.updateStatusOrder(order.idOrder, data);
						} else {
							console.warn(`No se encontró un 'orderId' para el perfil: ${currentProfileName}`);
						}

						if (testsResults[currentProfileName]) {
							testsResults[currentProfileName].push(testSections);
						}
					} else {
						console.warn("No se pudo obtener el nombre del perfil para un elemento DOM.");
					}
				})
			);

			showToast("Cambios guardados exitosamente!", "creado", checkboxOutline);
		}
	};

	const generatePDF = async () => {
		// --- 1. PREPARACIÓN Y VALIDACIÓN DE ELEMENTOS ---
		if (!profileRef.value || !firmaSello.value) {
			console.error("Error: Las referencias a los elementos del perfil o firma/sello no están disponibles.");
			return;
		}

		const profileRefCopy = profileRef.value.cloneNode(true) as HTMLElement;
		const divFirmaSelloCopy = firmaSello.value.cloneNode(true) as HTMLElement;

		// Ejecuta tus funciones de manipulación del DOM sobre la copia
		await mergeTables(profileRefCopy);
		await inputToSpan(profileRefCopy);

		const patientInfoElement = profileRefCopy.querySelector(".patient-info") as HTMLElement | null;
		const mainProfileContentElement = profileRefCopy.querySelector(".profile-content") as HTMLElement | null;

		if (!patientInfoElement || !mainProfileContentElement) {
			let errorMsg = "Error: ";
			if (!patientInfoElement) errorMsg += "No se pudo encontrar la información del paciente. ";
			if (!mainProfileContentElement) errorMsg += "No se pudo encontrar el contenido principal del perfil (.profile-content).";
			console.error(errorMsg);
			return;
		}

		// --- OPCIONAL: Comprobación para el caso de thead aislado en el contenido principal ---
		const esDivConSoloThead =
			mainProfileContentElement.children.length === 1 &&
			mainProfileContentElement.firstElementChild?.tagName.toUpperCase() === "THEAD";
		const esTheadMismo = mainProfileContentElement.tagName.toUpperCase() === "THEAD";

		if (esDivConSoloThead || esTheadMismo) {
			console.warn(
				"El elemento '.profile-content' principal es o solo contiene un 'thead'. Esto podría ser problemático. Se continuará el procesamiento.",
				mainProfileContentElement
			);
		}

		// --- 2. LÓGICA DE PAGINACIÓN MANUAL CON CONSTRUCCIÓN DEL DOM ---
		const pdfContainer = document.createElement("div");
		pdfContainer.style.width = "210mm"; // Ancho A4
		pdfContainer.style.padding = "0mm 5mm"; // Padding para los márgenes laterales del contenido

		// Altura máxima de contenido por página (A4 es 297mm, Letter es 279.4mm).
		// Restamos un poco para asegurar que html2canvas tenga margen de maniobra
		// y para considerar posibles cabeceras/pies de página si se añaden.
		const alturaMaximaContenidoMM = 270; // Ajustado a 270mm para dejar espacio en Letter (279.4mm)

		let paginaActual = document.createElement("div");
		paginaActual.style.boxSizing = "border-box";
		// Se mantiene una altura mínima para la página, pero si causa problemas de espacio,
		// se podría considerar cambiar a 'auto' o un valor más flexible.
		paginaActual.style.minHeight = `${alturaMaximaContenidoMM * 0.95}mm`;
		pdfContainer.appendChild(paginaActual);

		// Añade la información del paciente a la primera página
		const patientInfoCloned = patientInfoElement.cloneNode(true) as HTMLElement;
		paginaActual.appendChild(patientInfoCloned);
		let alturaAcumulada = (patientInfoCloned.offsetHeight ?? 0) * 0.264583; // px a mm

		// Procesar el único mainProfileContentElement
		const contentDivCloned = mainProfileContentElement.cloneNode(true) as HTMLElement;

		// Aplicar estilos para evitar cortes dentro de las tablas en este contenido
		const tablaEnContent = contentDivCloned.querySelector("table");
		if (tablaEnContent) {
			const filasTabla = Array.from(tablaEnContent.querySelectorAll("tbody > tr")) as HTMLTableRowElement[];
			filasTabla.forEach((fila) => {
				fila.style.pageBreakInside = "avoid";
				fila.style.breakInside = "avoid";
			});
			const thead = tablaEnContent.querySelector("thead");
			if (thead) {
				if (thead.innerHTML.trim() !== "") {
					thead.style.pageBreakInside = "avoid";
					thead.style.breakInside = "avoid";
				} else {
					console.warn("Se encontró un thead vacío dentro de '.profile-content'.");
				}
			}
		}

		// Calcular la altura del bloque de contenido principal
		let contentBlockHeightMM = 0;
		const tempDiv = document.createElement("div");
		tempDiv.style.visibility = "hidden";
		tempDiv.style.position = "absolute";
		tempDiv.style.width = "200mm"; // Ancho similar al de la página para la medición
		tempDiv.appendChild(contentDivCloned.cloneNode(true));
		document.body.appendChild(tempDiv);
		contentBlockHeightMM = (tempDiv.offsetHeight ?? 0) * 0.264583; // px a mm
		document.body.removeChild(tempDiv);

		// Lógica de paginación para el bloque de contenido principal
		if (alturaAcumulada + contentBlockHeightMM > alturaMaximaContenidoMM && alturaAcumulada > 0) {
			console.log("Creando nueva página para el contenido principal.");
			paginaActual.style.pageBreakAfter = "always";

			paginaActual = document.createElement("div");
			paginaActual.style.boxSizing = "border-box";
			paginaActual.style.minHeight = `${alturaMaximaContenidoMM * 0.95}mm`;
			pdfContainer.appendChild(paginaActual);

			alturaAcumulada = 0;
		}

		paginaActual.appendChild(contentDivCloned);
		alturaAcumulada += contentBlockHeightMM;

		// --- Añadir la firma y el sello ---
		// Aplicar estilos para asegurar que la firma/sello se mantenga unida
		divFirmaSelloCopy.style.pageBreakInside = "avoid";
		divFirmaSelloCopy.style.breakInside = "avoid";
		divFirmaSelloCopy.style.display = "block"; // Asegurar que se renderice como un bloque

		// Medir la altura de la firma/sello DESPUÉS de aplicar los estilos y antes de añadir al DOM final.
		const tempFirmaDiv = document.createElement("div");
		tempFirmaDiv.style.visibility = "hidden";
		tempFirmaDiv.style.position = "absolute";
		tempFirmaDiv.style.width = "200mm"; // Ancho similar al de la página
		tempFirmaDiv.appendChild(divFirmaSelloCopy.cloneNode(true)); // Usar un clon para medir
		document.body.appendChild(tempFirmaDiv);
		document.body.removeChild(tempFirmaDiv);

		paginaActual.appendChild(divFirmaSelloCopy);
		// No es necesario sumar firmaSelloHeightMM a alturaAcumulada aquí si es el último elemento.

		// --- SOLUCIÓN PARA LA PÁGINA EN BLANCO ADICIONAL AL FINAL ---
		// Esto asegura que la última página no tenga un salto de página forzado.
		const lastPageDiv = pdfContainer.lastElementChild as HTMLElement;
		if (lastPageDiv) {
			lastPageDiv.style.pageBreakAfter = "auto";
		}

		// --- 3. GENERACIÓN Y GUARDADO DEL PDF ---
		const firstName = order.value.firstName;
		const lastName = order.value.lastName;
		const today = new Date();
		const formattedDate = `${String(today.getDate()).padStart(2, "0")}-${String(today.getMonth() + 1).padStart(
			2,
			"0"
		)}-${today.getFullYear()}`;
		const filename = `${lastName}_${firstName}_${formattedDate}.pdf`;

		profileName.value = filename;

		// **IMPORTANTE:** Si tu pdfContainer ya tiene padding, es mejor no usar márgenes en jsPDF
		// para evitar que se sumen o entren en conflicto con tu paginación manual.
		const options = {
			margin: [0, 0, 0, 0], // Establecer márgenes a 0 para evitar conflictos con el padding del contenedor
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: {
				scale: 2,
				useCORS: true,
				// logging: true, // Descomentar para ver logs de html2canvas
			},
			jsPDF: {
				unit: "mm",
				format: "letter", // O 'a4' si es el caso
				orientation: "portrait",
			},
		};

		pdfFileName.value = options.filename;

		if (ordersArray.value && typeof ordersStore.updateStatusOrder === "function") {
			for (const ord of ordersArray.value) {
				const data = {
					id: ord.idOrder,
					status: "Pendiente de enviar", // O el estado que corresponda
				};
				await ordersStore.updateStatusOrder(ord.idOrder, data);
			}
		} else {
			console.warn("ordersArray o ordersStore.updateStatusOrder no están disponibles para actualizar estado.");
		}

		try {
			const html2pdfModule = await import("html2pdf.js");
			const html2pdf = html2pdfModule.default;

			// console.log("Contenido final del DOM para PDF (con firma):", pdfContainer.outerHTML);
			html2pdf().from(pdfContainer).set(options).save();
		} catch (e) {
			console.error("Error al generar el PDF con firma:", e);
		}
	};

	const pdfCover = async () => {
		const profileRefCopy = profileRef.value.cloneNode(true);
		const patientInfoDivCopy = profileRefCopy.querySelector(".patient-info");

		if (patientInfoDivCopy) {
			const detailsContainer = patientInfoDivCopy.querySelector(".mt-1.text-center.d-flex");

			if (detailsContainer) {
				detailsContainer.style.display = "flex";
				detailsContainer.style.flexDirection = "column";
				detailsContainer.style.alignItems = "flex-start";

				detailsContainer.classList.remove("text-center");

				const detailItems = detailsContainer.children;
				for (let i = 0; i < detailItems.length; i++) {
					const item = detailItems[i];
					if (item instanceof HTMLElement) {
						item.style.marginRight = "0";
						item.style.marginBottom = "8px";
						item.style.textAlign = "left";
						item.classList.remove("me-3");
					}
				}
			} else {
				console.warn("Contenedor de detalles (.mt-1.text-center.d-flex) no encontrado en patientInfoDivCopy.");
			}
		} else {
			console.warn(".patient-info no encontrado en profileRefCopy.");
		}

		const html = patientInfoDivCopy.innerHTML;

		const options = {
			margin: 6,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		const html2pdf = (await import("html2pdf.js")).default;

		const pdfBlob = await html2pdf().from(html).set(options).output("blob");

		const pdfUrl = URL.createObjectURL(pdfBlob);
		const printWindow = window.open(pdfUrl);

		if (printWindow) {
			printWindow.onload = function () {
				printWindow.print();
				printWindow.onafterprint = function () {
					printWindow.close();
					URL.revokeObjectURL(pdfUrl);
				};
			};
		} else {
			console.error("No se pudo abrir la ventana de impresión.");
		}
	};

	async function mergeTables(element: HTMLElement) {
		const tables = Array.from(element.querySelectorAll("table"));
		const testTitlesDivs = Array.from(element.querySelectorAll(".testTitle")) as HTMLElement[];
		const profileSection = element.querySelector(".profile-sections") as HTMLElement;

		if (profileSection) {
			profileSection.style.display = "block";
		}

		const normalizeText = (text: string | null | undefined): string => {
			if (!text) return "";
			return text
				.toLowerCase()
				.normalize("NFD")
				.replace(/[\u0300-\u036f]/g, "")
				.trim();
		};

		tables.forEach((table) => {
			const filasDeDatos = table.querySelectorAll("tr.rowData");
			filasDeDatos.forEach((fila: Element) => {
				const celdaNombreCampo = fila.querySelector("td:first-child") as HTMLTableCellElement;
				if (celdaNombreCampo) {
					let textoActual = celdaNombreCampo.textContent || "";
					const textoOriginal = textoActual;
					const regexSufijos = /\s*(?:-\s*)?(?:canino|felino|orina)$/i;
					textoActual = textoActual.replace(regexSufijos, "").trim();
					if (textoActual !== textoOriginal) {
						celdaNombreCampo.textContent = textoActual;
					}
				}
			});
		});
		const VALOR_MULTIPLICACION_HEMATIES = 1000000;

		tables.forEach((table) => {
			const seccionesData = Array.from(table.querySelectorAll("tbody.sectionData"));

			seccionesData.forEach((tbody) => {
				const tituloSeccionElemento = tbody.querySelector("tr:first-child td h5");

				if (tituloSeccionElemento && tituloSeccionElemento.textContent) {
					const tituloSeccion = tituloSeccionElemento.textContent.trim().toLowerCase();

					if (tituloSeccion === "hematología completa" || tituloSeccion === "HEMATOLOGÍA COMPLETA") {
						const filasEnSeccion = Array.from(tbody.querySelectorAll("tr.rowData"));

						filasEnSeccion.forEach((fila) => {
							const celdaNombreCampo = fila.querySelector("td:first-child");
							const celdaInputElement = fila.querySelector("td.inputElement");

							if (celdaNombreCampo && celdaNombreCampo.textContent && celdaInputElement) {
								const nombreCampo = celdaNombreCampo.textContent.trim().toLowerCase();

								if (nombreCampo === "hematies") {
									const inputElement = celdaInputElement.querySelector("input") as HTMLInputElement | null;

									if (inputElement) {
										const valorActualStr = inputElement.value;
										const valorActualNum = parseFloat(valorActualStr);

										if (!isNaN(valorActualNum)) {
											const nuevoValor = valorActualNum * VALOR_MULTIPLICACION_HEMATIES;
											inputElement.value = nuevoValor.toLocaleString("es-ES");
										} else {
											console.warn(`El valor para HEMATIES ('${valorActualStr}') no es un número válido y no se multiplicará.`);
										}
									} else {
										console.warn("No se encontró un elemento <input> para HEMATIES en la celda esperada.");
									}
								}
							}
						});
					}
				}
			});
		});

		const MAIN_SECTION_NAMES_NORMALIZED = [
			normalizeText("Hematología completa"),
			normalizeText("Velocidad de Sedimentación Globular (V.S.G)"),
			normalizeText("Química Sanguínea"),
		];
		const primaryMainSectionTbodiesMap: Map<string, HTMLTableSectionElement> = new Map();
		const testTitlesToRemove = new Set<HTMLElement>();

		tables.forEach((table) => {
			const sectionsInTable = Array.from(table.querySelectorAll("tbody.sectionData")) as HTMLTableSectionElement[];
			sectionsInTable.forEach((tbody) => {
				const titleElement = tbody.querySelector("tr:first-child td h5");
				if (titleElement && titleElement.textContent) {
					const normalizedTitle = normalizeText(titleElement.textContent);
					if (MAIN_SECTION_NAMES_NORMALIZED.includes(normalizedTitle) && !primaryMainSectionTbodiesMap.has(normalizedTitle)) {
						primaryMainSectionTbodiesMap.set(normalizedTitle, tbody);
					}
				}
			});
		});

		tables.forEach((table, tableIndex) => {
			const sectionsInTable = Array.from(table.querySelectorAll("tbody.sectionData")) as HTMLTableSectionElement[];
			let associatedTestTitleShouldBeRemoved = false;

			sectionsInTable.forEach((currentTbody) => {
				const titleElement = currentTbody.querySelector("tr:first-child td h5");
				if (titleElement && titleElement.textContent) {
					const currentSectionTitleNormalized = normalizeText(titleElement.textContent);

					if (MAIN_SECTION_NAMES_NORMALIZED.includes(currentSectionTitleNormalized)) {
						const primaryTbodyForThisSection = primaryMainSectionTbodiesMap.get(currentSectionTitleNormalized);

						if (primaryTbodyForThisSection && primaryTbodyForThisSection !== currentTbody) {
							const dataRowsToMove = Array.from(currentTbody.querySelectorAll("tr.rowData"));
							dataRowsToMove.forEach((row) => primaryTbodyForThisSection.appendChild(row));

							titleElement.closest("tr")?.remove();

							associatedTestTitleShouldBeRemoved = true;

							if (currentTbody.querySelectorAll("tr").length === 0) {
								currentTbody.remove();
							}
						}
					}
				}
			});

			if (associatedTestTitleShouldBeRemoved && testTitlesDivs[tableIndex]) {
				testTitlesToRemove.add(testTitlesDivs[tableIndex]);
			}
		});

		tables.forEach((table, i) => {
			const tbodies = Array.from(table.querySelectorAll(".sectionData"));
			tbodies.forEach((tbody) => {
				const inputs = Array.from(tbody.querySelectorAll("input"));
				const sectionInputvalues = inputs.some((input) => (input as HTMLInputElement).value);

				if (!sectionInputvalues) {
					tbody.parentNode?.removeChild(tbody);
				}
			});

			const updatedTbodies = Array.from(table.querySelectorAll(".sectionData"));
			if (!updatedTbodies.length && testTitlesDivs[i]) {
				testTitlesDivs[i].parentNode?.removeChild(testTitlesDivs[i]);
			}
		});

		testTitlesDivs.forEach((div, i) => {
			const titleText = div.querySelector("h4");
			const associatedTable = tables[i];

			let shouldRemoveDiv = false;

			if (i === 0) {
				const seccionesData = Array.from(associatedTable.querySelectorAll("tbody.sectionData"));
				const mainSectionRegex =
					/h[eé]matolog[ií]a compl[eé]ta|velocidad de sedimentaci[oó]n globular \(v\.s\.g\)|qu[ií]mica sangu[ií]nea/i;

				for (const tbody of seccionesData) {
					const tituloSeccionElemento = tbody.querySelector("tr:first-child td h5");
					if (tituloSeccionElemento && tituloSeccionElemento.textContent) {
						const tituloSeccion = tituloSeccionElemento.textContent.trim();
						if (mainSectionRegex.test(tituloSeccion)) {
							shouldRemoveDiv = true;
							break;
						}
					}
				}
			}

			if (titleText && /perfil/i.test(titleText.innerHTML)) {
				shouldRemoveDiv = true;
			}

			if (!shouldRemoveDiv && associatedTable) {
				const seccionesData = Array.from(associatedTable.querySelectorAll("tbody.sectionData"));
				const mainSectionRegex =
					/h[eé]matolog[ií]a compl[eé]ta|velocidad de sedimentaci[oó]n globular \(v\.s\.g\)|qu[ií]mica sangu[ií]nea/i;

				for (const tbody of seccionesData) {
					const tituloSeccionElemento = tbody.querySelector("tr:first-child td h5");
					if (tituloSeccionElemento && tituloSeccionElemento.textContent) {
						const tituloSeccion = tituloSeccionElemento.textContent.trim();
						if (mainSectionRegex.test(tituloSeccion)) {
							shouldRemoveDiv = true;
							break;
						}
					}
				}
			}

			if (shouldRemoveDiv) {
				div.parentNode?.removeChild(div);
			}
		});

		if (tables.length > 0) {
			const firstTable = tables[0];
			for (let i = 1; i < tables.length; i++) {
				const currentTable = tables[i];
				const tbodiesToMove = currentTable.querySelectorAll("tbody");
				tbodiesToMove.forEach((tbody) => {
					firstTable.appendChild(tbody);
				});
			}
		}

		if (tables.length > 0) {
			const firstTable = tables[0];
			const allTbodies = Array.from(firstTable.querySelectorAll("tbody.sectionData")) as HTMLTableSectionElement[];
			const sortedTbodies: HTMLTableSectionElement[] = [];
			const processedTbodies = new Set<HTMLTableSectionElement>();

			MAIN_SECTION_NAMES_NORMALIZED.forEach((sectionName) => {
				const tbodyToPlace = allTbodies.find((tbody) => {
					const titleElement = tbody.querySelector("tr:first-child td h5");
					return titleElement && normalizeText(titleElement.textContent) === sectionName;
				});

				if (tbodyToPlace) {
					sortedTbodies.push(tbodyToPlace);
					processedTbodies.add(tbodyToPlace);
				}
			});

			const remainingTbodies = allTbodies.filter((tbody) => !processedTbodies.has(tbody));
			const finalOrderedTbodies = [...sortedTbodies, ...remainingTbodies];

			allTbodies.forEach((tbody) => tbody.remove());

			finalOrderedTbodies.forEach((tbody) => firstTable.appendChild(tbody));
		}
	}

	const inputToSpan = async (parentElement: HTMLElement) => {
		const rows = parentElement.querySelectorAll(".rowData");
		rows.forEach((row: Element) => {
			const input = row.querySelector("input");
			if (input?.value) {
				const span = document.createElement("span");
				span.textContent = input.value;
				input.parentNode?.replaceChild(span, input);
			} else {
				row.parentNode?.removeChild(row);
			}
		});
	};

	// generar pdf sin firma y sello
	/*const pdfWithoutSignature = async () => {
		// --- 1. PREPARACIÓN Y VALIDACIÓN DE ELEMENTOS ---
		if (!profileRef.value) {
			console.error("Error: La referencia al elemento del perfil no está disponible.");
			return;
		}

		const profileRefCopy = profileRef.value.cloneNode(true) as HTMLElement;

		await mergeTables(profileRefCopy);
		await inputToSpan(profileRefCopy);

		const patientInfoElement = profileRefCopy.querySelector(".patient-info");
		const tablaLargaElement = profileRefCopy.querySelector(".profile-content table") as HTMLTableElement | null;
		const encabezadoElement = tablaLargaElement?.querySelector("thead");

		if (!patientInfoElement || !tablaLargaElement || !encabezadoElement) {
			console.error(
				"Error: No se pudieron encontrar elementos HTML esenciales (info del paciente, tabla o encabezado) para generar el PDF."
			);
			return;
		}

		const filas: HTMLTableRowElement[] = Array.from(tablaLargaElement.querySelectorAll("tbody > tr"));
		const encabezadoClonado = encabezadoElement.cloneNode(true);

		// --- 2. LÓGICA DE PAGINACIÓN MANUAL ---

		const pdfContainer = document.createElement("div");
		pdfContainer.style.width = "210mm"; // Ancho de una página A4/Letter

		let paginaActual = document.createElement('div');
		paginaActual.style.boxSizing = 'border-box';
		paginaActual.style.minHeight = `${alturaMaximaPorPaginaMM}mm`;
		pdfContainer.appendChild(paginaActual);

		paginaActual.appendChild(patientInfoElement.cloneNode(true));

		// Función para crear la tabla CON encabezado (para la primera página)
		const crearNuevaTablaConEncabezado = (): HTMLTableElement => {
			const nuevaTabla = document.createElement("table");
			if (tablaLargaElement.className) {
				nuevaTabla.className = tablaLargaElement.className;
			}
			nuevaTabla.style.width = "100%";
			nuevaTabla.style.borderCollapse = "collapse";
			nuevaTabla.appendChild(encabezadoClonado.cloneNode(true));
			nuevaTabla.appendChild(document.createElement("tbody"));
			return nuevaTabla;
		};

		// --- FUNCIÓN AÑADIDA ---
		// Función para crear tablas SIN encabezado (para las páginas 2 en adelante)
		const crearTablaSinEncabezado = (): HTMLTableElement => {
			const nuevaTabla = document.createElement('table');
			if (tablaLargaElement.className) {
				nuevaTabla.className = tablaLargaElement.className;
			}
			nuevaTabla.style.width = '100%';
			nuevaTabla.style.borderCollapse = 'collapse';
			nuevaTabla.appendChild(document.createElement('tbody'));
			return nuevaTabla;
		};

		// Se crea la primera tabla CON encabezado
		let tablaActual = crearNuevaTablaConEncabezado();
		paginaActual.appendChild(tablaActual);

		// Se calcula la altura inicial incluyendo el encabezado
		let alturaAcumulada = (tablaActual.querySelector('thead')?.offsetHeight ?? 0) * 0.264583;

		for (const fila of filas) {
			const filaClonada = fila.cloneNode(true) as HTMLTableRowElement;
			filaClonada.style.pageBreakInside = "avoid";
			filaClonada.style.breakInside = "avoid";

			// const alturaFilaMM = fila.offsetHeight * 0.264583;

			// Si la fila actual no cabe, creamos una nueva página
			if (alturaAcumulada + alturaFilaMM > alturaMaximaPorPaginaMM) {
				paginaActual.style.pageBreakAfter = 'always';

				paginaActual = document.createElement('div');
				paginaActual.style.boxSizing = 'border-box';
				paginaActual.style.minHeight = `${alturaMaximaPorPaginaMM}mm`;
				pdfContainer.appendChild(paginaActual);

				// --- CAMBIO PRINCIPAL AQUÍ ---
				// Se crea la nueva tabla SIN encabezado para la nueva página
				tablaActual = crearTablaSinEncabezado();
				paginaActual.appendChild(tablaActual);

				// La altura acumulada se resetea a 0 porque no hay nuevo encabezado
				alturaAcumulada = 0;
			}

			const tbodyActual = tablaActual.querySelector('tbody');
			if (tbodyActual) {
				tbodyActual.appendChild(filaClonada);
				// alturaAcumulada += alturaFilaMM;
			}
		}

		// Solución para la página en blanco adicional
		const lastPageDiv = pdfContainer.lastElementChild as HTMLElement;
		if (lastPageDiv) {
			lastPageDiv.style.pageBreakAfter = 'auto';
		}

		// --- 3. GENERACIÓN Y GUARDADO DEL PDF ---

		const firstName = order.value.firstName;
		const lastName = order.value.lastName;
		const today = new Date();
		const formattedDate = `${String(today.getDate()).padStart(2, "0")}-${String(today.getMonth() + 1).padStart(
			2,
			"0"
		)}-${today.getFullYear()}`;
		const filename = `${lastName}_${firstName}_${formattedDate}.pdf`;

		profileName.value = filename;

		const options = {
			margin: [2, 5],
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: {
				scale: 2,
				useCORS: true,
			},
			jsPDF: {
				unit: "mm",
				format: "letter",
				orientation: "portrait",
			},
		};

		pdfFileName.value = options.filename;

		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Pendiente de enviar",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}

		const html2pdf = (await import("html2pdf.js")).default;

		html2pdf().from(pdfContainer).set(options).save();
	};*/

	const pdfWithoutSignature = async () => {
		// --- 1. PREPARACIÓN Y VALIDACIÓN DE ELEMENTOS ---
		if (!profileRef.value || !firmaSello.value) {
			// Asumo que firmaSello.value es relevante
			console.error("Error: Las referencias a los elementos del perfil o firma/sello no están disponibles.");
			return;
		}

		const profileRefCopy = profileRef.value.cloneNode(true) as HTMLElement;

		// Ejecuta tus funciones de manipulación del DOM sobre la copia
		await mergeTables(profileRefCopy); // Asegúrate de que esto opere correctamente sobre la estructura esperada
		await inputToSpan(profileRefCopy); // Asegúrate de que esto opere correctamente

		const patientInfoElement = profileRefCopy.querySelector(".patient-info") as HTMLElement | null;
		// MODIFICADO: Usar querySelector para un único elemento .profile-content
		const mainProfileContentElement = profileRefCopy.querySelector(".profile-content") as HTMLElement | null;

		// MODIFICADO: Ajustar la condición de validación
		if (!patientInfoElement || !mainProfileContentElement) {
			let errorMsg = "Error: ";
			if (!patientInfoElement) errorMsg += "No se pudo encontrar la información del paciente. ";
			if (!mainProfileContentElement) errorMsg += "No se pudo encontrar el contenido principal del perfil (.profile-content).";
			console.error(errorMsg);
			return;
		}

		// --- OPCIONAL: Comprobación para el caso de thead aislado ---
		// Si el único .profile-content es o solo contiene un thead, podría ser un problema.
		const esDivConSoloThead =
			mainProfileContentElement.children.length === 1 &&
			mainProfileContentElement.firstElementChild?.tagName.toUpperCase() === "THEAD";
		const esTheadMismo = mainProfileContentElement.tagName.toUpperCase() === "THEAD";

		if (esDivConSoloThead || esTheadMismo) {
			console.warn(
				"El elemento '.profile-content' principal es o solo contiene un 'thead'. Esto podría ser la fuente del problema si el thead aparece aislado. Se procederá, pero revisa el origen de este '.profile-content'.",
				mainProfileContentElement
			);
			// Dependiendo de tu lógica, podrías querer retornar aquí o manejarlo de forma especial.
			// Por ahora, se continuará el procesamiento.
		}

		// --- 2. LÓGICA DE PAGINACIÓN MANUAL CON CONSTRUCCIÓN DEL DOM ---
		const pdfContainer = document.createElement("div");
		pdfContainer.style.width = "210mm"; // Ancho A4
		pdfContainer.style.padding = "0mm 5mm"; // Márgenes laterales

		const alturaMaximaContenidoMM = 270; // Altura máxima del contenido por página en mm

		let paginaActual = document.createElement("div");
		paginaActual.style.boxSizing = "border-box";
		paginaActual.style.minHeight = `${alturaMaximaContenidoMM * 0.95}mm`; // Flexibilidad
		pdfContainer.appendChild(paginaActual);

		// Añade la información del paciente a la primera página
		const patientInfoCloned = patientInfoElement.cloneNode(true) as HTMLElement;
		paginaActual.appendChild(patientInfoCloned);
		let alturaAcumulada = (patientInfoCloned.offsetHeight ?? 0) * 0.264583; // px a mm

		// MODIFICADO: Procesar el único mainProfileContentElement
		const contentDivCloned = mainProfileContentElement.cloneNode(true) as HTMLElement;

		// Aplicar estilos para evitar cortes dentro de las tablas en este contenido
		const tablaEnContent = contentDivCloned.querySelector("table");
		if (tablaEnContent) {
			const filasTabla = Array.from(tablaEnContent.querySelectorAll("tbody > tr")) as HTMLTableRowElement[];
			filasTabla.forEach((fila) => {
				fila.style.pageBreakInside = "avoid";
				fila.style.breakInside = "avoid";
			});
			const thead = tablaEnContent.querySelector("thead");
			if (thead) {
				// Solo aplicar 'avoid' si el thead tiene contenido real
				if (thead.innerHTML.trim() !== "") {
					thead.style.pageBreakInside = "avoid";
					thead.style.breakInside = "avoid";
				} else {
					console.warn("Se encontró un thead vacío dentro de '.profile-content'.");
				}
			}
		}

		// Calcular la altura del bloque de contenido principal
		// Es crucial que esta medición sea lo más precisa posible.
		let contentBlockHeightMM = 0;
		const tempDiv = document.createElement("div");
		tempDiv.style.visibility = "hidden";
		tempDiv.style.position = "absolute";
		tempDiv.style.width = "200mm"; // Ancho de página menos márgenes
		tempDiv.appendChild(contentDivCloned.cloneNode(true)); // Usar otro clon para medir
		document.body.appendChild(tempDiv);
		contentBlockHeightMM = (tempDiv.offsetHeight ?? 0) * 0.264583; // px a mm
		document.body.removeChild(tempDiv);

		// Lógica de paginación para el bloque de contenido principal
		// Si el contenido (info paciente + bloque principal) excede la altura máxima Y la página ya tiene la info del paciente
		if (alturaAcumulada + contentBlockHeightMM > alturaMaximaContenidoMM && alturaAcumulada > 0) {
			paginaActual.style.pageBreakAfter = "always";

			paginaActual = document.createElement("div");
			paginaActual.style.boxSizing = "border-box";
			paginaActual.style.minHeight = `${alturaMaximaContenidoMM * 0.95}mm`;
			pdfContainer.appendChild(paginaActual);

			alturaAcumulada = 0; // Reiniciar altura para la nueva página (que solo contendrá este bloque o parte de él)
		}

		// Añade el bloque de contenido principal a la página actual (o nueva)
		paginaActual.appendChild(contentDivCloned);
		alturaAcumulada += contentBlockHeightMM;
		// NOTA: Si contentBlockHeightMM por sí solo es > alturaMaximaContenidoMM,
		// html2pdf.js tendrá que manejar la división interna de este bloque.
		// Los estilos pageBreakInside: 'avoid' en las filas de la tabla ayudarán a guiar esa división.

		// --- Lógica para la firma (si aplica y está fuera de .profile-content) ---
		// Esta parte del código original no estaba completamente detallada, pero si tienes un elemento firmaSello
		// y necesitas añadirlo, aquí iría una lógica similar a la de arriba.
		// Por ejemplo:
		// const firmaSelloElement = firmaSello.value.cloneNode(true) as HTMLElement;
		// const firmaHeightMM = (firmaSelloElement.offsetHeight ?? 0) * 0.264583;
		// if (alturaAcumulada + firmaHeightMM > alturaMaximaContenidoMM && alturaAcumulada > 0) {
		//     paginaActual.style.pageBreakAfter = 'always';
		//     paginaActual = document.createElement('div');
		//     // ... (configurar nueva página)
		//     pdfContainer.appendChild(paginaActual);
		//     alturaAcumulada = 0;
		// }
		// paginaActual.appendChild(firmaSelloElement);
		// alturaAcumulada += firmaHeightMM;

		// --- SOLUCIÓN PARA LA PÁGINA EN BLANCO ADICIONAL AL FINAL ---
		const lastPageDiv = pdfContainer.lastElementChild as HTMLElement;
		if (lastPageDiv) {
			lastPageDiv.style.pageBreakAfter = "auto";
		}

		// --- 3. GENERACIÓN Y GUARDADO DEL PDF ---
		const firstName = order.value.firstName; // Asegúrate que 'order' está definido
		const lastName = order.value.lastName;
		const today = new Date();
		const formattedDate = `${String(today.getDate()).padStart(2, "0")}-${String(today.getMonth() + 1).padStart(
			2,
			"0"
		)}-${today.getFullYear()}`;
		const filename = `${lastName}_${firstName}_${formattedDate}.pdf`;

		profileName.value = filename; // Asumo ref de Vue

		const verticalMargin = (279.4 - alturaMaximaContenidoMM) / 2; // Para centrar en Letter

		const options = {
			margin: [verticalMargin, 5, verticalMargin, 5], // [arriba, derecha, abajo, izquierda] en mm
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: {
				scale: 2,
				useCORS: true,
				// logging: true, // Descomentar para depurar html2canvas
			},
			jsPDF: {
				unit: "mm",
				format: "letter",
				orientation: "portrait",
			},
			// Considerar opciones de pagebreak de html2pdf.js si aún hay problemas
			// pagebreak: { mode: ['css', 'legacy'], avoid: ['thead', 'tr'] }
		};

		pdfFileName.value = options.filename; // Asumo ref de Vue

		if (ordersArray.value && typeof ordersStore.updateStatusOrder === "function") {
			for (const ord of ordersArray.value) {
				const data = {
					id: ord.idOrder,
					status: "Pendiente de enviar",
				};
				await ordersStore.updateStatusOrder(ord.idOrder, data);
			}
		} else {
			console.warn("ordersArray o ordersStore.updateStatusOrder no están disponibles para actualizar estado.");
		}

		try {
			const html2pdfModule = await import("html2pdf.js");
			const html2pdf = html2pdfModule.default;

			// console.log("Contenido final del DOM para PDF:", pdfContainer.outerHTML); // Descomenta para depuración
			html2pdf().from(pdfContainer).set(options).save();
		} catch (e) {
			console.error("Error al generar el PDF:", e);
		}
	};

	const generatePDF2 = async (): Promise<Blob> => {
		// --- 1. PREPARACIÓN Y VALIDACIÓN DE ELEMENTOS ---
		if (!profileRef.value) {
			console.error("Error: La referencia al elemento del perfil no está disponible.");
			return Promise.reject(new Error("La referencia al elemento del perfil no está disponible."));
		}

		const profileRefCopy = profileRef.value.cloneNode(true) as HTMLElement;

		// Ejecuta tus funciones de manipulación sobre el clon si son relevantes aquí
		await mergeTables(profileRefCopy);
		await inputToSpan(profileRefCopy);

		const patientInfoElement = profileRefCopy.querySelector(".patient-info") as HTMLElement | null;
		// Modificación aquí: Seleccionar solo el primer elemento con la clase .profile-content
		const mainProfileContentElement = profileRefCopy.querySelector(".profile-content") as HTMLElement | null;

		if (!patientInfoElement) {
			console.error("Error: No se pudo encontrar el elemento HTML de información del paciente.");
			return Promise.reject(new Error("No se pudo encontrar el elemento HTML de información del paciente."));
		}

		// --- 2. LÓGICA DE PAGINACIÓN MANUAL EN EL DOM TEMPORAL ---

		const pdfContainer = document.createElement("div");
		pdfContainer.style.width = "205mm"; // Ancho de una página A4/Letter
		pdfContainer.style.padding = "0mm 0mm"; // Márgenes laterales para el contenido

		const alturaMaximaContenidoMM = 280; // Altura máxima deseada del contenido por página

		let paginaActual: HTMLElement | null = null; // Empezamos sin página actual
		let currentContentHeightMM = 0; // Para llevar un seguimiento de la altura del contenido en la página actual

		// Función auxiliar para crear una nueva página
		const createNewPage = (addBreakAfter = false): HTMLElement => {
			const newPage = document.createElement("div");
			if (addBreakAfter) {
				newPage.style.pageBreakAfter = "always";
			}
			newPage.style.boxSizing = "border-box";
			newPage.style.minHeight = `${alturaMaximaContenidoMM}mm`; // Ayuda a la renderización
			pdfContainer.appendChild(newPage);
			currentContentHeightMM = 0; // Reiniciar la altura del contenido para la nueva página
			return newPage;
		};

		// Añade la información del paciente a la primera página
		paginaActual = createNewPage(); // Crea la primera página
		const patientInfoHeightMM = (patientInfoElement.offsetHeight ?? 0) * 0.264583;
		paginaActual.appendChild(patientInfoElement.cloneNode(true));
		currentContentHeightMM += patientInfoHeightMM;

		// Modificación aquí: Procesar solo el mainProfileContentElement si existe
		if (mainProfileContentElement) {
			const contentDivCloned = mainProfileContentElement.cloneNode(true) as HTMLElement;

			// Asegurarse de que las filas de la tabla no se corten
			const tablaEnContent = contentDivCloned.querySelector("table");
			if (tablaEnContent) {
				const filasTabla = Array.from(tablaEnContent.querySelectorAll("tbody > tr")) as HTMLTableRowElement[];
				filasTabla.forEach((fila) => {
					fila.style.pageBreakInside = "avoid";
					fila.style.breakInside = "avoid";
				});
			}

			// Medir la altura aproximada del bloque de contenido.
			// Esto es una estimación, html2canvas hace el cálculo final.
			// Si el elemento es display: none o tiene 0px de altura, offsetHeight será 0.
			const contentBlockHeightMM = (contentDivCloned.offsetHeight ?? 0) * 0.264583;

			// Si el bloque actual no cabe en la página actual, crea una nueva página
			// Solo crea una nueva página si ya hay contenido en la página actual
			// O si el bloque es muy grande y no cabe ni en una página vacía.
			if (paginaActual && currentContentHeightMM + contentBlockHeightMM > alturaMaximaContenidoMM) {
				paginaActual.style.pageBreakAfter = "always"; // Marca la página actual para un salto
				paginaActual = createNewPage(); // Crea una nueva página
			}

			// Añade el bloque de contenido a la página actual
			if (paginaActual) {
				paginaActual.appendChild(contentDivCloned);
				currentContentHeightMM += contentBlockHeightMM;
			}
		}

		// *** ¡SOLUCIÓN FINAL PARA LAS PÁGINAS EN BLANCO! ***
		// 1. Elimina cualquier page-break-after del ÚLTIMO elemento de página en el contenedor.
		const lastPageInContainer = pdfContainer.lastElementChild as HTMLElement;
		if (lastPageInContainer) {
			lastPageInContainer.style.pageBreakAfter = "auto"; // O .removeProperty('page-break-after')
		}

		// 2. Opcional: Elimina páginas completamente vacías que podrían haberse creado.
		// Esto es un paso de limpieza adicional si la lógica anterior no fue perfecta.
		// Itera hacia atrás y elimina si solo contiene texto invisible o tiene 0 altura renderizada.
		// Esto es más complejo y a veces no es necesario si la lógica de adición es sólida.
		// Por ahora, nos quedamos con la eliminación del último pageBreakAfter.

		// --- 3. GENERACIÓN Y GUARDADO DEL PDF ---

		const firstName = order.value.firstName;
		const lastName = order.value.lastName;

		const today = new Date();
		const formattedDate = `${String(today.getDate()).padStart(2, "0")}-${String(today.getMonth() + 1).padStart(
			2,
			"0"
		)}-${today.getFullYear()}`;

		const filename = `${lastName}_${firstName}_${formattedDate}.pdf`;
		profileName.value = filename;

		const options = {
			// Márgenes [arriba, derecha, abajo, izquierda] en mm
			// Calcula el margen para que el contenido total sea de 240mm de alto
			margin: [(279.4 - alturaMaximaContenidoMM) / 2, 5, (279.4 - alturaMaximaContenidoMM) / 2, 5],
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: {
				scale: 2,
				useCORS: true,
			},
			jsPDF: {
				unit: "mm",
				format: "letter",
				orientation: "portrait",
			},
		};

		pdfFileName.value = options.filename;

		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Pendiente de enviar",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}

		const html2pdf = (await import("html2pdf.js")).default;

		return new Promise((resolve, reject) => {
			html2pdf()
				.from(pdfContainer)
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
		const message = `Adjuntos resultados del laboratorio`;
		if (!order.value.phone || order.value.phone === "" || order.value.phone === undefined || order.value.phone === null) {
			const whatsappUrl = `https://web.whatsapp.com/send`;
			window.open(whatsappUrl, "_blank");
		} else {
			const whatsappUrl = `https://web.whatsapp.com/send?phone=${order.value.phone.substring(1)}&text=${encodeURIComponent(
				message
			)}`;
			window.open(whatsappUrl, "_blank");
		}
	};

	const enviarCorreo = async () => {
		for (const orders of ordersArray.value) {
			const data = {
				id: orders.idOrder,
				status: "Pendiente de imprimir",
			};
			await ordersStore.updateStatusOrder(orders.idOrder, data);
		}
		const recipientEmail = "labmadreemilia@gmail.com";
		const subject = "Resultados Exámenes";
		const body = "Adjunto los resultados de los exámenes. Por favor confirmar la llegada de este correo. Gracias de antemano";
		const mailtoLink = `https://mail.google.com/mail/?view=cm&fs=1&to=${recipientEmail}&su=${encodeURIComponent(
			subject
		)}&body=${encodeURIComponent(body)}`;
		window.open(mailtoLink, "_blank");
	};

	async function sendEmail() {
		const emailData = {
			to: order.value.email,
			subject: "Resultados Exámenes",
			text: "Adjunto los resultados de los exámenes. Por favor confirmar la llegada de este correo. Gracias de antemano",
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

		let formulaNormalizada = formula;
		//valore normalizados es una copia de valores
		const valoresNormalizados: { [key: string]: any } = { ...valores };

		//mapeoNombresComplejos es un objeto donde el key es el nombre original y el valor es el nombre modificado
		const mapeoNombresComplejos: { [nombreOriginal: string]: string } = {};

		const invalidVarCharRegex = /[^\w]/g;

		for (const key in valores) {
			//modifica el nombre del campo,
			if (Object.prototype.hasOwnProperty.call(valores, key) && invalidVarCharRegex.test(key)) {
				const nombreNormalizado = key.replace(invalidVarCharRegex, "_");
				mapeoNombresComplejos[key] = nombreNormalizado;

				valoresNormalizados[nombreNormalizado] = valoresNormalizados[key];
				delete valoresNormalizados[key];
			}
		}

		for (const nombreOriginal in mapeoNombresComplejos) {
			//cambia los nombres en la formula/calculado por los nombres modificados en el for anterior (nombreNormalizado)
			if (Object.prototype.hasOwnProperty.call(mapeoNombresComplejos, nombreOriginal)) {
				const nombreNormalizado = mapeoNombresComplejos[nombreOriginal];

				const escapedNombreOriginal = nombreOriginal.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
				const regex = new RegExp(`\\b${escapedNombreOriginal}\\b`, "g");

				formulaNormalizada = formulaNormalizada.replace(regex, nombreNormalizado);
			}
		}

		try {
			const expr = parser.parse(formulaNormalizada);

			const resultado = expr.evaluate(valoresNormalizados);
			if (typeof resultado === "number") {
				const resultadoFormateado = Math.round(resultado * 100) / 100;
				return resultadoFormateado;
			}
			return resultado;
		} catch (error: any) {
			const missingVarMatch = error.message.match(/undefined variable: (\w+)/);
			const missingVar = missingVarMatch ? missingVarMatch[1] : "desconocida";
			console.warn(`Advertencia: La fórmula "${formula}" contiene variables no definidas en 'valores': ${missingVar}.`);
		}
	};

	const aplicarRestriccion = (formula: string, valores: { [x: string]: any }) => {
		const parser = new Parser();
		const evaluableFormula = formula.replace(/(\w+)/g, (match) => {
			if (Object.prototype.hasOwnProperty.call(valores, match) && valores[match] !== undefined) {
				return valores[match];
			}
			return match;
		});

		try {
			const equalSignIndex = evaluableFormula.indexOf("=");
			if (equalSignIndex !== -1) {
				const izquierda = evaluableFormula.slice(0, equalSignIndex).trim();
				const derecha = evaluableFormula.slice(equalSignIndex + 1).trim();

				const variablesNoReemplazadas = izquierda.match(/[a-zA-Z_]\w*/g);
				if (variablesNoReemplazadas && variablesNoReemplazadas.length > 0) {
					console.warn(
						`Advertencia: La fórmula contiene variables no definidas: ${variablesNoReemplazadas.join(
							", "
						)}. No se pudo evaluar la restricción.`
					);
					return null;
				}

				const resultadoIzquierda = parser.evaluate(izquierda);
				const resultadoDerecha = parseFloat(derecha);

				if (isNaN(resultadoIzquierda) || isNaN(resultadoDerecha)) {
					console.error(
						"Error: Una de las partes de la fórmula resultó en NaN después de la evaluación. Revise la fórmula o los valores."
					);
					return null;
				}

				if (resultadoIzquierda !== resultadoDerecha && !alertShown.value) {
					alertShown.value = true;
					showToast(
						`Error: la suma debe ser igual a ${resultadoDerecha}. Revise las entradas de los campos.`,
						"warning",
						alertCircleOutline
					);
					return null;
				}

				alertShown.value = false;
				return resultadoIzquierda;
			}
		} catch (error) {
			console.error("Error al evaluar la fórmula:", error);
			return null;
		}
	};

	const calcularResultados = async (seccion: { resultado: any[] }, sectionIndex: number) => {
		// for (let i = 0; i < 2; i++) {

		//campoCalculadoLlenado es el valor que regresa la funcion como true si un campo calculado cambia o se llena
		let campoCalculadoLlenado: boolean = false;
		//valores es un objeto con el nombre del campo y su valor, si tiene un valor
		const valores: Record<string, any> = {};

		seccion.resultado.forEach((item: { valor: any; nombre: string | number }) => {
			if (item.valor) {
				valores[item.nombre] = item.valor;
			}
		});

		const currentSection = sectionRef.value[sectionIndex];
		const inputElements = currentSection.querySelectorAll("input");

		seccion.resultado.forEach((item: { calculado: string; valor: any; restricciones: any }, index: number) => {
			if (item.calculado) {
				//valorAnterior es para chequear si el valor del campo calculado cambia despues de aplicarFormula
				const valorAnterior = item.valor;
				for (const restriccion of item.restricciones) {
					aplicarRestriccion(restriccion, valores);
				}
				item.valor = aplicarFormula(item.calculado, valores);

				//chequear si se llena un campo calculado y cambia su valor anterior para que no entre en loop infinito
				if (item.valor && valorAnterior != item.valor) {
					campoCalculadoLlenado = true;
					const inputElement = inputElements[index];
					const inputValue = item.valor;
					const personAge = order.value.age;
					const personGenre = order.value.genre;
					const valorReferencialString = seccion.resultado[index].valor_referencial;
					const valorReferencialNumber = valorReferencialString.match(/(\d+(?:,\d+)?)/g);
					const parsedNumbers = valorReferencialNumber?.map((numStr: any) => parseFloat(numStr.replace(",", ".")));

					const numericInput = parseFloat(inputValue);

					const setInputColor = (isValid: boolean) => {
						inputElement.style.color = isValid ? "green" : "red";
						inputElement.style.borderColor = isValid ? "lightgreen" : "red";
					};

					const parseScientific = (str: string) => {
						const match = /(-?\d+(\.\d+)?)\s*x10\^([-+]?\d+)/.exec(str);
						if (match) {
							return parseFloat(match[1]) * Math.pow(10, parseInt(match[3], 10));
						}
						return parseFloat(str);
					};

					if (isNaN(numericInput)) {
						seccion.resultado[index].valor = null;
						return;
					}

					const validateRange = (min: number, max: number): boolean => {
						return numericInput >= min && numericInput <= max;
					};

					let isValid = true;

					if (parsedNumbers) {
						switch (parsedNumbers.length) {
							case 1: {
								if (valorReferencialString.includes("menor")) {
									isValid = numericInput < parsedNumbers[0];
								} else if (valorReferencialString.includes("Hasta")) {
									isValid = numericInput <= parsedNumbers[0];
								}
								break;
							}

							case 2: {
								isValid = validateRange(parsedNumbers[0], parsedNumbers[1]);
								if (valorReferencialString.includes("Hasta")) {
									isValid = numericInput <= parsedNumbers[1];
								}
								break;
							}

							case 4: {
								let range: [number, number];
								if (valorReferencialString.includes("Hombre")) {
									range = personGenre === "M" ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
								} else if (valorReferencialString.includes("Adulto")) {
									range = personAge > 17 ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
								} else {
									range = [parsedNumbers[0], parsedNumbers[1]];
								}
								isValid = validateRange(range[0], range[1]);
								break;
							}

							case 6: {
								let minRange = Infinity;
								let maxRange = -Infinity;

								const matches = valorReferencialString.match(/(-?\d+(\.\d+)?\s*x10\^[-+]?\d+)|(-?\d+(\.\d+)?)/g);

								matches?.forEach((matchStr: any) => {
									const val = parseScientific(matchStr);
									if (val !== undefined) {
										minRange = Math.min(minRange, val);
										maxRange = Math.max(maxRange, val);
									}
								});

								isValid = validateRange(minRange, maxRange);
								break;
							}

							default: {
								break;
							}
						}
					}
					setInputColor(isValid);
					seccion.resultado[index].valor = numericInput;
				}
			} else {
				for (const restriccion of item.restricciones) {
					console.log("rrrr", restriccion);
					aplicarRestriccion(restriccion, valores);
				}
			}
		});
		//si un campo calculado cambia o se llena por primera vez esta variable regresa true y vuelve a correr calcularResultados
		return campoCalculadoLlenado;
		// }
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

	.size {
		font-size: 14px;
	}

	.title-size {
		font-size: 20px;
	}

	.subtitle-size {
		font-size: 17px;
	}
</style>
