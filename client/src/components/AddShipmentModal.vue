<template>  
    <ion-modal :is-open="isOpen" @did-dismiss="closeModal">  
      <ion-header>  
        <ion-toolbar>  
          <ion-title>Añadir Envío</ion-title>  
          <ion-buttons slot="end">  
            <ion-button @click="closeModal">Cerrar</ion-button>  
          </ion-buttons>  
        </ion-toolbar>  
      </ion-header>  
  
      <ion-content>  
        <form @submit.prevent="submit">  
          <div class="form-group">  
            <label for="shipmentQuantity" class="form-label">Cantidad</label>  
            <input  
              v-model.number="shipment.quantity"  
              type="number"  
              required  
              class="form-control custom-input"  
              placeholder="Ingrese la cantidad"  
            />  
          </div> 
          
          <div class="form-group">  
            <label for="shipmentCostBs" class="form-label">Costo Bolivares</label>  
            <input  
              v-model="shipment.cost_bs"  
              type="text"  
              required  
              class="form-control custom-input"  
              placeholder="Ingrese la cantidad"  
            />  
          </div> 

          <div class="form-group">  
            <label for="shipmentCostUsd" class="form-label">Costo Dolares</label>  
            <input  
              v-model="shipment.cost_usd"  
              type="text"  
              required  
              class="form-control custom-input"  
              placeholder="Ingrese la cantidad"  
            />  
          </div>

          <div class="form-group">  
            <label for="paymentStatus" class="form-label">Pago realizado</label>  
            <div>  
                <input   
                  type="radio"   
                  id="paymentYes"   
                  :value="true"   
                  v-model="shipment.pay_done"
                  class="radio-input"   
                />  
                <label class="radio-label" for="paymentYes">Sí</label>  
                
                <input   
                  type="radio"   
                  id="paymentNo"   
                  :value="false"   
                  v-model="shipment.pay_done"
                  class="radio-input"
                />  
                <label for="paymentNo">No</label>  
            </div>  
          </div>  

          <div class="form-group" v-if="!shipment.pay_done">  
            <label for="payAmount" class="form-label">Debe</label>  
            <input  
              v-model="shipment.pay_amount"  
              type="text"  
              class="form-control custom-input"  
              placeholder="Ingrese el monto"  
            />  
          </div> 
          
          <div class="form-group">  
            <label for="reactiveSelect" class="form-label">Reactivo</label>  
            <select v-model="shipment.idReactive" required class="form-select custom-input">  
              <option value="" disabled>Selecciona un reactivo</option>  
              <option v-for="reactive in reactives" :key="reactive.idReactive" :value="reactive.idReactive">{{ reactive.name }}</option>  
            </select>  
          </div>  
          
          <div class="form-group">  
            <label for="providerSelect" class="form-label">Proveedor</label>  
            <select v-model="shipment.idProvider" required class="form-select custom-input">  
              <option value="" disabled>Selecciona un proveedor</option>  
              <option v-for="provider in providers" :key="provider.idProvider" :value="provider.idProvider">{{ provider.name }}</option>  
            </select>  
          </div>  
  
          <ion-footer>  
            <ion-button expand="full" type="submit">Añadir Envío</ion-button>  
          </ion-footer>  
        </form>  
      </ion-content>  
    </ion-modal>  
  </template>  
  
<script setup lang="ts">  
import { IonModal, IonButton, IonContent, IonFooter, IonHeader, IonToolbar, IonTitle, IonButtons } from '@ionic/vue';
import { ref, defineEmits, onMounted, watch } from 'vue';  
import { reactiveStore } from '@/stores/reactiveStore';
import { providerStore } from '@/stores/providerStore'; 

const props = defineProps<{  
    isOpen: boolean;  
    alliance: any;
    provider: any;
}>(); 
const emit = defineEmits(['close', 'add']); 

watch(() => props.alliance, async (newUser) => {  
    if (newUser){
      reactives.value = await reactivesStore.fecthReactives(); 
    }
});  

watch(() => props.provider, async (newUser) => {  
    if (newUser){
      providers.value = await providersStore.fecthProviders();
    }
}); 

const shipment = ref({  
    quantity: 0,
    cost_bs: '',
    cost_usd: '',
    pay_done: true,
    pay_amount: '',
    idReactive: 0,  
    idProvider: 0,  
});  

const reactives = ref();      
const providers = ref();  
const reactivesStore = reactiveStore();  
const providersStore = providerStore();  

onMounted(async () => {  
    reactives.value = await reactivesStore.fecthReactives(); 
    providers.value = await providersStore.fecthProviders();
});  

const closeModal = () => {  
    emit('close');  
};  

const submit = () => {  
    emit('add', { ...shipment.value });  
    shipment.value = { quantity: 0, cost_bs: '', cost_usd: '', pay_done: false, pay_amount: '', idReactive: 0, idProvider: 0 };  
    closeModal();  
};  
</script>  
  
<style scoped>  
.modal-background {  
  background-color: #121212;  
  color: white; 
}  

.custom-input {  
  background-color: #1e1e1e; 
  border: 1px solid #444; 
  border-radius: 8px; 
  padding: 10px;  
  font-size: 16px;  
  transition: border-color 0.3s, box-shadow 0.3s;
  color: #fff;
}  

.custom-input:focus {  
    background-color: #1e1e1e; 
    color: #fff;
}  

.custom-input::placeholder {  
  color: #ccc;
  opacity: 1;
}  

.radio-input {  
  margin-right: 5px;
}  

.radio-label {  
  margin-right: 20px;
}  
</style>  