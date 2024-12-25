<template>  
    <ion-modal :is-open="isOpen" @ionModalDidClose="closeModal">  
      <ion-header>  
        <ion-toolbar>  
          <ion-title>Añadir Proveedor</ion-title>  
          <ion-buttons slot="end">  
            <ion-button @click="closeModal">Cerrar</ion-button>  
          </ion-buttons>  
        </ion-toolbar>  
      </ion-header>  
  
      <ion-content>  
        <form @submit.prevent="submit">  
          <div class="form-group">  
            <label for="providerName" class="form-label">Nombre del Proveedor</label>  
            <input  
              v-model="provider.name"  
              type="text"  
              required  
              class="form-control custom-input"  
              placeholder="Ingrese el nombre del proveedor"  
            />  
          </div>  
          <ion-footer>  
            <ion-button expand="full" type="submit">Añadir Proveedor</ion-button>  
          </ion-footer>  
        </form>  
      </ion-content>  
    </ion-modal>  
  </template>  
  
<script setup lang="ts">  
import { ref, defineEmits, watch } from 'vue';
import { IonModal, IonButton, IonContent, IonFooter, IonHeader, IonToolbar, IonTitle, IonButtons } from '@ionic/vue';  

const props = defineProps<{  
    isOpen: boolean;  
    provider: any;
}>();   
const emit = defineEmits(['close', 'add']);

watch(() => props.provider, async (newUser) => {  
    if (newUser){
      provider.value = newUser
    }
});  

const provider = ref({  
    name: '',  
});  

const closeModal = () => {  
    emit('close');  
};  
  
const submit = () => {  
    emit('add', { ...provider.value });  
    provider.value = { name: '' };
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

</style>  