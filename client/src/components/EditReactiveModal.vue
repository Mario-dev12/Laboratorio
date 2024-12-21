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
          <div class="form-group">  
            <label class="form-label">Cantidad</label>  
            <input  
              v-model.number="form.quantity"  
              type="number"  
              required  
              class="form-control custom-input"  
              placeholder="Ingrese la cantidad"  
            />  
          </div>
          <div class="form-group">   
            <label for="examSelect" class="form-label">Perfil (Examen)</label>  
            <select v-model="form.idExam" required class="form-select custom-input"> 
              <option value="" disabled>Selecciona un examen</option>  
              <option v-for="exam in exams" :key="exam.idExam" :value="exam.idExam">{{ exam.name }}</option>  
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
quantity: 0,
idExam: 0 
}); 

watch(() => props.reactive, (newUser) => {  
    if (newUser){
        reactive.value = newUser
        form.value.idreactive = newUser.idReactive
        form.value.name = newUser.name
        form.value.quantity = newUser.quantity
        form.value.idExam = newUser.idExam
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