<template>
    <ion-modal :is-open="isOpen" @did-dismiss="closeModal">
      <ion-header>
        <ion-toolbar>
          <ion-title>Editar Alianza</ion-title>
          <ion-buttons slot="end">
            <ion-button @click="closeModal">Cerrar</ion-button>
          </ion-buttons>
        </ion-toolbar>
      </ion-header>

		<ion-content>
			<form @submit.prevent="submit">
				<div class="form-group">
					<label class="form-label">Cantidad</label>
					<input
						v-model.number="form.quantity"
						type="number"
						required
						class="form-control custom-input"
						placeholder="Ingrese la cantidad" />
				</div>
				<div class="form-group">
					<label for="paymentStatus" class="form-label">Pago realizado</label>
					<div>
						<input type="radio" id="paymentYes" :value="true" v-model="form.pay_done" class="radio-input" />
						<label class="radio-label" for="paymentYes">Sí</label>

          <div class="form-group">
            <label for="examSelect" class="form-label">Reactivo</label>
            <select v-model="form.idReactive" required class="form-select custom-input">
              <option value="" disabled>Selecciona un reactivo</option>
              <option v-for="reactives in reactive" :key="reactives.idReactive" :value="reactives.idReactive">{{ reactives.name }}</option>
            </select>
          </div>
          <div class="form-group">
            <label for="examSelect" class="form-label">Proveedor</label>
            <select v-model="form.idProvider" required class="form-select custom-input">
              <option value="" disabled>Selecciona un proveedor</option>
              <option v-for="providers in provider" :key="providers.idProvider" :value="providers.idProvider">{{ providers.name }}</option>
            </select>
          </div>
          <ion-footer>
            <ion-button expand="full" type="submit">Guardar Cambios</ion-button>
          </ion-footer>
        </form>
      </ion-content>
    </ion-modal>
</template>

<script setup lang="ts">
import { IonModal, IonButton, IonContent, IonFooter, IonHeader, IonToolbar, IonTitle, IonButtons } from '@ionic/vue';
import { providerStore } from '@/stores/providerStore';
import { reactiveStore } from '@/stores/reactiveStore';
import { ref, defineEmits, watch, onMounted } from 'vue';
const provider = ref();
const reactive = ref();
const providersStore = providerStore();
const reactivesStore = reactiveStore();

				<div class="form-group">
					<label for="examSelect" class="form-label">Reactivo</label>
					<select v-model="form.idReactive" required class="form-select custom-input">
						<option value="" disabled>Selecciona un reactivo</option>
						<option v-for="reactives in reactive" :key="reactives.idReactive" :value="reactives.idReactive">
							{{ reactives.name }}
						</option>
					</select>
				</div>
				<div class="form-group">
					<label for="examSelect" class="form-label">Proveedor</label>
					<select v-model="form.idProvider" required class="form-select custom-input">
						<option value="" disabled>Selecciona un proveedor</option>
						<option v-for="providers in provider" :key="providers.idProvider" :value="providers.idProvider">
							{{ providers.name }}
						</option>
					</select>
				</div>
				<ion-footer>
					<ion-button expand="full" type="submit">Guardar Cambios</ion-button>
				</ion-footer>
			</form>
		</ion-content>
	</ion-modal>
</template>

<script setup lang="ts">
	import { providerStore } from "@/stores/providerStore";
	import { reactiveStore } from "@/stores/reactiveStore";
	import { ref, defineEmits, watch, onMounted } from "vue";
	import { IonContent, IonHeader, IonButton, IonButtons, IonTitle, IonFooter, IonToolbar, IonModal } from "@ionic/vue";
	const provider = ref();
	const reactive = ref();
	const providersStore = providerStore();
	const reactivesStore = reactiveStore();

	const props = defineProps<{
		isOpen: boolean;
		alliance: any;
	}>();

	const emit = defineEmits(["close", "update"]);

	const alliance = ref();
	const form = ref({
		idalliance: 0,
		quantity: 0,
		cost_bs: "",
		cost_usd: "",
		pay_done: true,
		pay_amount: "",
		idReactive: 0,
		idProvider: 0,
	});

	watch(
		() => props.alliance,
		async (newUser) => {
			if (newUser) {
				alliance.value = newUser;
				form.value.idReactive = newUser.idReactive;
				form.value.quantity = newUser.providerQuantity;
				form.value.idalliance = newUser.idAlliance;
				form.value.idProvider = newUser.idProvider;
				form.value.cost_bs = newUser.cost_bs;
				form.value.cost_usd = newUser.cost_usd;
				form.value.pay_amount = newUser.pay_amount;
				form.value.pay_done = newUser.pay_done;
			}
		}
	);

	onMounted(async () => {
		provider.value = await providersStore.fecthProviders();
		reactive.value = await reactivesStore.fecthReactives();
	});

	const closeModal = () => {
		emit("close");
	};

	const submit = () => {
		emit("update", { ...form.value });
		closeModal();
	};
</script>

<style scoped>
	.custom-input {
		background-color: #1e1e1e;
		border: 1px solid #444;
		border-radius: 8px;
		padding: 10px;
		font-size: 16px;
		color: #fff;
	}

	.radio-input {
		margin-right: 5px;
	}

	.radio-label {
		margin-right: 20px;
	}
</style>
