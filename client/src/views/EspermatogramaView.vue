<template>
	<ion-page>
		<ion-content>
			<div class="container espermatogramaPDF">
				<div class="info" ref="headerPatientInfo">
					<div class="header">
						<div class="row">
							<div class="col text-center">
								<img src="/images/laboratorio.png" alt="" />
							</div>
							<div class="col text-center">
								<img src="/images/direccion.png" alt="" />
							</div>
						</div>
					</div>
					<div class="patient-info">
						<div class="border-bottom border-black mt-1"></div>
						<div class="row mt-2">
							<div class="col">
								<div class="d-inline fw-bold">Paciente:</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">CI:</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Edad:</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Sexo:</div>
							</div>
							<div class="col">
								<div class="d-inline fw-bold">Fecha:</div>
							</div>
						</div>
					</div>
				</div>
				<div class="espermatograma mt-5">
					<h2 class="text-center">Espermatograma</h2>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Volumen:</div>
						<div class="col-3 border border-black"></div>
						<div class="col-4 border border-black">Hora de Recollección:</div>
						<div class="col-2 border border-black"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Contaje:</div>
						<div class="col-3 border border-black"></div>
						<div class="col-4 border border-black">Densidad:</div>
						<div class="col-2 border border-black"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">Liquefacción:</div>
						<div class="col-3 border border-black"></div>
						<div class="col-4 border border-black">Abstinencia:</div>
						<div class="col-2 border border-black"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-3 border border-black">PH:</div>
						<div class="col-3 border border-black"></div>
						<div class="col-4 border border-black">Color:</div>
						<div class="col-2 border border-black"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black">Aspecto Microscópico:</div>
						<div class="col-8 border border-black"></div>
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
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
						<div class="col border border-black text-center"><input class="w-100 border-0" type="text" /></div>
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
						<div class="col-4 border border-black text-center">60%</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Tapering</div>
						<div class="col-4 border border-black text-center">25%</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Microcefalos</div>
						<div class="col-4 border border-black text-center">8%</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Macrocefalo</div>
						<div class="col-4 border border-black text-center">7%</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Observaciones</div>
						<div class="col-4 border border-black text-center">Leucocitos:</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Hematies:</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Celulas EPI:</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Bacterias:</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Mucina:</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center"></div>
						<div class="col-4 border border-black text-center">Cristales</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
				</div>
				<div class="eosina mb-5">
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center fw-bold">Test De Eosina</div>
						<div class="col-4 border border-black text-center fw-bold">Resultado</div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Vivos Moviles</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Vivos Inmobiles</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
					<div class="row px-2 w-100 m-auto">
						<div class="col-4 border border-black text-center">Muertos</div>
						<div class="col-4 border border-black text-center"></div>
					</div>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup lang="ts">
	import { IonPage, IonContent } from "@ionic/vue";
</script>

<style scoped></style>
