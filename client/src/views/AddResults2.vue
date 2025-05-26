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
							<div class="col text-center">
								<img src="/images/iconoPDF.png" alt="" style="height: 60px" />
							</div>
							<div class="col text-center">
								<img src="/images/direccionPDF.png" alt="" style="height: 60px" />
							</div>
						</div>
						<div class="border-bottom border-black"></div>
						<div class="mt-1 text-center d-flex">
							<div class="me-3">
								<div class="d-inline fw-bold">Paciente:</div>
								{{ order?.firstName }} {{ order?.lastName }}
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold">CI:</div>
								{{ order?.ci }}
							</div>
							<div v-if="order?.doctor" class="me-3">
								<div class="d-inline fw-bold">Dr:</div>
								{{ order?.doctor }}
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold">Edad:</div>
								{{ order?.age }}
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold">Sexo:</div>
								{{ order?.genre === "M" ? "Masculino" : "Femenino" }}
							</div>
							<div class="me-3">
								<div class="d-inline fw-bold">Fecha:</div>
								{{ day }}/{{ month }}/{{ year }}
							</div>
						</div>
					</div>

					<div class="profile-content" v-for="(profile, indx) in profilesData" :key="indx" ref="profileRef2">
						<div class="profile-sections mt-1" v-show="showProfile[indx]">
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
													<h4 class="m-0 text-nowrap">{{ profileNamesOrdered[indx] }}</h4>
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
													<h5 class="m-0 text-nowrap">{{ key }}</h5>
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

		// filtrar y ordenar secciones
		const filteredSections: any[] = [];
		const seenKeys = new Set();
		let firstTest = "";
		const firstSection: AnyKeyObject = {
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
		let primarySectionFilled = false;

		for (const profile of ordersArray.value) {
			const profileSection2 = await profilesStore.fetchProfileByInputsName2(profile.profiles[0].profileName, profile.idOrder);
			const sectionKeys = Object.keys(profileSection2);
			const hasPrimarySection = primarySectionsStrings.some((item) => sectionKeys.includes(item));

			const filteredSection: any = {};

			if (hasPrimarySection && !primarySectionFilled) {
				primarySectionFilled = true;
				for (const [key, value] of Object.entries(profileSection2)) {
					if (!seenKeys.has(key)) {
						firstSection[key] = value;
						seenKeys.add(key);
					}
				}
			} else {
				for (const [key, value] of Object.entries(profileSection2)) {
					if (!seenKeys.has(key)) {
						if (primarySectionsStrings.includes(key)) {
							firstSection[key] = value;
							seenKeys.add(key);
						} else {
							filteredSection[key] = value;
							seenKeys.add(key);
						}
					}
				}
			}

			if (hasPrimarySection && !firstTest) {
				firstTest = profile.profiles[0].profileName;
			} else {
				if (Object.keys(filteredSection).length != 0) {
					filteredSections.push(filteredSection);
					profileNamesOrdered.push(profile.profiles[0].profileName);
				}
			}
		}

		for (const [key, value] of Object.entries(firstSection)) {
			if (!value) {
				delete firstSection[key];
			}
		}

		if (firstTest) {
			profileNamesOrdered.unshift(firstTest);
		}

		if (Object.keys(firstSection).length != 0) {
			filteredSections.unshift(firstSection);
		}

		//

		profilesData.value = filteredSections;

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
			const filteredSections: any[] = [];
			const seenKeys = new Set();
			let firstTest = "";
			const firstSection: AnyKeyObject = {
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
			let primarySectionFilled = false;

			for (const profile of ordersArray.value) {
				const profileSection2 = await profilesStore.fetchProfileByInputsName2(profile.profiles[0].profileName, profile.idOrder);
				const sectionKeys = Object.keys(profileSection2);
				const hasPrimarySection = primarySectionsStrings.some((item) => sectionKeys.includes(item));

				const filteredSection: any = {};

				if (hasPrimarySection && !primarySectionFilled) {
					primarySectionFilled = true;
					for (const [key, value] of Object.entries(profileSection2)) {
						if (!seenKeys.has(key)) {
							firstSection[key] = value;
							seenKeys.add(key);
						}
					}
				} else {
					for (const [key, value] of Object.entries(profileSection2)) {
						if (!seenKeys.has(key)) {
							if (primarySectionsStrings.includes(key)) {
								firstSection[key] = value;
								seenKeys.add(key);
							} else {
								filteredSection[key] = value;
								seenKeys.add(key);
							}
						}
					}
				}

				if (hasPrimarySection && !firstTest) {
					firstTest = profile.profiles[0].profileName;
				} else {
					if (Object.keys(filteredSection).length != 0) {
						filteredSections.push(filteredSection);
						profileNamesOrdered.push(profile.profiles[0].profileName);
					}
				}
			}

			for (const [key, value] of Object.entries(firstSection)) {
				if (!value) {
					delete firstSection[key];
				}
			}

			if (firstTest) {
				profileNamesOrdered.unshift(firstTest);
			}

			if (Object.keys(firstSection).length != 0) {
				filteredSections.unshift(firstSection);
			}
			//

			profilesData.value = filteredSections;

			sectionData.value = profilesData.value[0];
			showProfile.value = new Array(profileNames.length).fill(false);
			showProfile.value[0] = true;
		}
		next();
	});

	const checkInputValue = async (event: Event, index: number, section: any, sectionIndex: number) => {
		const inputElement = event.target as HTMLInputElement;
		const inputValue = inputElement.value.replace(",", ".");
		const personAge = order.value.age;
		const personGenre = order.value.genre;
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

		if (Number.isNaN(numericInput)) {
			setInputColor(true);
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
					const hasScientificNotation = valorReferencialString.match(/(-?\d+(\.\d+)?\s*x10\^[-+]?\d+)/);
					if (hasScientificNotation) {
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
					} else {
						if (valorReferencialString.includes("Hombre")) {
							range = personGenre === "M" ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
						} else if (valorReferencialString.includes("Adulto")) {
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

		section.resultado[index].valor = numericInput;

		await calcularResultados(section, sectionIndex);
		if (section.resultado.length > 1) {
			await calcularResultados(section, sectionIndex);
		}
	};

	// const checkInputValue = async (event: Event, index: number, section: any, sectionIndex: number) => {
	// 	const inputElement = event.target as HTMLInputElement;
	// 	const personAge = order.value.age;
	// 	const personGenre = order.value.genre;
	// 	const valorReferencialString = section.resultado[index].valor_referencial;
	// 	const valorReferencialNumber = valorReferencialString.match(/(\d+(?:,\d+)?)/g);
	// 	const parsedNumbers = valorReferencialNumber?.map((numStr: any) => parseFloat(numStr.replace(",", ".")));
	// 	let inputValue = inputElement.value;

	// 	if (!isNaN(Number(inputValue.replace(",", ".")))) {
	// 		inputValue = inputValue.replace(",", ".");
	// 	}

	// 	if (parsedNumbers) {
	// 		if (parsedNumbers.length === 2) {
	// 			if (Number(inputValue) < parsedNumbers[0] || Number(inputValue) > parsedNumbers[1]) {
	// 				inputElement.style.color = "red";
	// 				inputElement.style.borderColor = "red";
	// 			} else {
	// 				inputElement.style.color = "green";
	// 				inputElement.style.borderColor = "lightgreen";
	// 			}
	// 			if (valorReferencialString.includes("Hasta")) {
	// 				if (Number(inputValue) > parsedNumbers[0]) {
	// 					inputElement.style.color = "red";
	// 					inputElement.style.borderColor = "red";
	// 				} else {
	// 					inputElement.style.color = "green";
	// 					inputElement.style.borderColor = "lightgreen";
	// 				}
	// 			}
	// 		}

	// 		if (parsedNumbers.length === 1) {
	// 			if (valorReferencialString.includes("menor")) {
	// 				if (Number(inputValue) < parsedNumbers[0]) {
	// 					inputElement.style.color = "green";
	// 					inputElement.style.borderColor = "lightgreen";
	// 				} else {
	// 					inputElement.style.color = "red";
	// 					inputElement.style.borderColor = "red";
	// 				}
	// 			} else if (valorReferencialString.includes("Hasta")) {
	// 				if (Number(inputValue) > parsedNumbers[0]) {
	// 					inputElement.style.color = "red";
	// 					inputElement.style.borderColor = "red";
	// 				} else {
	// 					inputElement.style.color = "green";
	// 					inputElement.style.borderColor = "lightgreen";
	// 				}
	// 			}
	// 		}

	// 		if (parsedNumbers.length === 4) {
	// 			if (valorReferencialString.includes("Hombre")) {
	// 				const validRange = personGenre === "M" ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
	// 				if (Number(inputValue) < validRange[0] || Number(inputValue) > validRange[1]) {
	// 					inputElement.style.color = "red";
	// 					inputElement.style.borderColor = "red";
	// 				} else {
	// 					inputElement.style.color = "green";
	// 					inputElement.style.borderColor = "lightgreen";
	// 				}
	// 			} else if (valorReferencialString.includes("Adulto")) {
	// 				const validRange = personAge > 17 ? [parsedNumbers[0], parsedNumbers[1]] : [parsedNumbers[2], parsedNumbers[3]];
	// 				if (Number(inputValue) < validRange[0] || Number(inputValue) > validRange[1]) {
	// 					inputElement.style.color = "red";
	// 					inputElement.style.borderColor = "red";
	// 				} else {
	// 					inputElement.style.color = "green";
	// 					inputElement.style.borderColor = "lightgreen";
	// 				}
	// 			}
	// 		}

	// 		if (parsedNumbers.length === 6) {
	// 			let minRange = Infinity;
	// 			let maxRange = -Infinity;

	// 			try {
	// 				const matches = valorReferencialString.match(/(-?\d+(\.\d+)?)\s*x10\^([-+]?\d+)|(-?\d+(\.\d+)?)/g);

	// 				const exponentMatches = valorReferencialString.match(/x10\^([-+]?\d+)/g);

	// 				let exponentFactor = 1;

	// 				if (exponentMatches) {
	// 					for (const exp of exponentMatches) {
	// 						const exponent = parseInt(exp.replace("x10^", ""), 10);
	// 						exponentFactor *= Math.pow(10, exponent);
	// 					}
	// 				}

	// 				if (matches) {
	// 					for (const match of matches) {
	// 						const matchScience = /(-?\d+(\.\d+)?)\s*x10\^([-+]?\d+)/.exec(match);
	// 						if (matchScience) {
	// 							const base = parseFloat(matchScience[1]);
	// 							const exponent = parseInt(matchScience[3], 10);
	// 							const value = base * Math.pow(10, exponent);
	// 							minRange = Math.min(minRange, value);
	// 							maxRange = Math.max(maxRange, value);
	// 						} else {
	// 							const value = parseFloat(match) * exponentFactor;
	// 							minRange = Math.min(minRange, value);
	// 							maxRange = Math.max(maxRange, value);
	// 						}
	// 					}
	// 				}

	// 				if (!isNaN(Number(inputValue))) {
	// 					if (Number(inputValue) < minRange || Number(inputValue) > maxRange) {
	// 						inputElement.style.color = "red";
	// 						inputElement.style.borderColor = "red";
	// 					} else {
	// 						inputElement.style.color = "green";
	// 						inputElement.style.borderColor = "lightgreen";
	// 					}
	// 				} else {
	// 					inputElement.style.color = "red";
	// 					inputElement.style.borderColor = "red";
	// 				}
	// 			} catch (error) {
	// 				console.error("Error al evaluar la fórmula:", error);
	// 				inputElement.style.color = "red";
	// 				inputElement.style.borderColor = "red";
	// 			}
	// 		}

	// 		if (!inputValue) {
	// 			inputElement.style.color = "black";
	// 			inputElement.style.borderColor = "black";
	// 		}

	// 		section.resultado[index].valor = Number(inputValue);

	// 		await calcularResultados(section, sectionIndex);

	// 		if (section.resultado.length - 1) {
	// 			await calcularResultados(section, sectionIndex);
	// 		}
	// 	}
	// };

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

	const getHtmlWithInputValues = (element: HTMLElement): string => {
		const perfilHeading = element.querySelector("h4");
		const perfilName = perfilHeading ? perfilHeading.textContent?.trim() : "Perfil sin nombre";

		const sections = element.querySelectorAll("h5");
		const rows: { section: string; data: string[] }[] = [];

		sections.forEach((section) => {
			const sectionName = section.textContent?.trim();
			const table = section.nextElementSibling;

			if (table && table instanceof HTMLElement) {
				const inputs = table.querySelectorAll<HTMLInputElement>("input");
				const sectionRows: string[] = [];

				inputs.forEach((input) => {
					const value = input.value.trim();
					if (value) {
						const parentRow = input.closest("tr");
						if (parentRow) {
							const nombreCell = parentRow.querySelector("td.align-middle");
							const unidadCell = parentRow.querySelector(".unidad");
							const valorReferencialCell = parentRow.querySelector(".valor-referencial");

							const nombre = nombreCell ? nombreCell.textContent?.trim() : "N/A";
							const unidad = unidadCell ? unidadCell.textContent?.trim() : "N/A";
							const valorReferencial = valorReferencialCell ? valorReferencialCell.innerHTML.trim() : "N/A";

							sectionRows.push(`
								<tr class="p-0">
									<td class="align-middle py-0">${nombre}</td>
									<td class="align-middle py-0">${value}</td>
									<td class="align-middle py-0">${unidad}</td>
									<td class="valor-referencial align-middle py-0 text-nowrap">${valorReferencial}</td>
								</tr>
							`);
						}
					}
				});

				if (sectionRows.length > 0) {
					rows.push({ section: sectionName || "Sección sin nombre", data: sectionRows });
				}
			}
		});

		if (rows.length === 0) {
			return "";
		}

		const htmlOutput = `
			<div>
				<h4 class="text-center m-0">${perfilName}</h4>
				${rows
					.map(
						({ section, data }) => `
					<h5 class="text-center m-0">${section}</h5>
					<table class="table table-hover table-striped m-0">
						<thead>
							<tr>
								<th scope="col" class="col-3">Nombre</th>
								<th scope="col" class="col-3">Resultados</th>
								<th scope="col" class="col-3">Unidad</th>
								<th scope="col" class="col-3">Valor Referencial</th>
							</tr>
						</thead>
						<tbody>
							${data.join("")}
						</tbody>
					</table>
				`
					)
					.join("")}
			</div>
		`;
		return htmlOutput;
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
					const tableName = table.querySelector("h5");
					const tableData = table.querySelectorAll("tbody tr");
					testSections[tableName.innerHTML] = [];

					// tableData.forEach((tr: any) => {
					// 	const dataRow = {
					// 		fieldName: "",
					// 		inputValue: 0,
					// 		Unit: "",
					// 	};
					// 	tr.children.forEach((td: any, i: number) => {
					// 		if (i === 0) {
					// 			dataRow.fieldName = td.innerHTML;
					// 		}
					// 		if (i === 1) {
					// 			const inputElement = td.querySelector("input");
					// 			dataRow.inputValue = inputElement.value;
					// 		}
					// 		if (i === 2) {
					// 			dataRow.Unit = td.innerHTML;
					// 		}
					// 	});
					// 	testSections[tableName.innerHTML].push(dataRow);
					// 	profileFields.push(dataRow);
					// });

					tableData.forEach((tr: any) => {
						const dataRow = {
							fieldName: "",
							inputValue: "",
							Unit: "",
						};

						const tds = tr.children;

						dataRow.fieldName = tds[0]?.innerHTML || "";
						const inputElement = tds[1]?.querySelector("input");
						dataRow.inputValue = inputElement ? inputElement.value : "";
						dataRow.Unit = tds[2]?.innerHTML || "";

						if (profileFields) profileFields.push(dataRow);
						if (testSections[tableName.innerHTML]) {
							testSections[tableName.innerHTML].push(dataRow);
						}
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
		// --- 1. PREPARACIÓN Y VALIDACIÓN DE ELEMENTOS ---
		if (!profileRef.value || !firmaSello.value) {
			console.error("Error: Las referencias a los elementos del perfil o firma/sello no están disponibles.");
			return;
		}

		const profileRefCopy = profileRef.value.cloneNode(true) as HTMLElement;
		const divFirmaSelloCopy = firmaSello.value.cloneNode(true) as HTMLElement;

		// Ejecuta tus funciones de manipulación del DOM sobre la copia antes de procesar el contenido
		await mergeTables(profileRefCopy); // Asegúrate de que esto fusione las tablas dentro de profileRefCopy
		await inputToSpan(profileRefCopy); // Asegúrate de que esto convierta los inputs dentro de profileRefCopy

		const patientInfoElement = profileRefCopy.querySelector(".patient-info") as HTMLElement | null;
		const allProfileContents = Array.from(profileRefCopy.querySelectorAll(".profile-content")) as HTMLElement[];

		if (!patientInfoElement || allProfileContents.length === 0) {
			console.error("Error: No se pudo encontrar la información del paciente o el contenido principal de perfil.");
			return;
		}

		// --- 2. LÓGICA DE PAGINACIÓN MANUAL CON CONSTRUCCIÓN DEL DOM ---

		const pdfContainer = document.createElement("div");
		pdfContainer.style.width = "210mm"; // Ancho de una página A4/Letter para html2canvas
		pdfContainer.style.padding = "0mm 5mm"; // Márgenes laterales para el contenido

		// Altura máxima del contenido por página en 'mm'.
		// Puedes ajustar este valor si el margen vertical es demasiado grande o pequeño.
		const alturaMaximaContenidoMM = 270; // Un valor intermedio entre 240 y 270 para buen equilibrio

		let paginaActual = document.createElement("div");
		// Inicialmente, no le ponemos pageBreakAfter a la primera página
		paginaActual.style.boxSizing = "border-box";
		paginaActual.style.minHeight = `${alturaMaximaContenidoMM * 0.95}mm`; // Ligeramente menor para flexibilidad
		pdfContainer.appendChild(paginaActual);

		// Añade la información del paciente a la primera página
		paginaActual.appendChild(patientInfoElement.cloneNode(true));

		let alturaAcumulada = (patientInfoElement.offsetHeight ?? 0) * 0.264583;

		// Iterar sobre CADA .profile-content DIV
		for (const contentDiv of allProfileContents) {
			const contentDivCloned = contentDiv.cloneNode(true) as HTMLElement;

			// Si este div de contenido tiene una tabla, aplicar page-break-inside a sus filas
			const tablaEnContent = contentDivCloned.querySelector("table");
			if (tablaEnContent) {
				const filasTabla = Array.from(tablaEnContent.querySelectorAll("tbody > tr")) as HTMLTableRowElement[];
				filasTabla.forEach((fila) => {
					fila.style.pageBreakInside = "avoid";
					fila.style.breakInside = "avoid";
				});
				// Opcional: Asegurarse de que el thead tampoco se corte si la tabla es grande
				const thead = tablaEnContent.querySelector("thead");
				if (thead) thead.style.pageBreakInside = "avoid";
			}

			// Calcular la altura real (o una buena estimación) del bloque de contenido clonado
			// Esto puede ser difícil sin un renderizado. html2canvas lo hará mejor al final.
			// Nos basamos en offsetHeight para una estimación.
			const contentBlockHeightMM = (contentDivCloned.offsetHeight ?? 0) * 0.264583;

			// Lógica para decidir si el bloque de contenido debe ir en una nueva página
			// Solo si la página actual tiene contenido y añadir el nuevo bloque la desbordaría
			if (alturaAcumulada + contentBlockHeightMM > alturaMaximaContenidoMM && alturaAcumulada > 0) {
				// Marca la página ANTERIOR para un salto
				paginaActual.style.pageBreakAfter = "always";

				paginaActual = document.createElement("div");
				paginaActual.style.boxSizing = "border-box";
				paginaActual.style.minHeight = `${alturaMaximaContenidoMM * 0.95}mm`;
				pdfContainer.appendChild(paginaActual);

				alturaAcumulada = 0; // Reiniciar altura para la nueva página
			}

			// Añade el bloque de contenido a la página actual
			paginaActual.appendChild(contentDivCloned);
			alturaAcumulada += contentBlockHeightMM;
		}

		// --- Añadir la firma y el sello ---
		const firmaSelloHeightMM = (divFirmaSelloCopy.offsetHeight ?? 0) * 0.264583;

		// Si la firma no cabe en la página actual O si deseamos que siempre inicie en una nueva página.
		// Aquí decidimos si la firma debe ir a una nueva página para evitar cortes con el contenido previo.
		if (alturaAcumulada + firmaSelloHeightMM > alturaMaximaContenidoMM) {
			// Solo añadir salto si la página actual ya tiene contenido
			if (paginaActual && alturaAcumulada > 0) {
				paginaActual.style.pageBreakAfter = "always";
			}
			paginaActual = document.createElement("div");
			paginaActual.style.boxSizing = "border-box";
			paginaActual.style.minHeight = `${firmaSelloHeightMM + 10}mm`; // Suficiente espacio para firma
			pdfContainer.appendChild(paginaActual);
		}

		// Asegurarse de que el div de firma/sello no tenga un salto de página después de sí mismo
		divFirmaSelloCopy.style.pageBreakAfter = "auto";
		if (paginaActual) {
			paginaActual.appendChild(divFirmaSelloCopy);
		}

		// --- SOLUCIÓN PARA LA PÁGINA EN BLANCO ADICIONAL AL FINAL ---
		// Esto es crucial para la paginación manual
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

		// Calcula el margen para que el contenido total sea de alturaMaximaContenidoMM
		// Página Letter: ~279.4mm de alto.
		const verticalMargin = (279.4 - alturaMaximaContenidoMM) / 2;

		const options = {
			margin: [verticalMargin, 5, verticalMargin, 5], // Márgenes [arriba, derecha, abajo, izquierda] en mm
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

		// Se le pasa el contenedor DOM, no la cadena HTML
		html2pdf().from(pdfContainer).set(options).save();
		// html = ""; // Esta línea ya no es relevante si 'html' no es una variable global o no se usa después
	};

	const pdfCover = async () => {
		const profileRefCopy = profileRef.value.cloneNode(true);
		const patientInfoDivCopy = profileRefCopy.querySelector(".patient-info");

		html = patientInfoDivCopy.innerHTML;

		const element = html;

		const filename = `portada.pdf`;
		profileName.value = `portada.pdf`;

		const options = {
			margin: 6,
			filename: filename,
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "mm", format: "letter", orientation: "portrait" },
		};

		const html2pdf = (await import("html2pdf.js")).default;

		html2pdf().from(element).set(options).save();
	};

	async function mergeTables(element: HTMLElement) {
		const tables = Array.from(element.querySelectorAll("table"));
		const testTitlesDivs = Array.from(element.querySelectorAll(".testTitle"));
		const profileSection = element.querySelector(".profile-sections") as HTMLElement;

		profileSection.style.display = "block";

		//Revisar si ningun input tiene valor y eliminar ese tbody y su titulo
		tables.forEach((table, i) => {
			const tbodies = Array.from(table.querySelectorAll(".sectionData"));
			//Chequear inputs de la seccion
			tbodies.forEach((tbody) => {
				const inputs = Array.from(tbody.querySelectorAll("input"));
				const sectionInputvalues = inputs.some((input) => input.value);

				if (!sectionInputvalues) {
					tbody.parentNode?.removeChild(tbody);
				}
			});

			const updatedTbodies = Array.from(table.querySelectorAll(".sectionData"));
			if (!updatedTbodies.length) {
				testTitlesDivs[i].parentNode?.removeChild(testTitlesDivs[i]);
			}
		});

		//Eliminar titulo perfil 20
		testTitlesDivs.forEach((div) => {
			const titleText = div.querySelector("h4");
			if (titleText?.innerHTML === "Perfil 20") {
				div.parentNode?.removeChild(div);
			}
		});

		const firstTable = tables[0];

		for (let i = 1; i < tables.length; i++) {
			const currentTable = tables[i];
			const tbodies = currentTable.querySelectorAll("tbody");

			if (tbodies) {
				tbodies.forEach((tbody) => {
					firstTable.appendChild(tbody);
				});
			}
		}
	}

	const inputToSpan = async (parentElement: HTMLElement) => {
		//Agarrar inputs y cambiarlos por span o eliminarlos si no contienen valor
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
	const pdfWithoutSignature = async () => {
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

		// Altura máxima del contenido por página en 'mm'.
		const alturaMaximaPorPaginaMM = 240;

		let paginaActual = document.createElement("div");
		// Inicialmente no le ponemos pageBreakAfter, se lo añadiremos condicionalmente
		paginaActual.style.boxSizing = "border-box";
		paginaActual.style.minHeight = `${alturaMaximaPorPaginaMM}mm`;
		pdfContainer.appendChild(paginaActual);

		paginaActual.appendChild(patientInfoElement.cloneNode(true));

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

		let tablaActual = crearNuevaTablaConEncabezado();
		paginaActual.appendChild(tablaActual);

		// let alturaAcumulada = (tablaActual.querySelector("thead")?.offsetHeight ?? 0) * 0.264583;

		for (const fila of filas) {
			const filaClonada = fila.cloneNode(true) as HTMLTableRowElement;
			filaClonada.style.pageBreakInside = "avoid";
			filaClonada.style.breakInside = "avoid";

			// const alturaFilaMM = fila.offsetHeight * 0.264583;

			// Si la fila actual no cabe en la página restante, creamos una nueva página
			// if (alturaAcumulada + alturaFilaMM > alturaMaximaPorPaginaMM) {
			// 	console.log("pagina nueva");
			// 	// Aquí es donde marcamos la página ANTERIOR para un salto
			// 	paginaActual.style.pageBreakAfter = "always"; // <--- Se añadió aquí.

			// 	paginaActual = document.createElement("div");
			// 	// La nueva página NO tiene pageBreakAfter inicialmente.
			// 	paginaActual.style.boxSizing = "border-box";
			// 	paginaActual.style.minHeight = `${alturaMaximaPorPaginaMM}mm`;
			// 	pdfContainer.appendChild(paginaActual);

			// 	tablaActual = crearNuevaTablaConEncabezado();
			// 	paginaActual.appendChild(tablaActual);

			// 	alturaAcumulada = (tablaActual.querySelector("thead")?.offsetHeight ?? 0) * 0.264583;
			// }

			const tbodyActual = tablaActual.querySelector("tbody");
			if (tbodyActual) {
				tbodyActual.appendChild(filaClonada);
				// alturaAcumulada += alturaFilaMM;
			}
		}

		// --- SOLUCIÓN PARA LA PÁGINA EN BLANCO ADICIONAL ---
		// Después de que todo el contenido ha sido añadido, aseguramos que la última "página"
		// (el último div hijo de pdfContainer) no tenga page-break-after.
		const lastPageDiv = pdfContainer.lastElementChild as HTMLElement;
		if (lastPageDiv) {
			lastPageDiv.style.pageBreakAfter = "auto"; // Remueve el salto de página extra
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
			margin: [2, 5], // Márgenes [arriba/abajo, izquierda/derecha] en mm
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
		const profileContentDivs = Array.from(profileRefCopy.querySelectorAll(".profile-content")) as HTMLElement[];

		if (!patientInfoElement) {
			console.error("Error: No se pudo encontrar el elemento HTML de información del paciente.");
			return Promise.reject(new Error("No se pudo encontrar el elemento HTML de información del paciente."));
		}

		// --- 2. LÓGICA DE PAGINACIÓN MANUAL EN EL DOM TEMPORAL ---

		const pdfContainer = document.createElement("div");
		pdfContainer.style.width = "210mm"; // Ancho de una página A4/Letter
		pdfContainer.style.padding = "0mm 5mm"; // Márgenes laterales para el contenido

		const alturaMaximaContenidoMM = 270; // Altura máxima deseada del contenido por página

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

		for (const contentDiv of profileContentDivs) {
			const contentDivCloned = contentDiv.cloneNode(true) as HTMLElement;

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
		const evaluableFormula = formula.replace(/(\w+)/g, (match) => {
			if (Object.prototype.hasOwnProperty.call(valores, match)) {
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
			if (Object.prototype.hasOwnProperty.call(valores, match)) {
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

				if (resultadoIzquierda !== resultadoDerecha && !alertShown.value) {
					alertShown.value = true;
					showToast(
						`Error: la suma debe ser igual a ${resultadoDerecha}. Revise las entradas de los campos.`,
						"warning",
						alertCircleOutline
					);
					return null;
				}

				return resultadoIzquierda;
			}
		} catch (error) {
			console.error("Error al evaluar la fórmula:", error);
			return null;
		}
	};

	const calcularResultados = async (seccion: { resultado: any[] }, sectionIndex: number) => {
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
				for (const restriccion of item.restricciones) {
					aplicarRestriccion(restriccion, valores);
				}
				item.valor = aplicarFormula(item.calculado, valores);

				if (item.valor) {
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
