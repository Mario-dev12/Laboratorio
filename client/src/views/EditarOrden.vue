<template>
	<ion-page>
		<ion-content>
			<div class="d-flex mt-4 ms-5">
				<div class="p-3 bg-dark-subtle rounded text-center">
					<h2>Tasa del Dolar</h2>
					<h3>Bs: {{ precioDolar }}</h3>
					<button
						class="btn btn-primary mb-2"
						v-if="!showChangeDolar"
						@click="
							() => {
								showChangeDolar = !showChangeDolar;
							}
						">
						Editar
					</button>
					<div v-if="showChangeDolar">
						<input class="d-block mb-2" type="text" v-model="cambioDolar" />
						<button class="d-block btn btn-primary w-auto mx-auto" @click="cambiarPrecioDolar(cambioDolar)">
							Cambiar tasa del dolar
						</button>
					</div>
				</div>
			</div>
			<div class="container mt-2 p-3 bg-dark-subtle rounded">
				<div class="w-100 m-auto row px-2">
					<label class="col-12 p-0" for="documento">Documento de identidad</label>
					<div class="col-12 p-0">
						<div class="row w-100 m-auto pe-1 justify-content-between">
							<input class="col-10" type="text" placeholder="Documento de identidad" v-model="user.documento" />
						</div>
					</div>
				</div>
				<div class="row mt-2 w-100 m-auto">
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="nombre">Nombre</label>
							<input class="col w-auto" type="text" placeholder="Nombre" v-model="user.nombre" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="apellido">Apellido</label>
							<input class="col w-auto" type="text" placeholder="Apellido" v-model="user.apellido" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="genero">Género</label>
							<select class="col w-auto py-2" v-model="user.genero">
								<option disabled selected>Seleccionar</option>
								<option value="masculino">Masculino</option>
								<option value="femenino">Femenino</option>
							</select>
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="edad">Edad</label>
							<input class="col w-auto" type="number" placeholder="Edad" v-model="user.edad" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="procedencia">Procedencia</label>
							<input class="col w-auto" type="text" placeholder="Ingrese la procedencia" v-model="user.procedencia" />
						</div>
					</div>
				</div>
			</div>
			<div class="bg-dark-subtle container p-3 rounded mt-3">
				<div class="row w-100 m-auto">
					<div class="col-12">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="examen">Tipo de Examen:</label>
							<select class="col p-1" name="examen" id="examen" v-model="tipoDeExamen" @change="agregarExamen()">
								<option value="">Seleccionar</option>
								<option v-for="profile in profiles" :key="profile.idProfile" :value="profile.name">{{ profile.name }}</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row w-100 m-auto">
					<div class="col-12">
						<div class="mt-2 table-responsive">
							<table class="table text-nowrap table-striped">
								<thead>
									<tr>
										<th scope="col">Examen</th>
										<th scope="col">Precio Bs</th>
										<th scope="col">Precio $</th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="(value, index) in examenesSeleccionados" :key="index">
										<td>{{ value.name }}</td>
										<td>Bs: {{ value.cost_usd * precioDolar }}</td>
										<td>$: {{ value.cost_usd }}</td>
										<td>
											<button class="btn btn-danger" @click="eliminarExamen(value.name)">Borrar</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<button :disabled="examenesSeleccionados.length === 0" class="btn btn-primary mt-3" @click="abrirModal">
							Agregar método de pago del paciente
						</button>
					</div>
				</div>
				<ModalEditarMetodo
					:isOpen="mostrarModal"
					:totales="totales"
					:precioDolar="precioDolar"
					:paymentData="paymentData"
					@update-precio-dolar="cambiarPrecioDolar($event)"
					@close="closeModal"
					@add="guardarMetodoPago" />
			</div>
			<div class="factura container mt-3 mb-4 bg-dark-subtle rounded p-3">
				<div class="row w-100 m-auto mb-1">
					<div class="col">Numero de orden</div>
					<div class="col">1</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Fecha</div>
					<div class="col">{{ `${day}/${month}/${year}` }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Total En Bs</div>
					<div class="col">Bs: {{ totales.totalBs }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Total En $</div>
					<div class="col">$: {{ totales.total$ }}</div>
				</div>
				<div v-if="paymentData && paymentData.length > 0" class="mt-3">
					<div class="row w-100 m-auto mt-3">
						<div class="col">Métodos de Pago</div>
					</div>

					<div v-for="(metodo, index) in paymentData" :key="index" class="row w-100 m-auto mb-1">
						<div class="col">{{ metodo.name }}</div>
						<div class="col">Monto: Bs {{ metodo.amount_bs !== undefined ? metodo.amount_bs : "N/A" }}</div>
						<div class="col">Divisa: {{ metodo.amount_usd }}</div>
						<div class="col" v-if="metodo.bank">Banco: {{ metodo.bank }}</div>
						<div class="col" v-if="metodo.phone">Teléfono: {{ metodo.phone }}</div>
					</div>
				</div>
			</div>
			<div class="row w-100 m-auto justify-content-center mb-4">
				<button class="btn btn-primary w-auto" @click="saveOrder">Guardar Edición</button>
			</div>
			<div class="toast-container position-fixed top-0 end-0 p-3 z-3">
				<div
					id="searchClientToast"
					class="toast align-items-center text-bg-warning border-0 text-white"
					role="alert"
					aria-live="assertive"
					aria-atomic="true">
					<div class="d-flex">
						<div class="toast-body">No se encontró cliente con ese documento de identidad</div>
						<button
							type="button"
							class="btn-close btn-close-white me-2 m-auto"
							data-bs-dismiss="toast"
							aria-label="Close"></button>
					</div>
				</div>
			</div>
			<div class="toast-container position-fixed top-0 end-0 p-3 z-3">
				<div
					id="liveToast"
					class="toast align-items-center text-bg-primary border-0"
					role="alert"
					aria-live="assertive"
					aria-atomic="true">
					<div class="d-flex">
						<div class="toast-body">Orden Creada Exitosamente!!</div>
						<button
							type="button"
							class="btn-close btn-close-white me-2 m-auto"
							data-bs-dismiss="toast"
							aria-label="Close"></button>
					</div>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { ref, watch, onMounted } from "vue";
	import { IonContent, IonPage } from "@ionic/vue";
	import { userStore } from "@/stores/userStore";
	import { User, Exam, Order, Payment } from "@/interfaces/interfaces";
	import { Toast } from "bootstrap";
	import ModalEditarMetodo from "@/components/ModalEditarMetodo.vue";
	import { examStore } from "@/stores/examStore";
	import { profileStore } from "@/stores/profileStore";
	import { orderStore } from "@/stores/orderStore";
	import { paymentStore } from "@/stores/paymentStore";
	import { useRoute, useRouter } from "vue-router";

	const tipoDeExamen = ref();
	const pagoEnDivisas = ref();
	const pagoEnBs = ref();
	const examenesSeleccionados = ref<Examen[]>([]);
	const today = new Date();
	const day = today.getUTCDate();
	const month = today.getUTCMonth() + 1;
	const year = today.getFullYear();
	const precioDolar = ref(Number(localStorage.getItem("tasaDolar")) || 50);
	const cambioDolar = ref(precioDolar.value);
	const metodoPagos = ref();
	const showChangeDolar = ref(false);
	const mostrarModal = ref(false);
	const profiles = ref();
	const examsStore = examStore();
	const ordersStore = orderStore();
	const profilesStore = profileStore();
	const paymentsStore = paymentStore();
	const usersStore = userStore();
	const router = useRouter();
	const route = useRoute();
	const user = ref({
		id: 0,
		documento: "",
		nombre: "",
		apellido: "",
		genero: "",
		edad: 0,
		procedencia: "",
	});
	const userData = ref();
	const orderData = ref();
	const paymentData = ref();

	const totales = ref({
		totalBs: 0,
		total$: 0,
	});

	const idUser = ref(route.params.idUser);
	const idExam = ref(route.params.idExam);
	const cost_bs = ref(route.params.cost_bs);
	const cost_usd = ref(route.params.cost_usd);
	const totalDolar = ref();
	const originalUserData = ref();
	const originalOrdersData = ref();
	const originalPaymentData = ref();

	onMounted(async () => {
		userData.value = await usersStore.fecthUserById(Number(idUser.value));
		orderData.value = await ordersStore.fecthOrderByExamId(Number(idExam.value));
		paymentData.value = await paymentsStore.fecthPaymentByExamId(Number(idExam.value));
		if (!Array.isArray(cost_bs.value) && !Array.isArray(cost_usd.value)) {
			totalDolar.value = Number(cost_bs.value.replace(",", ".")) / Number(cost_usd.value.replace(",", "."));
		}
		precioDolar.value = totalDolar.value;
		for (const item of orderData.value) {
			examenesSeleccionados.value.push({
				idExam: item.idExam,
				idProfile: item.idProfile,
				cost_bs: item.cost_bs,
				cost_usd: Number(item.cost_usd),
				name: item.name,
			});
		}
		user.value.apellido = userData.value[0].lastName;
		user.value.documento = userData.value[0].ci;
		user.value.edad = userData.value[0].age;
		user.value.genero = userData.value[0].genre === "M" ? "masculino" : "femenino";
		user.value.nombre = userData.value[0].firstName;
		user.value.procedencia = userData.value[0].address;
		user.value.id = userData.value[0].idUser;
		profiles.value = await profilesStore.fecthProfiles();
		profiles.value = profiles.value.map((exam: { cost_bs: string; cost_usd: string }) => ({
			...exam,
			cost_bs: parseFloat(exam.cost_bs.replace(",", ".")),
			cost_usd: parseFloat(exam.cost_usd),
		}));
		originalUserData.value = { ...user.value };
		originalOrdersData.value = examenesSeleccionados.value;
		originalPaymentData.value = paymentData.value;
	});

	interface Examen {
		name: string;
		cost_usd: number;
		cost_bs: number;
		idExam: number;
		idProfile: number;
	}

	const cambiarPrecioDolar = (nuevoPrecio: any) => {
		const newPrice = Number(nuevoPrecio);
		if (isNaN(nuevoPrecio) || nuevoPrecio === "") {
			alert("Ingrese un valor válido");
		} else {
			precioDolar.value = newPrice;
			cambioDolar.value = newPrice;
			localStorage.setItem("tasaDolar", newPrice.toString());
			totales.value.total$ = 0;
			totales.value.totalBs = 0;
			for (const item of examenesSeleccionados.value) {
				totales.value.totalBs += item.cost_usd * precioDolar.value;
				totales.value.total$ += item.cost_usd;
			}
		}
	};

	const agregarExamen = async () => {
		for (const item of profiles.value) {
			const itemInArray = examenesSeleccionados.value.find((element) => element.name === item.name);

			if (item.name === tipoDeExamen.value && !itemInArray) {
				examenesSeleccionados.value = [...examenesSeleccionados.value, { ...item }];

				originalOrdersData.value = originalOrdersData.value.filter(
					(originalItem: { name: string }) => originalItem.name !== item.name
				);

				pagoEnBs.value = "";
				pagoEnDivisas.value = "";
			}
		}

		paymentData.value = null;

		if (originalPaymentData.value) {
			for (let i = 0; i < originalPaymentData.value.length; i++) {
				await paymentsStore.deletePayment(originalPaymentData.value[i].idPayment);
			}
		}

		originalPaymentData.value = null;
		tipoDeExamen.value = "";
	};

	const actualizarCostosEnBs = () => {
		examenesSeleccionados.value.forEach((examen) => {
			examen.cost_bs = examen.cost_usd * precioDolar.value;
		});
	};

	async function eliminarExamen(examen: string) {
		const resp: { name: string; cost_usd: number; cost_bs: number; idExam: number; idProfile: number }[] = [];
		examenesSeleccionados.value = examenesSeleccionados.value.filter((item) => {
			if (item.name === examen) {
				resp.push(item);
			}
			return item.name !== examen;
		});
		paymentData.value = null;

		if (!originalPaymentData.value) {
		} else {
			for (let i = 0; i < originalPaymentData.value.length; i++) {
				await paymentsStore.deletePayment(originalPaymentData.value[i].idPayment);
			}
		}

		originalPaymentData.value = null;
	}

	watch(precioDolar, () => {
		actualizarCostosEnBs();
	});

	watch(examenesSeleccionados.value, (newValue, oldValue) => {
		if (newValue.length) {
			if (newValue.length < oldValue.length) {
				totales.value.totalBs -= newValue[0].cost_usd * precioDolar.value;
				totales.value.total$ -= newValue[0].cost_usd;
			} else if (newValue.length >= oldValue.length) {
				totales.value.totalBs += newValue[0].cost_usd * precioDolar.value;
				totales.value.total$ += newValue[0].cost_usd;
			}
		} else {
			totales.value.totalBs = 0;
			totales.value.total$ = 0;
		}
	});

	watch(examenesSeleccionados, (newValue, oldValue) => {
		if (newValue.length) {
			if (newValue.length < oldValue.length) {
				totales.value.totalBs -= newValue[0].cost_usd * precioDolar.value;
				totales.value.total$ -= newValue[0].cost_usd;
			} else if (newValue.length >= oldValue.length) {
				totales.value.totalBs += newValue[0].cost_usd * precioDolar.value;
				totales.value.total$ += newValue[0].cost_usd;
			}
		} else {
			totales.value.totalBs = 0;
			totales.value.total$ = 0;
		}
	});

	watch(pagoEnDivisas, (newValue) => {
		const totales2 = {
			totalBs: 0,
			total$: 0,
		};

		for (const item of examenesSeleccionados.value) {
			totales2.total$ += item.cost_usd;
			totales2.totalBs += item.cost_usd * precioDolar.value;
		}

		if (examenesSeleccionados.value.length) {
			if (pagoEnBs.value) {
				if (newValue) {
					totales2.totalBs -= newValue * precioDolar.value;
					totales2.totalBs -= pagoEnBs.value;
					totales2.total$ -= newValue;
					totales2.total$ -= pagoEnBs.value / precioDolar.value;
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				} else {
					totales2.totalBs -= pagoEnBs.value;
					totales2.total$ -= pagoEnBs.value / precioDolar.value;
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				}
			} else {
				if (newValue) {
					totales2.totalBs -= newValue * precioDolar.value;
					totales2.total$ -= newValue;
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				} else {
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				}
			}
		}
	});

	watch(pagoEnBs, (newValue) => {
		const totales2 = {
			totalBs: 0,
			total$: 0,
		};

		for (const item of examenesSeleccionados.value) {
			totales2.total$ += item.cost_usd;
			totales2.totalBs += item.cost_usd * precioDolar.value;
		}

		if (examenesSeleccionados.value.length) {
			if (pagoEnDivisas.value) {
				if (newValue) {
					totales2.totalBs -= newValue;
					totales2.totalBs -= pagoEnDivisas.value * precioDolar.value;
					totales2.total$ -= pagoEnDivisas.value;
					totales2.total$ -= newValue / precioDolar.value;
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				} else {
					totales2.totalBs -= pagoEnDivisas.value * precioDolar.value;
					totales2.total$ -= pagoEnDivisas.value;
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				}
			} else {
				if (newValue) {
					totales2.totalBs -= newValue;
					totales2.total$ -= newValue / precioDolar.value;
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				} else {
					totales.value.totalBs = totales2.totalBs;
					totales.value.total$ = totales2.total$;
				}
			}
		}
	});

	function obtenerTotales() {
		bs = 0;
		divisas = 0;
		for (const item of examenesSeleccionados.value) {
			divisas += item.cost_usd;
			bs += item.cost_usd * precioDolar.value;
		}
	}

	const saveOrder = async () => {
		obtenerTotales();
		const userHasChanged = JSON.stringify(user.value) !== JSON.stringify(originalUserData.value);
		const examHasChanged =
			JSON.stringify(cost_bs.value) !== JSON.stringify(totales.value.totalBs.toString()) &&
			JSON.stringify(cost_usd.value) !== JSON.stringify(totales.value.total$.toString());
		const orderHasChanged = JSON.stringify(examenesSeleccionados.value) !== JSON.stringify(originalOrdersData.value);
		const paymentsHasChanged = JSON.stringify(paymentData.value) !== JSON.stringify(originalPaymentData.value);
		if (userHasChanged) {
			const userBody: User = {
				idUser: user.value.id,
				ci: user.value.documento,
				firstName: user.value.nombre,
				address: user.value.procedencia,
				age: user.value.edad,
				genre: user.value.genero === "masculino" ? "M" : user.value.genero === "femenino" ? "F" : "",
				lastName: user.value.apellido,
				passport: 0,
			};
			const resp = await usersStore.updateUser(user.value.id, userBody);
			if (examHasChanged) {
				const examsBody: Exam = {
					idUser: user.value.id,
					idExam: examenesSeleccionados.value[0].idExam,
					total_cost_bs: totales.value.totalBs.toString(),
					total_cost_usd: totales.value.total$.toString(),
				};
				const resp = await examsStore.updateExam(examenesSeleccionados.value[0].idExam, examsBody);
				if (orderHasChanged) {
					let orders = [];
					let respIguales = [];
					let respDif = [];
					let respUni = [];
					for (let i = 0; i < originalOrdersData.value.length; i++) {
						const orderData: Partial<Order[]> = await ordersStore.fecthOrderByExamIdAndProfileId(
							originalOrdersData.value[i].idExam,
							originalOrdersData.value[i].idProfile
						);
						orders.push(orderData);
					}
					let resultadosIguales = originalOrdersData.value.filter((originalOrder: { idExam: number; idProfile: number }) =>
						examenesSeleccionados.value.some(
							(examenSeleccionado) =>
								examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
						)
					);
					let resultadosDiferentes = originalOrdersData.value.filter(
						(originalOrder: { idExam: number; idProfile: number }) =>
							!examenesSeleccionados.value.some(
								(examenSeleccionado) =>
									examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
							)
					);
					let resultadosUnicosExamenes = examenesSeleccionados.value.filter(
						(examenSeleccionado) =>
							!originalOrdersData.value.some(
								(originalOrder: { idExam: number; idProfile: number }) => originalOrder.idProfile === examenSeleccionado.idProfile
							)
					);
					for (let i = 0; i < resultadosIguales.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respIguales.push(orderData);
					}
					for (let i = 0; i < resultadosDiferentes.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respDif.push(orderData);
					}
					for (let i = 0; i < resultadosUnicosExamenes.length; i++) {
						respUni.push(resultadosUnicosExamenes[i]);
					}
					for (let i = 0; i < respIguales.length; i++) {
						const orderBody: Order = {
							idOrder: respIguales[i][0].idOrder,
							idExam: respIguales[i][0].idExam,
							idProfile: respIguales[i][0].idProfile,
							status: respIguales[i][0].status,
						};
						const resp = await ordersStore.updateOrder(respIguales[i][0].idOrder, orderBody);
					}
					for (let i = 0; i < respUni.length; i++) {
						const orderBody: Partial<Order> = {
							idExam: respIguales[0][0].idExam,
							idProfile: respUni[i].idProfile,
							status: "Pendiente por pasar",
						};
						await ordersStore.createOrder(orderBody);
					}

					for (let i = 0; i < respDif.length; i++) {
						await ordersStore.deleteOrder(respIguales[i][0].idOrder);
					}
					if (paymentsHasChanged) {
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				} else {
					if (paymentsHasChanged) {
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				}
			} else {
				if (orderHasChanged) {
					let orders = [];
					let respIguales = [];
					let respDif = [];
					let respUni = [];
					for (let i = 0; i < originalOrdersData.value.length; i++) {
						const orderData: Partial<Order[]> = await ordersStore.fecthOrderByExamIdAndProfileId(
							originalOrdersData.value[i].idExam,
							originalOrdersData.value[i].idProfile
						);
						orders.push(orderData);
					}
					let resultadosIguales = originalOrdersData.value.filter((originalOrder: { idExam: number; idProfile: number }) =>
						examenesSeleccionados.value.some(
							(examenSeleccionado) =>
								examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
						)
					);
					let resultadosDiferentes = originalOrdersData.value.filter(
						(originalOrder: { idExam: number; idProfile: number }) =>
							!examenesSeleccionados.value.some(
								(examenSeleccionado) =>
									examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
							)
					);
					let resultadosUnicosExamenes = examenesSeleccionados.value.filter(
						(examenSeleccionado) =>
							!originalOrdersData.value.some(
								(originalOrder: { idExam: number; idProfile: number }) => originalOrder.idProfile === examenSeleccionado.idProfile
							)
					);
					for (let i = 0; i < resultadosIguales.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respIguales.push(orderData);
					}
					for (let i = 0; i < resultadosDiferentes.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respDif.push(orderData);
					}
					for (let i = 0; i < resultadosUnicosExamenes.length; i++) {
						respUni.push(resultadosUnicosExamenes[i]);
					}
					for (let i = 0; i < respIguales.length; i++) {
						const orderBody: Order = {
							idOrder: respIguales[i][0].idOrder,
							idExam: respIguales[i][0].idExam,
							idProfile: respIguales[i][0].idProfile,
							status: respIguales[i][0].status,
						};
						const resp = await ordersStore.updateOrder(respIguales[i][0].idOrder, orderBody);
					}
					for (let i = 0; i < respUni.length; i++) {
						const orderBody: Partial<Order> = {
							idExam: respIguales[0][0].idExam,
							idProfile: respUni[i].idProfile,
							status: "Pendiente por pasar",
						};
						await ordersStore.createOrder(orderBody);
					}

					for (let i = 0; i < respDif.length; i++) {
						await ordersStore.deleteOrder(respIguales[i][0].idOrder);
					}
					if (paymentsHasChanged) {
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				} else {
					if (paymentsHasChanged) {
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				}
			}
		} else {
			if (examHasChanged) {
				const examsBody: Exam = {
					idUser: user.value.id,
					idExam: examenesSeleccionados.value[0].idExam,
					total_cost_bs: totales.value.totalBs.toString(),
					total_cost_usd: totales.value.total$.toString(),
				};
				const resp = await examsStore.updateExam(examenesSeleccionados.value[0].idExam, examsBody);
				if (orderHasChanged) {
					let orders = [];
					let respIguales = [];
					let respDif = [];
					let respUni = [];
					for (let i = 0; i < originalOrdersData.value.length; i++) {
						const orderData: Partial<Order[]> = await ordersStore.fecthOrderByExamIdAndProfileId(
							originalOrdersData.value[i].idExam,
							originalOrdersData.value[i].idProfile
						);
						orders.push(orderData);
					}
					let resultadosIguales = originalOrdersData.value.filter((originalOrder: { idExam: number; idProfile: number }) =>
						examenesSeleccionados.value.some(
							(examenSeleccionado) =>
								examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
						)
					);
					let resultadosDiferentes = originalOrdersData.value.filter(
						(originalOrder: { idExam: number; idProfile: number }) =>
							!examenesSeleccionados.value.some(
								(examenSeleccionado) =>
									examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
							)
					);
					let resultadosUnicosExamenes = examenesSeleccionados.value.filter(
						(examenSeleccionado) =>
							!originalOrdersData.value.some(
								(originalOrder: { idExam: number; idProfile: number }) => originalOrder.idProfile === examenSeleccionado.idProfile
							)
					);
					for (let i = 0; i < resultadosIguales.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respIguales.push(orderData);
					}
					for (let i = 0; i < resultadosDiferentes.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respDif.push(orderData);
					}
					for (let i = 0; i < resultadosUnicosExamenes.length; i++) {
						respUni.push(resultadosUnicosExamenes[i]);
					}
					for (let i = 0; i < respIguales.length; i++) {
						const orderBody: Order = {
							idOrder: respIguales[i][0].idOrder,
							idExam: respIguales[i][0].idExam,
							idProfile: respIguales[i][0].idProfile,
							status: respIguales[i][0].status,
						};
						const resp = await ordersStore.updateOrder(respIguales[i][0].idOrder, orderBody);
					}
					for (let i = 0; i < respUni.length; i++) {
						const orderBody: Partial<Order> = {
							idExam: respIguales[0][0].idExam,
							idProfile: respUni[i].idProfile,
							status: "Pendiente por pasar",
						};
						await ordersStore.createOrder(orderBody);
					}

					for (let i = 0; i < respDif.length; i++) {
						await ordersStore.deleteOrder(respIguales[i][0].idOrder);
					}
					if (paymentsHasChanged) {
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				} else {
					if (paymentsHasChanged) {
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				}
			} else {
				if (orderHasChanged) {
					let orders = [];
					let respIguales = [];
					let respDif = [];
					let respUni = [];
					for (let i = 0; i < originalOrdersData.value.length; i++) {
						const orderData: Partial<Order[]> = await ordersStore.fecthOrderByExamIdAndProfileId(
							originalOrdersData.value[i].idExam,
							originalOrdersData.value[i].idProfile
						);
						orders.push(orderData);
					}
					let resultadosIguales = originalOrdersData.value.filter((originalOrder: { idExam: number; idProfile: number }) =>
						examenesSeleccionados.value.some(
							(examenSeleccionado) =>
								examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
						)
					);
					let resultadosDiferentes = originalOrdersData.value.filter(
						(originalOrder: { idExam: number; idProfile: number }) =>
							!examenesSeleccionados.value.some(
								(examenSeleccionado) =>
									examenSeleccionado.idExam === originalOrder.idExam && examenSeleccionado.idProfile === originalOrder.idProfile
							)
					);
					let resultadosUnicosExamenes = examenesSeleccionados.value.filter(
						(examenSeleccionado) =>
							!originalOrdersData.value.some(
								(originalOrder: { idExam: number; idProfile: number }) => originalOrder.idProfile === examenSeleccionado.idProfile
							)
					);
					for (let i = 0; i < resultadosIguales.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respIguales.push(orderData);
					}
					for (let i = 0; i < resultadosDiferentes.length; i++) {
						const orderData = await ordersStore.fecthOrderByExamIdAndProfileId(
							resultadosIguales[i].idExam,
							resultadosIguales[i].idProfile
						);
						respDif.push(orderData);
					}
					for (let i = 0; i < resultadosUnicosExamenes.length; i++) {
						respUni.push(resultadosUnicosExamenes[i]);
					}
					for (let i = 0; i < respIguales.length; i++) {
						const orderBody: Order = {
							idOrder: respIguales[i][0].idOrder,
							idExam: respIguales[i][0].idExam,
							idProfile: respIguales[i][0].idProfile,
							status: respIguales[i][0].status,
						};
						const resp = await ordersStore.updateOrder(respIguales[i][0].idOrder, orderBody);
					}
					for (let i = 0; i < respUni.length; i++) {
						const orderBody: Partial<Order> = {
							idExam: respIguales[0][0].idExam,
							idProfile: respUni[i].idProfile,
							status: "Pendiente por pasar",
						};
						await ordersStore.createOrder(orderBody);
					}

					for (let i = 0; i < respDif.length; i++) {
						await ordersStore.deleteOrder(respIguales[i][0].idOrder);
					}
					if (paymentsHasChanged) {
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				} else {
					if (paymentsHasChanged) {
						for (let i = 0; i < originalPaymentData.value.length; i++) {
							await paymentsStore.deletePayment(originalPaymentData.value[i].idPayment);
						}
						for (let i = 0; i < metodoPagos.value.length; i++) {
							const paymentBody: Payment = {
								idPayment_method: metodoPagos.value[i].idPayment_method,
								amount_bs: metodoPagos.value[i].montoBolivares,
								amount_usd: metodoPagos.value[i].montoDolares,
								type: metodoPagos.value[i].tipo,
								bank: metodoPagos.value[i].banco,
								idExam: examenesSeleccionados.value[0].idExam,
								phone: metodoPagos.value[i].telefono,
							};
							await paymentsStore.createPayment(paymentBody);
						}

						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					} else {
						const toastElement: any = document.getElementById("liveToast");
						const toastBootstrap = Toast.getOrCreateInstance(toastElement);
						toastBootstrap.show();

						await resetOrderData();

						await ordersStore.fecthOrdersDay();

						await ordersStore.fecthHistOrdersDay();

						router.push({ name: "OrdersView" });
					}
				}
			}
		}
	};

	const abrirModal = () => {
		mostrarModal.value = true;
	};

	const closeModal = () => {
		mostrarModal.value = false;
	};

	const guardarMetodoPago = (metodo: any) => {
		const resp = [];
		metodoPagos.value = metodo;
		for (let i = 0; i < metodoPagos.value.length; i++) {
			resp.push({
				name: metodoPagos.value[i].metodo,
				amount_bs: metodoPagos.value[i].montoBolivares,
				amount_usd: metodoPagos.value[i].montoDolares,
				bank: metodoPagos.value[i].banco,
				phone: metodoPagos.value[i].telefono,
				type: metodoPagos.value[i].tipo,
			});
		}
		paymentData.value = resp;
		closeModal();
	};

	async function resetOrderData() {
		user.value = {
			id: 0,
			documento: "",
			nombre: "",
			apellido: "",
			genero: "",
			edad: 0,
			procedencia: "",
		};
		examenesSeleccionados.value = [];
		metodoPagos.value = [];
		pagoEnDivisas.value = "";
		pagoEnBs.value = "";
		totales.value = {
			totalBs: 0,
			total$: 0,
		};
		precioDolar.value = Number(localStorage.getItem("tasaDolar")) || 50;
	}
</script>

<style scoped>
	@media (width < 576px) {
		ion-content {
			--padding-start: 20px;
			--padding-end: 20px;
		}
	}
	.btn.btn-success.col-2.w-auto.ms-1 {
		background-color: white;
	}
</style>
