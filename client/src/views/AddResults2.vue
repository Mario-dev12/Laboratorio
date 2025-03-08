<template>
	<ion-page>
		<ion-content>
			<div class="container">
				<div class="perfiles mt-3">
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
												<th scope="col" class="col-3">Valor</th>
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
					<button class="col btn btn-primary" @click="sendEmail">Enviar por Correo</button>
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
		console.log(profilesData.value);
		sectionData.value = profilesData.value[0];
		sectionNames.value = profilesData.value;
		showProfile.value = new Array(profileNames.length).fill(false);
		showProfile.value[0] = true;
	});

	router.beforeEach(async (to, from, next) => {
		profilesData.value = [];
		if (from.name === "OrdersView") {
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
		console.log(profilesData.value);
		console.log(sectionData.value);
		tableInfo.value = "";
		showProfile.value.forEach((element: boolean, i: number) => {
			if (i === index) {
				showProfile.value[i] = true;
			} else {
				showProfile.value[i] = false;
			}
		});
		sectionNames.value = Object.keys(sectionData.value);
		console.log(sectionNames.value);
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
		console.log(testsResults);
		console.log(profileRef2.value);
		console.log(profileRef2.value[0]);

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
				console.log(item.children[1].children[1]);
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
						console.log(tr.children);
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
				console.log(Object.values(testsResults));
				Object.values(testsResults)[index].push(testSections);

				results = {
					orderId: ordersArray.value[index].idOrder,
					profileName: profileNames[index],
					fields: profileFields,
				};
				console.log(results);
				// hacer llamado al store aqui
				await examsStore.createExamResults(results);
			});
			console.log(testsResults);
		}
	};

	const generatePDF = () => {
		const profileRefCopy = profileRef.value.cloneNode(true);

		profileRefCopy.children.forEach((item: any) => {
			const childrenCopy = item.children[0].cloneNode(true);
			childrenCopy.style.display = "block";

			html += getHtmlWithInputValues(childrenCopy);
		});
		const element = html;
		const options = {
			margin: 1,
			filename: "perfil_laboratorio.pdf",
			image: { type: "jpeg", quality: 0.98 },
			html2canvas: { scale: 2 },
			jsPDF: { unit: "in", format: "letter", orientation: "portrait" },
		};

		pdfFileName.value = options.filename;
		console.log(options.filename);
		console.log(pdfFileName.value);

		html2pdf().from(element).set(options).save();
		html = "";
	};

	// Nodemailer

	function sendEmail() {
		const emailData = {
			to: "francorm007@gmail.com",
			subject: "email test",
			text: "prueba desde la app del laboratorio",
			attachment: pdfFileName.value,
		};
		console.log(typeof emailData.attachment);

		mailsStore.sendEmail(emailData);
	}

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
