<template>
	<ion-page>
		<ion-content>
			<div class="container mt-4 p-3 bg-dark-subtle rounded">
				<h3 class="mb-3">Información Del Cliente</h3>
				<div class="w-100 m-auto row px-2">
					<label class="col-12 p-0" for="documento">Documento de identidad</label>
					<div class="col-12 p-0">
						<div class="row w-100 m-auto pe-1 justify-content-between">
							<input class="col-10" type="text" placeholder="Documento de identidad" v-model="user.documento" />
							<button class="btn btn-primary col-2 w-auto ms-1" @click="searchClient">
								<i class="fas fa-search" style="color: white"></i>
							</button>
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
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="Email">Correo Electrónico</label>
							<input class="col w-auto" type="text" placeholder="Email" v-model="user.email" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="teléfono">Numero Telefónico</label>
							<input class="col w-auto" type="text" placeholder="Ingrese Numero Telefónico" v-model="user.phone" />
						</div>
					</div>
					<div class="col-12 mb-2">
						<div class="row w-100 m-auto">
							<label class="col align-content-center p-0" for="Doctor">Doctor</label>
							<input class="col w-auto" type="text" placeholder="Doctor" v-model="user.doctor" />
						</div>
					</div>
				</div>
			</div>
			<div class="bg-dark-subtle container p-3 rounded mt-3">
				<div class="row w-100 m-auto">
					<div class="col-12 d-flex justify-content-between align-items-center">
						<h3 class="mb-3">Exámenes</h3>
						<div class="text-end">
							<h4>Tasa del Dolar</h4>
							<div class="d-flex align-items-center pb-2">
								<h4 v-if="!showChangeDolar" class="text-success mb-0 fw-bold">Bs: {{ precioDolar }}</h4>
								<input
									v-if="showChangeDolar"
									v-model.number="precioDolar"
									type="number"
									placeholder="Nuevo monto"
									@keyup.enter="cambiarPrecioDolar(precioDolar)"
									class="ms-2" />

								<i
									class="fas fa-edit ms-2 text-dark"
									@click="showChangeDolar = !showChangeDolar"
									title="Editar tasa del dólar"
									style="cursor: pointer"></i>

								<i
									v-if="showChangeDolar"
									class="fas fa-check accept-icon"
									@click="cambiarPrecioDolar(precioDolar)"
									style="cursor: pointer; margin-left: 10px"></i>

								<i
									v-if="showChangeDolar"
									class="fas fa-times reject-icon"
									@click="cancelarEdicion"
									style="cursor: pointer; margin-left: 10px"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="row w-100 m-auto">
				<div class="col-12">
					<div class="row w-100 m-auto">
						<label class="col align-content-center p-0" for="filterInput">Tipo de Examen:</label>
						<div class="col p-1" style="position: relative;">
							<input
							id="filterInput"
							type="text"
							class="form-control"
							v-model="filterText"
							@focus="showDropdown = true"
							@input="showDropdown = true"
							placeholder="Seleccionar"
							autocomplete="off"
							/>
							<button v-if="tipoDeExamen" @click="clearSelection" class="clear-button">x</button>

							<ul
							v-if="showDropdown && (filteredProfiles.length > 0 || filterText)"
							class="dropdown-list"
							ref="dropdown"
							>
							<li
								v-for="profile in filteredProfiles"
								:key="profile.idProfile"
								@click="selectProfile(profile)"
								@mousedown.prevent
							>
								{{ profile.name }}
							</li>
							<li
								v-if="filterText && filteredProfiles.length === 0"
								class="no-results"
							>
								No hay perfiles con ese nombre
							</li>
							<li
								v-if="tipoDeExamen && filteredProfiles.length === 0 && !filterText"
								@click="clearSelection"
								@mousedown.prevent
								class="clear-option"
							>
								Clear Selection
							</li>
							</ul>

							<ul
							v-else-if="showDropdown && !filterText && profiles.length === 0"
							class="dropdown-list"
							>
							<li class="no-results">No hay perfiles con ese nombre</li>
							</ul>
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
										<td>Bs: {{ (value.cost_usd * precioDolar).toFixed(2) }}</td>
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
				<ModalAgregarMetodo
					:isOpen="mostrarModal"
					:totales="totales"
					:precioDolar="precioDolar"
					@update-precio-dolar="cambiarPrecioDolar($event)"
					@close="closeModal"
					@add="guardarMetodoPago" />
			</div>
			<div class="factura container mt-3 mb-4 bg-dark-subtle rounded p-3">
				<h3 class="mb-3">Factura</h3>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Numero de orden</div>
					<div class="col">{{ numeroOrden }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Fecha</div>
					<div class="col">{{ `${day}/${month}/${year}` }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Total En Bs</div>
					<div class="col">Bs: {{ totales.totalBs.toFixed(2) }}</div>
				</div>
				<div class="row w-100 m-auto mb-1">
					<div class="col">Total En $</div>
					<div class="col">$: {{ totales.total$ }}</div>
				</div>
				<div v-if="debe.total$ > 0" class="row w-100 m-auto mb-1">
					<div class="col">Debe En $</div>
					<div class="col">$: {{ debe.total$.toFixed(2) }}</div>
				</div>
				<div v-if="debe.totalBs > 0" class="row w-100 m-auto mb-1">
					<div class="col">Debe En Bs</div>
					<div class="col">Bs: {{ debe.totalBs.toFixed(2) }}</div>
				</div>
				<div v-if="metodoPagos && metodoPagos.length > 0" class="mt-3">
					<div class="row w-100 m-auto mt-4">
						<h5 class="col">Métodos de Pago</h5>
					</div>

					<div v-for="(metodo, index) in metodoPagos" :key="index" class="row w-100 m-auto mb-1">
						<div class="col">{{ metodo.metodo }}</div>
						<div class="col">Monto: Bs {{ metodo.montoBolivares !== undefined ? metodo.montoBolivares : "N/A" }}</div>
						<div class="col">Divisa: {{ metodo.montoDolares }}</div>
						<div class="col" v-if="metodo.banco">Banco: {{ metodo.banco }}</div>
						<div class="col" v-if="metodo.telefono">Teléfono: {{ metodo.telefono }}</div>
					</div>
				</div>
			</div>
			<div class="row w-100 m-auto justify-content-center mb-4">
				<button class="btn btn-primary w-auto" @click="saveOrder">Guardar Orden</button>
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
	import { ref, watch, onMounted, computed, onBeforeUnmount } from "vue";
	import { IonContent, IonPage, IonToast } from "@ionic/vue";
	import { userStore } from "@/stores/userStore";
	import { User, Exam, Order, Payment, Profile } from "@/interfaces/interfaces";
	import ModalAgregarMetodo from "@/components/ModalAgregarMetodo.vue";
	import { examStore } from "@/stores/examStore";
	import { profileStore } from "@/stores/profileStore";
	import { boxStore } from "@/stores/boxStore";
	import { orderStore } from "@/stores/orderStore";
	import { paymentStore } from "@/stores/paymentStore";
	import { useRouter } from "vue-router";
	import { checkboxOutline, alertCircleOutline } from "ionicons/icons";
	import eventBus from "../eventBus";

	const tipoDeExamen = ref();
	const examenesSeleccionados = ref<Examen[]>([]);
	const today = new Date();
	const day = today.getUTCDate();
	const month = today.getUTCMonth() + 1;
	const year = today.getFullYear();
	const precioDolar = ref(Number(localStorage.getItem("tasaDolar")) || 50);
	const cambioDolar = ref(precioDolar.value);
	const users = userStore();
	const metodoPagos = ref();
	const showChangeDolar = ref(false);
	const mostrarModal = ref(false);
	const profiles = ref();
	const order = ref();
	const numeroOrden = ref<number>(0);
	const examsStore = examStore();
	const boxsStore = boxStore();
	const ordersStore = orderStore();
	const profilesStore = profileStore();
	const paymentsStore = paymentStore();
	const router = useRouter();
	const isOpen = ref(false);
	const totalPagadoDolares = ref();
	const totalPagadoBs = ref();
	const nuevoMontoDolar = ref<number | null>(null);
	const filterText = ref("");
	const showDropdown = ref(false);
	const debe = ref({
		totalBs: 0,
		total$: 0,
	});

	const removeAccents = (str: string): string => {
		if (!str) return "";
		return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
	}

	const filteredProfiles = computed(() => {
		if (!filterText.value) {
			return profiles.value;
		}

		const normalizedFilter = removeAccents(filterText.value.toLowerCase());

		return profiles.value.filter((profile: { name: string; }) => {
			const normalizedProfileName = removeAccents(profile.name.toLowerCase());
			return normalizedProfileName.includes(normalizedFilter);
		});
	});

	function selectProfile(profile: Profile) {
		tipoDeExamen.value = profile.name;
		filterText.value = profile.name;
		showDropdown.value = false;
		agregarExamen();
		const inputElement = document.getElementById("filterInput") as HTMLInputElement;
		if (inputElement) {
			inputElement.blur();
		}
		filterText.value = "";
	}

	function clearSelection() {
		tipoDeExamen.value = "";
		filterText.value = "";
		agregarExamen();
	}

	const closeDropdown = (event: MouseEvent) => {
		const dropdown = document.querySelector('.dropdown-list');
		if (showDropdown.value && dropdown && !dropdown.contains(event.target as Node)) {
			showDropdown.value = false;
		}
	};

	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
	});

	const user = ref({
		id: 0,
		documento: "",
		nombre: "",
		apellido: "",
		genero: "",
		edad: 0,
		procedencia: "",
		diagnostico: "",
		email: "",
		phone: "",
		doctor: "",
	});

	const totales = ref({
		totalBs: 0,
		total$: 0,
	});

	const totalesRestantes = ref({
		totalBs: 0,
		total$: 0,
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

	function handlePrecioActualizado(nuevoPrecio: number) {
		precioDolar.value = nuevoPrecio;
	}

	router.beforeEach(async (to, from, next) => {
		examenesSeleccionados.value = [];
		profiles.value = await profilesStore.fecthAllProfiles();
		profiles.value = profiles.value.map((exam: { cost_bs: string; cost_usd: string }) => ({
			...exam,
			cost_bs: parseFloat(exam.cost_bs.replace(",", ".")),
			cost_usd: parseFloat(exam.cost_usd),
		}));
		precioDolar.value = Number(localStorage.getItem("tasaDolar")) || 50;
		eventBus.on("precioActualizado", handlePrecioActualizado);
		crearOrden();
		await resetOrderData();
		user.value.phone = '+58'
		window.addEventListener('mousedown', closeDropdown);
		next();
	})

	onMounted(async () => {
		profiles.value = await profilesStore.fecthAllProfiles();
		profiles.value = profiles.value.map((exam: { cost_bs: string; cost_usd: string }) => ({
			...exam,
			cost_bs: parseFloat(exam.cost_bs.replace(",", ".")),
			cost_usd: parseFloat(exam.cost_usd),
		}));
		precioDolar.value = Number(localStorage.getItem("tasaDolar")) || 50;
		eventBus.on("precioActualizado", handlePrecioActualizado);
		crearOrden();
		await resetOrderData();
		user.value.phone = '+58'
		window.addEventListener('mousedown', closeDropdown);
	});

	onBeforeUnmount(() => {
		window.removeEventListener('mousedown', closeDropdown);
	});

	watch(precioDolar, (newVal) => {
		localStorage.setItem("tasaDolar", newVal.toString());
	});

	const crearOrden = async () => {
		order.value = await ordersStore.fecthOrders();
		const fechaHoy = new Date();
		const hoyString = fechaHoy.toISOString().split("T")[0];

		const ordenesHoy = order.value.filter((orden: { createdDate: string | number | Date }) => {
			const fechaOrden = new Date(orden.createdDate);
			const ordenString = fechaOrden.toISOString().split("T")[0];
			return ordenString === hoyString;
		});

		numeroOrden.value = ordenesHoy.length + 1;
	};

	interface Examen {
		name: string;
		cost_usd: number;
		cost_bs: number;
		idExam: number;
		idProfile: number;
	}

	const searchClient = async () => {
		if (user.value.documento) {
			const currentClient: User[] = await users.fecthUserById(user.value.documento);
			if (currentClient.length) {
				user.value.id = currentClient[0].idUser;
				user.value.nombre = currentClient[0].firstName;
				user.value.apellido = currentClient[0].lastName;
				user.value.genero = currentClient[0].genre === "M" ? "masculino" : "femenino";
				user.value.edad = currentClient[0].age;
				user.value.procedencia = currentClient[0].address;
				user.value.email = currentClient[0].email;
				user.value.phone = currentClient[0].phone;
				user.value.doctor = currentClient[0].doctor;
			} else {
				showToast("No Se Encontro Cliente Con Ese Documento De Identidad", "warning", alertCircleOutline);
			}
		} else {
			showToast("Ingrese documento de identidad", "warning", alertCircleOutline);
		}
	};

	const cambiarPrecioDolar = (nuevoPrecio: any) => {
		const newPrice = Number(nuevoPrecio);
		if (isNaN(nuevoPrecio) || nuevoPrecio === "") {
			showToast("Ingrese un valor válido", "warning", alertCircleOutline);
		} else {
			precioDolar.value = newPrice;
			cambioDolar.value = newPrice;
			localStorage.setItem("tasaDolar", newPrice.toString());
			totales.value.total$ = 0;
			totales.value.totalBs = 0;
			for (const item of examenesSeleccionados.value) {
				totales.value.totalBs += parseFloat((item.cost_usd * precioDolar.value).toFixed(2));
				totales.value.total$ += item.cost_usd;
			}
			showChangeDolar.value = false;
			eventBus.emit("precioActualizado", precioDolar.value);
		}
	};

	const agregarExamen = () => {
		for (const item of profiles.value) {
			const itemInArray = examenesSeleccionados.value.find((element) => element.name === item.name);
			if (item.name === tipoDeExamen.value && !itemInArray) {
				examenesSeleccionados.value.push(item);
				examenesSeleccionados.value = [...examenesSeleccionados.value];
				totales.value.totalBs += parseFloat((item.cost_usd * precioDolar.value).toFixed(2));
				totales.value.total$ += item.cost_usd;
			}
		}

		tipoDeExamen.value = "";
	};

	const actualizarCostosEnBs = () => {
		examenesSeleccionados.value.forEach((examen) => {
			examen.cost_bs = examen.cost_usd * precioDolar.value;
		});
	};

	function eliminarExamen(examen: string) {
		examenesSeleccionados.value = examenesSeleccionados.value.filter((item) => {
			if (item.name === examen) {
				totales.value.totalBs -= parseFloat((item.cost_usd * precioDolar.value).toFixed(2));
				totales.value.total$ -= item.cost_usd;
			}
			return item.name !== examen;
		});
	}

	watch(precioDolar, () => {
		actualizarCostosEnBs();
	});

	watch(examenesSeleccionados, async () => {
		profiles.value = await profilesStore.fecthAllProfiles();
		profiles.value = profiles.value.map((exam: { cost_bs: string; cost_usd: string }) => ({
			...exam,
			cost_bs: parseFloat(exam.cost_bs.replace(",", ".")),
			cost_usd: parseFloat(exam.cost_usd),
		}));
	});

	const saveOrder = async () => {
		if (
			!user.value.documento ||
			!user.value.nombre ||
			!user.value.apellido ||
			!user.value.genero ||
			!user.value.edad ||
			!user.value.procedencia ||
			!user.value.email ||
			!user.value.phone
		) {
			showToast("Por Favor Completar Datos Del Cliente", "warning", alertCircleOutline);
		} else {
			if (!examenesSeleccionados.value.length) {
				showToast("Por Favor Agregar Examenes A Realizar", "warning", checkboxOutline);
			} else {
				if (user.value.id === 0) {
					let respUser: number | undefined = 0;
					let respExam: number | undefined = 0;
					const body: User = {
						idUser: user.value.id,
						passport: null,
						ci: user.value.documento.trim(),
						firstName: user.value.nombre,
						lastName: user.value.apellido,
						genre: user.value.genero === "masculino" ? "M" : user.value.genero === "femenino" ? "F" : "",
						age: user.value.edad,
						address: user.value.procedencia,
						email: user.value.email,
						phone: user.value.phone,
						doctor: user.value.doctor,
					};
					const resp = await users.createUser(body);
					respUser = resp[resp.length - 1].id;
					if (respUser) {
						const examsBody: Exam = {
							idUser: respUser,
							total_cost_bs: totales.value.totalBs.toFixed(2),
							total_cost_usd: totales.value.total$.toString(),
						};
						const examResp = await examsStore.createExam(examsBody);
						respExam = examResp.id;
						if (respExam) {
							for (let i = 0; i < examenesSeleccionados.value.length; i++) {
								const orderBody: Partial<Order> = {
									idExam: respExam,
									idProfile: examenesSeleccionados.value[i].idProfile,
									status: "Pendiente por pasar",
								};
								await ordersStore.createOrder(orderBody);
							}
							if (metodoPagos.value != undefined || metodoPagos.value != null) {
								for (let i = 0; i < metodoPagos.value.length; i++) {
									const paymentBody: Payment = {
										idPayment_method: metodoPagos.value[i].idPayment_method,
										amount_bs: metodoPagos.value[i].montoBolivares,
										amount_usd: metodoPagos.value[i].montoDolares,
										type: metodoPagos.value[i].tipo,
										bank: metodoPagos.value[i].banco,
										idExam: respExam,
										phone: metodoPagos.value[i].telefono,
									};
									await paymentsStore.createPayment(paymentBody);
								}
							} else {
								totalesRestantes.value.total$ = totales.value.total$;
								totalesRestantes.value.totalBs = totales.value.totalBs;
							}

							if (totalesRestantes.value.total$ !== 0 && totalesRestantes.value.totalBs !== 0) {
								const data = {
									idExam: respExam,
									deuda_bs: totalesRestantes.value.totalBs,
									deuda_dolar: totalesRestantes.value.total$,
									tasa: precioDolar.value,
								};
								await boxsStore.createDebt(data);
							}
						}
					}
					showToast("Orden Creada Exitosamente!!", "creado", checkboxOutline);
					crearOrden();
					await resetOrderData();
					resp.length = 0
					user.value.phone = '+58'
					router.push({ name: "CrearOrden" });
				} else {
					let respExam: number | undefined = 0;
					const examsBody: Exam = {
						idUser: user.value.id,
						total_cost_bs: totales.value.totalBs.toFixed(2),
						total_cost_usd: totales.value.total$.toString(),
					};
					const examResp = await examsStore.createExam(examsBody);
					respExam = examResp.id;
					if (respExam) {
						for (let i = 0; i < examenesSeleccionados.value.length; i++) {
							const orderBody: Partial<Order> = {
								idExam: respExam,
								idProfile: examenesSeleccionados.value[i].idProfile,
								status: "Pendiente por pasar",
							};
							await ordersStore.createOrder(orderBody);
						}
						if (metodoPagos.value != undefined || metodoPagos.value != null) {
							for (let i = 0; i < metodoPagos.value.length; i++) {
								const paymentBody: Payment = {
									idPayment_method: metodoPagos.value[i].idPayment_method,
									amount_bs: metodoPagos.value[i].montoBolivares,
									amount_usd: metodoPagos.value[i].montoDolares,
									type: metodoPagos.value[i].tipo,
									bank: metodoPagos.value[i].banco,
									idExam: respExam,
									phone: metodoPagos.value[i].telefono,
								};
								await paymentsStore.createPayment(paymentBody);
							}
						} else {
							totalesRestantes.value.total$ = totales.value.total$;
							totalesRestantes.value.totalBs = totales.value.totalBs;
						}

						if (totalesRestantes.value.total$ !== 0 && totalesRestantes.value.totalBs !== 0) {
							const data = {
								idExam: respExam,
								deuda_bs: totalesRestantes.value.totalBs,
								deuda_dolar: totalesRestantes.value.total$,
								tasa: precioDolar,
							};
							await boxsStore.createDebt(data);
						}
					}
					showToast("Orden Creada Exitosamente!!", "creado", checkboxOutline);
					crearOrden();
					await resetOrderData();
					router.push({ name: "CrearOrden" });
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
		metodoPagos.value = metodo;
		totalPagadoDolares.value = 0;
		totalPagadoBs.value = 0;
		for (const payment of metodo) {
			totalPagadoDolares.value += Number(payment.montoDolares);
			totalPagadoBs.value += Number(payment.montoBolivares);
		}
		if (!(totales.value.total$ === totalPagadoDolares.value) && !(totales.value.totalBs === totalPagadoBs.value)) {
			totalesRestantes.value.total$ = totales.value.total$ - totalPagadoDolares.value;
			totalesRestantes.value.totalBs = totales.value.totalBs - totalPagadoBs.value;
			debe.value.total$ = totales.value.total$ - totalPagadoDolares.value;
			debe.value.totalBs = totales.value.totalBs - totalPagadoBs.value;
		}

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
			diagnostico: "",
			email: "",
			phone: "",
			doctor: "",
		};
		examenesSeleccionados.value = [];
		metodoPagos.value = [];
		totales.value = {
			totalBs: 0,
			total$: 0,
		};
		precioDolar.value = Number(localStorage.getItem("tasaDolar")) || 50;
		debe.value = {
			totalBs: 0,
			total$: 0,
		};
	}

	const cancelarEdicion = () => {
		showChangeDolar.value = false;
		precioDolar.value = Number(localStorage.getItem("tasaDolar"));
		nuevoMontoDolar.value = null;
	};
</script>

<style scoped>
	@media (width < 576px) {
		ion-content {
			--padding-start: 20px;
			--padding-end: 20px;
		}
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

	.dropdown-list {
		position: absolute;
		top: 100%;
		left: 0;
		right: 0;
		z-index: 1000;
		border: 1px solid #ccc;
		background-color: white;
		list-style: none;
		padding: 0;
		margin: 0;
		max-height: 300px;
		overflow-y: auto;
		box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
		border-radius: 4px;
	}

	.dropdown-list li {
		padding: 8px 12px;
		cursor: pointer;
	}

	.dropdown-list li:hover {
		background-color: #f0f0f0;
	}

	.no-results,
	.clear-option {
		font-style: italic;
		color: #666;
		padding: 8px 12px;
	}
	.clear-option {
		cursor: pointer;
		text-decoration: underline;
	}

	.form-control {
		display: block;
		width: 100%;
		padding: 0.375rem 0.75rem;
		font-size: 1rem;
		line-height: 1.5;
		color: #495057;
		background-color: #fff;
		background-clip: padding-box;
		border: 1px solid #ced4da;
		border-radius: 0.25rem;
		transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
	}

	.clear-button {
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		background: none;
		border: none;
		cursor: pointer;
		font-weight: bold;
		color: #999;
		padding: 0 5px;
		z-index: 1001;
	}
</style>
