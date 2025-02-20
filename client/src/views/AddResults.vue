<template>  
    <ion-page>  
        <ion-header>  
            <ion-toolbar>  
                <ion-title>Añadir Resultado: {{ profileName }}</ion-title>  
                <ion-buttons slot="end">  
                    <ion-button @click="goBack">Atrás</ion-button>  
                </ion-buttons>  
            </ion-toolbar>  
        </ion-header>  

        <ion-content>  
            <div class="container">  
                <ion-tabs v-if="tabNames.length > 0">  
                    <ion-tab-bar slot="top">  
                        <ion-tab-button  
                            v-for="(tabName, index) in tabNames"  
                            :key="index"  
                            :tab="tabName"  
                            @click="loadTabResults(tabName)"  
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
                            <div class="table-container">  
                                <div class="table-wrapper">  
                                    <table v-if="currentResults.firstTable.length > 0">  
                                        <thead>  
                                            <tr>  
                                                <th>Nombre</th>  
                                                <th>Valor</th>  
                                                <th>Unidad</th>  
                                            </tr>  
                                        </thead>  
                                        <tbody>  
                                            <tr v-for="(item, idx) in currentResults.firstTable" :key="idx">  
                                                <td>{{ item.nombre }}</td>  
                                                <td>  
                                                    <input   
                                                        type="text"   
                                                        v-model="item.value"   
                                                        placeholder="Escribe un valor"   
                                                        class="input-field"   
                                                    />  
                                                </td>  
                                                <td>{{ item.unidad }}</td>  
                                            </tr>  
                                        </tbody>  
                                    </table>  
                                    <div v-else>  
                                        <p>No hay resultados disponibles para esta tabla.</p>  
                                    </div>  
                                </div>  
                                <div class="table-wrapper" v-if="currentResults.secondTable.length > 0">  
                                    <table>  
                                        <thead>  
                                            <tr>  
                                                <th>Nombre</th>  
                                                <th>Valor</th>  
                                                <th>Unidad</th>  
                                            </tr>  
                                        </thead>  
                                        <tbody>  
                                            <tr v-for="(item, idx) in currentResults.secondTable" :key="idx">  
                                                <td>{{ item.nombre }}</td>  
                                                <td>  
                                                    <input   
                                                        type="text"   
                                                        v-model="item.value"   
                                                        placeholder="Escribe un valor"   
                                                        class="input-field"   
                                                    />  
                                                </td>  
                                                <td>{{ item.unidad }}</td>  
                                            </tr>  
                                        </tbody>  
                                    </table>  
                                </div>  
                            </div>  
                            <div class="row w-100 m-auto mb-4 mt-2 mr-1">
                                <button class="btn btn-primary w-auto" @click="redirectToWhatsApp">Enviar por WhatsApp</button>
                            </div>
                            <div class="row w-100 m-auto mb-4 mt-2 mr-1">
                                <button class="btn btn-primary w-auto" @click="sendMailNodeMailer">Enviar por Correo</button>
                            </div>
                        </ion-content>  
                    </ion-tab>  
                </ion-tabs>  
                <div v-else>  
                    <h3>No hay pestañas disponibles.</h3>  
                </div>  
            </div>  
        </ion-content>  
    </ion-page>  
</template>  

<script setup lang="ts">  
import { ref, onMounted } from 'vue';  
import { IonPage, IonButton, IonContent, IonTab, IonTabBar, IonTabs, IonTabButton, IonLabel, IonHeader, IonToolbar, IonTitle, IonButtons } from "@ionic/vue";    
import { useRoute, useRouter } from 'vue-router';  
import { profileStore } from '@/stores/profileStore'; 
import { mailStore } from '@/stores/mailStore';  

const route = useRoute();  
const router = useRouter();  
const profileName = ref<string>('');  
const tabNames = ref<string[]>([]);  
const profileData = ref<{ [key: string]: any }>({});  
const currentResults = ref<any>({ firstTable: [], secondTable: [] });  

const profilesStore = profileStore();  
const mailsStore = mailStore(); 

onMounted(async () => {  
    const queryProfileName = route.query.profileName;  
    if (typeof queryProfileName === 'string') {  
        profileName.value = queryProfileName;  
    }  
    await fetchProfile(profileName.value);  
    if (tabNames.value.length > 0) {  
        loadTabResults(tabNames.value[0]);  
    }  
});  

const fetchProfile = async (nombre: string) => {  
    profileData.value = await profilesStore.fetchProfileByInputsName(nombre);  
    tabNames.value = Object.keys(profileData.value);  
};  

const loadTabResults = (tabName: string) => {  
    const results = profileData.value[tabName]?.resultado.map((item: any) => ({  
        ...item,  
        value: ''  
    })) || [];  

    if (results.length > 12) {   
        currentResults.value = {  
            firstTable: results.slice(0, 12),  
            secondTable: results.slice(12),  
        };  
    } else {  
        currentResults.value = {  
            firstTable: results,  
            secondTable: [],  
        };  
    }  
};  

const goBack = () => {  
    router.back();  
};  

const redirectToWhatsApp = () => {  
  const phoneNumber = '584123456789';
  const message = encodeURIComponent('Hola, por favor adjunta el documento en formato PDF que necesitas enviar.'); 
  const url = `https://api.whatsapp.com/send?phone=${phoneNumber}&text=${message}`;  
  
  window.open(url, '_blank');  
}  

const sendMailNodeMailer = async () => {
    const data = {
        pdfPath: 'ruta/a/resultado.pdf',
        destinatario: 'destinatario@hotmail.com' , 
        provider: 'gmail',
        userEmail: 'tu-email@gmail.com',
        userPassword: 'tu-contraseña',
    }
    await mailsStore.sendEmail(data)
}
</script>  

<style scoped>  
.container {  
    max-width: 800px;  
    margin: auto;  
    padding: 16px;  
    background-color: #f9f9f9;  
    border-radius: 8px;  
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);  
}  

.table-container {  
    display: flex;  
    justify-content: space-between;  
    flex-wrap: wrap;  
}  

.table-wrapper {  
    flex: 1;  
    margin-right: 10px;   
}  

.table-wrapper:last-child {  
    margin-right: 0;  
}  

table {  
    width: 100%;  
    border-collapse: collapse;  
    margin-top: 20px;  
}  

th,  
td {  
    border: 1px solid black;  
    padding: 5px;   
    text-align: left;  
}  

th {  
    background-color: #f2f2f2;  
    width: 80px;  
}  

td {  
    width: 60px;  
    height: 40px;  
}  

.input-field {  
    width: 100%; 
    height: 100%;
    border: none;
    padding: 4px;
    box-sizing: border-box; 
}  
</style>