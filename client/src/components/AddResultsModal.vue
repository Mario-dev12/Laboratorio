<template>  
    <ion-modal :is-open="isOpen" @did-dismiss="closeModal">  
        <ion-header>  
            <ion-toolbar>  
                <ion-title>Añadir Resultado: {{ nombre }}</ion-title>  
                <ion-buttons slot="end">  
                    <ion-button @click="closeModal">Cerrar</ion-button>  
                </ion-buttons>  
            </ion-toolbar>  
        </ion-header>  
        
        <ion-content>  
            <ion-tabs v-if="tabNames.length > 0"> 
                <ion-tab-bar slot="top">  
                    <ion-tab-button  
                        v-for="(tabName, index) in tabNames"  
                        :key="index"  
                        :tab="tabName"  
                    >  
                        <ion-label>{{ tabName }}</ion-label>  
                    </ion-tab-button>  
                </ion-tab-bar>  

                <ion-tab  
                    v-for="(tabName, index) in tabNames"  
                    :key="index"  
                    :tab="tabName"  
                >  
                    <ion-content>  
                        <h3>Contenido de {{ tabName }}</h3>  
                    </ion-content>  
                </ion-tab>  
            </ion-tabs>  

            <div v-else>  
                <h3>No hay pestañas disponibles.</h3> 
            </div>  
        </ion-content>  
    </ion-modal>  
</template>    

<script setup lang="ts">  
import { ref, defineEmits, defineProps, watch } from 'vue';  
import { IonModal, IonButton, IonContent, IonTab, IonTabBar, IonTabs, IonTabButton, IonLabel, IonHeader, IonToolbar, IonTitle, IonButtons, IonRouterOutlet } from "@ionic/vue";  
import { profileStore } from '@/stores/profileStore';   

const props = defineProps<{  
    isOpen: boolean;  
    nombre: string;  
}>();  

const emit = defineEmits<{  
    (close: void): void;  
    (add: any): void;  
}>();  

const profile = ref();  
const profilesStore = profileStore();  
const tabNames = ref<string[]>([]);  

watch(() => props.isOpen, async (isOpen) => {  
    if (isOpen && props.nombre) {  
        await fetchProfile(props.nombre);  
    }  
});   

const fetchProfile = async (nombre: string) => {  
    profile.value = await profilesStore.fetchProfileByInputsName(nombre);  
    tabNames.value = Object.keys(profile.value);  
    console.log('Perfil cargado:', profile.value, tabNames.value);  
};  

const closeModal = () => {  
    emit('close');  
};  
</script>  

<style scoped>  
.custom-input {  
    margin: 10px 0;  
}  
</style>