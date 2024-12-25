<template>  
    <ion-modal :is-open="isOpen" @ionModalDidClose="closeModal">  
      <ion-header>  
        <ion-toolbar>  
          <ion-title>Editar Reactivo</ion-title>  
          <ion-buttons slot="end">  
            <ion-button @click="closeModal">Cerrar</ion-button>  
          </ion-buttons>  
        </ion-toolbar>  
      </ion-header>  

      <ion-content>  
        <form @submit.prevent="submit">  
          <div class="form-group">  
            <label class="form-label">Nombre del Reactivo</label>  
            <input  
              v-model="form.name"  
              type="text"  
              required  
              class="form-control custom-input"  
              placeholder="Ingrese el nombre del reactivo"  
            />  
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
import { examStore } from '@/stores/examStore';
import { ref, defineEmits, watch, onMounted } from 'vue';  
const exams = ref();
const examsStore = examStore()

const props = defineProps<{  
    isOpen: boolean;  
    reactive: any;
}>();   

const emit = defineEmits(['close', 'update']);  

const reactive = ref();  
const form = ref({ 
idreactive: 0,
name: '',  
}); 

watch(() => props.reactive, (newUser) => {  
    if (newUser){
        reactive.value = newUser
        form.value.idreactive = newUser.idReactive
        form.value.name = newUser.name
    }
});   

onMounted(async () => {  
    exams.value = await examsStore.fecthExams();  
})


const closeModal = () => {  
    emit('close');  
};  

const submit = () => {  

    emit('update', { ...form.value });
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
</style>