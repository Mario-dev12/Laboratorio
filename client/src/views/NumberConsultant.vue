<template>
	<ion-page>
		<ion-content>
			<div class="container mt-3">
				<div class="d-flex justify-content-center mb-3">
					<div class="mx-2" style="flex: 1">
						<label for="startDate">Fecha de Inicio</label>
						<input type="date" id="startDate" v-model="startDate" class="form-control" style="font-size: 1rem" />
					</div>
					<div class="mx-2" style="flex: 1">
						<label for="endDate">Fecha de Fin</label>
						<input type="date" id="endDate" v-model="endDate" class="form-control" style="font-size: 1rem" />
					</div>
					<div class="mx-2 align-self-end">
						<button @click="handleSearch" class="btn btn-primary" style="height: 38px">Buscar</button>
					</div>
				</div>

				<h2 class="text-center mb-4">Balance</h2>

				<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Ingresos</th>
								<th>Egresos</th>
								<th>Balance Total</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="ingresos">+{{ totalBs }} bs (+{{ totalDolares }} $)</td>
								<td class="egresos">-{{ billsTotalBs }} bs (-{{ billsTotalDolares }} $)</td>
								<td :class="{ 'balance-positivo': totalBs >= billsTotalBs, 'balance-negativo': totalBs < billsTotalBs }">
									{{ totalBs - billsTotalBs }} bs ({{ totalDolares - billsTotalDolares }}) $
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="container mt-3">
				<h2 class="text-center mb-4">Lista de Ingresos</h2>

				<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Nombre del Paciente</th>
								<th>Documento Identidad</th>
								<th>Género</th>
								<th>Edad</th>
								<th>Monto Bs</th>
								<th>Monto $</th>
								<th>Exámen</th>
								<th>Método de Pago</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="income in incomes" :key="income.idUser">
								<td>{{ income.firstName }} {{ income.lastName }}</td>
								<td>{{ income.ci ? income.ci : income.passport ? income.passport : "N/A" }}</td>
								<td>{{ income.genre }}</td>
								<td>{{ income.age }}</td>
								<td>{{ income.totalCost_bs }}</td>
								<td>{{ income.totalCost_usd }}</td>
								<td>
									<div v-for="exam in income.exams" :key="exam.idProfile">  
										{{ exam.examName }}
										<div>
											{{ exam.cost_bs }} bs -
											{{ exam.cost_usd }} $
										</div>
									</div> 
								</td>
								<td>
									<div v-for="payment in income.payments" :key="payment.idPaymentMethod">  
										{{ payment.PaymentMethodName }}
										<div>
											{{ payment.type }}
										</div>
										<div v-if="payment.bank">
											Banco {{ payment.bank }}
										</div>
										<div v-if="payment.phone">
											{{ payment.phone }}
										</div>
										{{ payment.amount_bs }} bs -
										{{ payment.amount_usd }} $
										<hr>
									</div> 
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<table class="table table-striped">
					<tfoot>
						<tr>
							<td colspan="10" style="text-align: right; font-weight: bold">Total $:</td>
							<td style="text-align: right; font-weight: bold">{{ totalDolares }} $</td>
						</tr>
						<tr>
							<td colspan="10" style="text-align: right; font-weight: bold">Total Bs:</td>
							<td style="text-align: right; font-weight: bold">{{ totalBs }} Bs</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div class="container mt-3">
				<h2 class="text-center mb-4">Lista de Egresos</h2>

				<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Nombre Reactivo</th>
								<th>Nombre Proveedor</th>
								<th>Cantidad</th>
								<th>Costo Bs</th>
								<th>Costo $</th>
								<th>Pago Completo</th>
								<th>Monto Faltante</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="bill in bills" :key="bill.idProvider">
								<td>{{ bill.reactiveName }}</td>
								<td>{{ bill.providerName }}</td>
								<td>{{ bill.quantity }}</td>
								<td>{{ bill.cost_bs }} bs</td>
								<td>{{ bill.cost_usd }} $</td>
								<td>{{ bill.pay_done ? "Sí" : "No" }}</td>
								<td>{{ bill.pay_amount }}</td>
							</tr>
						</tbody>
					</table>
				</div>
				<table class="table table-striped">
					<tfoot>
						<tr>
							<td colspan="6" style="text-align: right; font-weight: bold">Total $:</td>
							<td style="text-align: right; font-weight: bold">{{ billsTotalDolares }} $</td>
						</tr>
						<tr>
							<td colspan="6" style="text-align: right; font-weight: bold">Total Bs:</td>
							<td style="text-align: right; font-weight: bold">{{ billsTotalBs }} Bs</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div class="container mt-3">
				<h2 class="text-center mb-4">Lista de Pago Pendiente</h2>

				<div class="table-responsive" style="max-height: 400px; overflow-y: auto">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Paciente</th>
								<th>Documento Identidad</th>
								<th>Género</th>
								<th>Edad</th>
								<th>Monto Bs</th>
								<th>Monto $</th>
								<th>Tasa</th>
								<th>Exámen</th>
								<th>Método de Pago</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="income in debt" :key="income.idUser">
								<td>{{ income.firstName }} {{ income.lastName }}</td>
								<td>{{ income.ci ? income.ci : income.passport ? income.passport : "N/A" }}</td>
								<td>{{ income.genre }}</td>
								<td>{{ income.age }}</td>
								<td>{{ Math.floor(parseFloat(income.deuda_bs.toString().replace(',', '.')) * 100) / 100 }}</td>
								<td>{{ Math.floor(parseFloat(income.deuda_dolar.toString().replace(',', '.')) * 100) / 100 }}</td>
								<td>{{ income.tasa }}</td>
								<td>
									<div v-for="exam in income.exams" :key="exam.idProfile">  
										{{ exam.examName }}
										<div>
											{{ exam.cost_bs }} bs -
											{{ exam.cost_usd }} $
										</div>
									</div> 
								</td>
								<td>
									<div v-for="payment in income.payments" :key="payment.idPaymentMethod">  
										{{ payment.PaymentMethodName }}
										<div>
											{{ payment.type }}
										</div>
										<div v-if="payment.bank">
											Banco {{ payment.bank }}
										</div>
										<div v-if="payment.phone">
											{{ payment.phone }}
										</div>
										{{ payment.amount_bs }} bs -
										{{ payment.amount_usd }} $
										<hr>
									</div> 
								</td>
								<td>
									<i class="fas fa-edit" style="cursor: pointer; margin-right: 10px" @click="abrirModal(income)"></i>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<ModalAgregarMetodo
					:isOpen="mostrarModal"
					:totales="totales"
					:precioDolar="precioDolar"
					@update-precio-dolar="cambiarPrecioDolar($event)"
					@close="closeModal"
					@add="guardarMetodoPago" />

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
	import { IonContent, IonPage, IonToast } from "@ionic/vue";
	import { boxStore } from "@/stores/boxStore";
	import { onMounted, ref, watch } from "vue";
	import { useRoute } from "vue-router";
	import ModalAgregarMetodo from "@/components/ModalAgregarMetodo.vue";
	import eventBus from '../eventBus';
	import { Payment } from "@/interfaces/interfaces";
	import { paymentStore } from "@/stores/paymentStore";
	import { checkboxOutline, alertCircleOutline } from "ionicons/icons";

	const incomes = ref();
	const bills = ref();
	const debt = ref(); 
	const totalBs = ref(0);
	const totalDolares = ref(0);
	const billsTotalBs = ref(0);
	const billsTotalDolares = ref(0);
	const boxsStore = boxStore();
	const startDate = ref("");
	const endDate = ref(""); 
	const route = useRoute();  
	const mostrarModal = ref(false);
	const totales = ref({
		totalBs: 0,
		total$: 0,
	});
	const precioDolar = ref(Number(localStorage.getItem("tasaDolar")) || 50);
	const cambioDolar = ref(precioDolar.value);
	const showChangeDolar = ref(false);
	const metodoPagos = ref();
	const totalPagadoDolares = ref();
	const totalPagadoBs = ref();
	const catchDebt = ref();
	const paymentsStore = paymentStore();
	const toast = ref({
		isOpen: false,
		message: "",
		class: "",
		icon: null,
	});
	const isOpen = ref(false);

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
		incomes.value = await boxsStore.fecthIncome(true, "", "");
		bills.value = await boxsStore.fecthBills(true, "", "");
		debt.value = await boxsStore.fecthDebt(true, "", "");
		await totalAmountIncome();
		await totalAmountBills();
	});

	const loadData = async () => {  
		try {  
			incomes.value = await boxsStore.fecthIncome(true, "", "");  
			bills.value = await boxsStore.fecthBills(true, "", ""); 
			debt.value = await boxsStore.fecthDebt(true, "", ""); 
			await totalAmountIncome();  
			await totalAmountBills();  
		} catch (error) {  
			console.error("Error al cargar los datos:", error);  
		}  
	};

	watch(route, (to) => {  
		if (to.name === "Caja") {  
			loadData(); 
		}  
	}); 

	async function totalAmountIncome() {  
		totalBs.value = incomes.value.reduce((acc: number, income: { totalCost_bs: string; }) => acc + parseFloat(income.totalCost_bs), 0);  
		totalDolares.value = incomes.value.reduce((acc: number, income: { totalCost_usd: string; }) => acc + parseFloat(income.totalCost_usd), 0);  
	}  

	async function totalAmountBills() {  
		billsTotalBs.value = bills.value.reduce((acc: number, bill: { cost_bs: string; }) => acc + parseFloat(bill.cost_bs.replace(",", ".")), 0);  
		billsTotalDolares.value = bills.value.reduce((acc: number, bill: { cost_usd: string; }) => acc + parseFloat(bill.cost_usd.replace(",", ".")), 0);  
	}  

	async function handleSearch() {  
		if (new Date(startDate.value) > new Date(endDate.value)) {  
			showToast("La fecha de inicio no puede ser posterior a la fecha de fin.", "warning", alertCircleOutline); 
			return;  
		}  
		try {  
			totalBs.value = 0;  
			totalDolares.value = 0;  
			billsTotalBs.value = 0;  
			billsTotalDolares.value = 0;  

			incomes.value = await boxsStore.fecthIncome(false, startDate.value, endDate.value);  
			bills.value = await boxsStore.fecthBills(false, startDate.value, endDate.value);  

			await totalAmountIncome();  
			await totalAmountBills();  
		} catch (error) {  
			console.error("Error al buscar datos:", error); 
			showToast("Ocurrió un error al buscar los datos.", "warning", alertCircleOutline);  
		}  
	}  

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
			showChangeDolar.value = false;
			eventBus.emit("precioActualizado", precioDolar.value)
		}
	};

	const guardarMetodoPago = async (metodo: any) => {
		metodoPagos.value = metodo;
		totalPagadoDolares.value = 0;
		totalPagadoBs.value = 0;
		for (const payment of metodo) {
			totalPagadoDolares.value += Number(payment.montoDolares);
			totalPagadoBs.value += Number(payment.montoBolivares);
		}
		if (catchDebt.value.deuda_bs.replace('.', ',') !== totalPagadoBs.value.toString().replace('.', ',') && catchDebt.value.deuda_dolar.replace('.', ',') !== totalPagadoDolares.value.toString().replace('.', ',')){
			showToast("El monto ingresado es diferente al monto pendiente. Revise el monto", "warning", alertCircleOutline);
			closeModal();
		} else {
			for (let i = 0; i < metodoPagos.value.length; i++) {
				const paymentBody: Payment = {
					idPayment_method: metodoPagos.value[i].idPayment_method,
					amount_bs: metodoPagos.value[i].montoBolivares,
					amount_usd: metodoPagos.value[i].montoDolares,
					type: metodoPagos.value[i].tipo,
					bank: metodoPagos.value[i].banco,
					idExam: catchDebt.value.exams[0].idExam,
					phone: metodoPagos.value[i].telefono,
				};
				await paymentsStore.createPayment(paymentBody);
			}

			await boxsStore.deleteDebt(catchDebt.value.idDeuda)
			await loadData();
			showToast("Deuda pagada Exitosamente!!", "creado", checkboxOutline);
			closeModal();
		}
	};

	const abrirModal = (income: any) => {
		totales.value.total$ = parseFloat(income.deuda_dolar.replace(",", "."))
		totales.value.totalBs = parseFloat(income.deuda_bs.replace(",", "."))
		precioDolar.value = parseFloat(income.tasa.replace(",", "."))
		catchDebt.value = income
		mostrarModal.value = true;
	};

	const closeModal = () => {
		mostrarModal.value = false;
	};
</script>

<style scoped>
	.ingresos {
		color: green;
	}

	.egresos {
		color: red;
	}

	.balance-positivo {
		color: green;
	}

	.balance-negativo {
		color: red;
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
