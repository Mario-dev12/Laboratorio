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
						<button class="d-block btn btn-primary w-auto mx-auto" @click="cambiarPrecioDolar(cambioDolar)">Cambiar tasa del dolar</button>
					</div>
				</div>
			</div>
			<div class="container mt-2 p-3 bg-dark-subtle rounded">  
				<div class="w-100 m-auto row px-2">  
				  <label class="col-12 p-0" for="documento">Documento de identidad</label>  
				  <div class="col-12 p-0">  
					<div class="row w-100 m-auto pe-1 justify-content-between">  
					  <input class="col-10" type="text" placeholder="Documento de identidad" v-model="user.documento" />  
					  <button class="btn btn-success col-2 w-auto ms-1" @click="searchClient">🔎</button>  
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
				<div class="row w-100 m-auto">  
				  <div class="col-12 mb-2">  
					<div class="row w-100 m-auto">  
					  <label class="col-12 p-0" for="diagnostico">Motivo/Diagnóstico:</label>  
					  <textarea class="col-12" v-model="user.diagnostico" cols="50"></textarea>  
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
						<button class="btn btn-primary mt-3" @click="abrirModal">Agregar método de pago del paciente</button>  
					</div>  
				</div>  
				<ModalAgregarMetodo   
					:isOpen="mostrarModal"  
					:totales="totales" 
					:precioDolar="precioDolar"
					@update-precio-dolar="cambiarPrecioDolar($event)"
					@close="closeModal"   
					@add="guardarMetodoPago"  
				/> 
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
				<div v-if="metodoPagos && metodoPagos.length > 0" class="mt-3">  
					<div class="row w-100 m-auto mt-3">  
						<div class="col">Métodos de Pago</div>  
					</div>  
					
					<div v-for="(metodo, index) in metodoPagos" :key="index" class="row w-100 m-auto mb-1">  
						<div class="col">{{ metodo.metodo }}</div>  
						<div class="col">Monto: Bs {{ metodo.montoBolivares !== undefined ? metodo.montoBolivares : 'N/A' }}</div>  
						<div class="col">Divisa: {{ metodo.montoDolares }}</div>  
						<div class="col" v-if="metodo.banco">Banco: {{ metodo.banco }}</div>  
						<div class="col" v-if="metodo.telefono">Teléfono: {{ metodo.telefono }}</div> 
					</div>   
				</div>  
			</div>
			<div class="row w-100 m-auto justify-content-center mb-4">
				<button class="btn btn-primary w-auto" @click="saveOrder">Guardar Orden</button>
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
	import { User, Exam, Profile, Order, Payment } from "@/interfaces/interfaces";
	import { Toast } from "bootstrap";
	import ModalAgregarMetodo from '@/components/ModalAgregarMetodo.vue'
	import { examStore } from "@/stores/examStore";
	import { profileStore } from "@/stores/profileStore"
	import { orderStore } from "@/stores/orderStore";
	import { paymentStore } from "@/stores/paymentStore"
	import { useRouter } from 'vue-router';

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
	const users = userStore();
	const metodoPagos = ref();
	let bs: number = 0;
	let divisas: number = 0;
	const showChangeDolar = ref(false);
	const mostrarModal = ref(false);
	const profiles = ref();
	const examsStore = examStore();
	const ordersStore = orderStore();
	const profilesStore = profileStore();
	const paymentsStore = paymentStore();
	const router = useRouter(); 
	const user = ref({  
		id: 0,
        documento: '',  
        nombre: '',  
        apellido: '',  
        genero: '',  
        edad: 0,  
        procedencia: '',  
        diagnostico: ''  
    })

	const totales = ref({
		totalBs: 0,
		total$: 0,
	});

	onMounted(async () => {
		profiles.value = await profilesStore.fecthProfiles();
		profiles.value = profiles.value.map((exam: { cost_bs: string; cost_usd: string; }) => ({  
			...exam, 
			cost_bs: parseFloat(exam.cost_bs.replace(',', '.')),
			cost_usd: parseFloat(exam.cost_usd)
		}));
	});

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
			} else {
				const clientToast: any = document.getElementById("searchClientToast");
				const toastBootstrap = Toast.getOrCreateInstance(clientToast);
				toastBootstrap.show();
			}
		} else {
			alert("Ingrese documento de identidad");
		}
	};

	const cambiarPrecioDolar = (nuevoPrecio: any) => {  
		const newPrice = Number(nuevoPrecio)
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

	const agregarExamen = () => {
		for (const item of profiles.value) {
			const itemInArray = examenesSeleccionados.value.find((element) => element.name === item.name);
			if (item.name === tipoDeExamen.value && !itemInArray) {
				examenesSeleccionados.value.push(item);
				examenesSeleccionados.value = [...examenesSeleccionados.value];
				pagoEnBs.value = "";
				pagoEnDivisas.value = "";
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
			return item.name !== examen;
		});
	}

	watch(precioDolar, () => {  
		actualizarCostosEnBs();
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
		if (user.value.id === 0){
			let respUser: number | undefined = 0;
			let respExam: number | undefined = 0;
			const body: User = {
				idUser: user.value.id,
				passport: null,
				ci: user.value.documento,
				firstName: user.value.nombre,
				lastName: user.value.apellido,
				genre: user.value.genero === 'masculino' ? 'M' : (user.value.genero === 'femenino' ? 'F' : ''),
				age: user.value.edad,
				address: user.value.procedencia
			}
			const resp = await users.createUser(body);
			respUser = resp[0].id;
			if (respUser){
				const examsBody: Exam = {
					idUser: respUser,
					total_cost_bs: totales.value.totalBs.toString(),
					total_cost_usd: totales.value.total$.toString()
				}
				const examResp = await examsStore.createExam(examsBody);
				respExam = examResp.id;
				if (respExam){
					for(let i = 0; i < examenesSeleccionados.value.length; i++){
						const orderBody: Order = {
							idExam: respExam,
							idProfile: examenesSeleccionados.value[i].idProfile
						}
						await ordersStore.createOrder(orderBody)
					}
					for (let i = 0; i < metodoPagos.value.length; i++){
						const paymentBody: Payment = {
							idPayment_method: metodoPagos.value[i].idPayment_method,
							amount_bs: metodoPagos.value[i].montoBolivares,
							amount_usd: metodoPagos.value[i].montoDolares,
							type: metodoPagos.value[i].tipo,
							bank: metodoPagos.value[i].banco,
							idExam: respExam,
							phone: metodoPagos.value[i].telefono
						}
						await paymentsStore.createPayment(paymentBody)
					}
				}
			}
			const toastElement: any = document.getElementById("liveToast");
			const toastBootstrap = Toast.getOrCreateInstance(toastElement);
			toastBootstrap.show();

			router.push({ name: "CrearOrden" }); 
		} else {
			let respExam: number | undefined = 0;
			const examsBody: Exam = {
				idUser: user.value.id,
				total_cost_bs: totales.value.totalBs.toString(),
				total_cost_usd: totales.value.total$.toString()
			}
			const examResp = await examsStore.createExam(examsBody);
			respExam = examResp.id;
			if (respExam){
				for(let i = 0; i < examenesSeleccionados.value.length; i++){
					const orderBody: Order = {
						idExam: respExam,
						idProfile: examenesSeleccionados.value[i].idProfile
					}
					await ordersStore.createOrder(orderBody)
				}
				for (let i = 0; i < metodoPagos.value.length; i++){
					const paymentBody: Payment = {
						idPayment_method: metodoPagos.value[i].idPayment_method,
						amount_bs: metodoPagos.value[i].montoBolivares,
						amount_usd: metodoPagos.value[i].montoDolares,
						type: metodoPagos.value[i].tipo,
						bank: metodoPagos.value[i].banco,
						idExam: respExam,
						phone: metodoPagos.value[i].telefono
					}
					await paymentsStore.createPayment(paymentBody)
				}
			}
			const toastElement: any = document.getElementById("liveToast");
			const toastBootstrap = Toast.getOrCreateInstance(toastElement);
			toastBootstrap.show();

			router.push({ name: "CrearOrden" }); 
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
		closeModal();
	};
</script>

<style scoped>
	@media (width < 576px) {
		ion-content {
			--padding-start: 20px;
			--padding-end: 20px;
		}
	}
	.btn.btn-success.col-2.w-auto.ms-1{
		background-color: white;
	}
</style>
