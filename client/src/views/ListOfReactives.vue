<template>  
    <ion-content>  
      <div class="container mt-3">  
        <h2 class="text-center mb-4">Lista de Envios</h2>
    
        <div class="d-flex justify-content-end mb-3">  
          <ion-button @click="showModal" color="primary">+ Reactivo</ion-button> 
          <ion-button @click="showProvidersModal" color="primary">+ Proveedor</ion-button> 
          <ion-button @click="showAllianceModal" color="primary">+ Envio</ion-button> 
        </div>  
  
        <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">  
          <table class="table table-striped">  
            <thead>  
              <tr>  
                <th>Nombre del Reactivo</th>  
                <th>Proveedor</th>  
                <th>Cantidad</th>  
                <th>Acciones</th>  
              </tr>  
            </thead>  
            <tbody>  
              <tr v-for="reactive in reactives" :key="reactive.idreactive">  
                <td>{{ reactive.name }}</td>  
                <td>{{ reactive.providerName }}</td>  
                <td>{{ reactive.providerQuantity }}</td>  
                <td>  
                  <i class="fas fa-edit" @click="editAlliance(reactive)" style="cursor: pointer; margin-right: 10px;"></i>  
                  <i class="fas fa-trash" @click="deleteAlliance(reactive.idAlliance)" style="cursor: pointer;"></i>  
                </td>  
              </tr>  
            </tbody>  
          </table>  
        </div> 
        <div class="container mt-3">
          <h2 class="text-center mb-4">Lista de Reactivos</h2>

          <div class="d-flex justify-content-between"> 
            <div class="table-responsive" style="max-height: 400px; overflow-y: auto; flex: 1;">  
              <table class="table table-striped">  
                <thead>  
                  <tr>  
                    <th>Nombre del Reactivo</th>   
                    <th>Acciones</th>  
                  </tr>  
                </thead>  
                <tbody>  
                  <tr v-for="reactive in allReactives" :key="reactive.idreactive">  
                    <td>{{ reactive.name }}</td>      
                    <td>  
                      <i class="fas fa-edit" @click="editReactive(reactive)" style="cursor: pointer; margin-right: 10px;"></i>  
                      <i class="fas fa-trash" @click="deleteReactive(reactive.idReactive)" style="cursor: pointer;"></i>  
                    </td>  
                  </tr>  
                </tbody>  
              </table>  
            </div> 

            <div style="width: 30px;"></div>

            <div class="table-responsive" style="max-height: 400px; overflow-y: auto; flex: 1;">  
              <table class="table table-striped">  
                <thead>  
                  <tr>  
                    <th>Nombre del Reactivo</th>  
                    <th>Cantidad Total existencia</th>    
                  </tr>  
                </thead>  
                <tbody>  
                  <tr v-for="reactive in quantityReactives" :key="reactive.name">  
                    <td>{{ reactive.name }}</td>    
                    <td>{{ reactive.quantity }}</td>   
                  </tr>  
                </tbody>  
              </table>  
            </div>  
          </div>
        </div> 
        <div class="container mt-3">
          <h2 class="text-center mb-4">Lista de Proveedores</h2>

          <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">  
            <table class="table table-striped">  
              <thead>  
                <tr>  
                  <th>Nombre del Proveedor</th>    
                  <th>Acciones</th>  
                </tr>  
              </thead>  
              <tbody>  
                <tr v-for="provider in providers" :key="provider.idprovider">  
                  <td>{{ provider.name }}</td>  
                  <td>  
                    <i class="fas fa-edit" @click="editProvider(provider)" style="cursor: pointer; margin-right: 10px;"></i>  
                    <i class="fas fa-trash" @click="deleteProvider(provider.idProvider)" style="cursor: pointer;"></i>  
                  </td>  
                </tr>  
              </tbody>  
            </table>  
          </div> 
        </div>
          <AddReactiveModal   
              :is-open="isModalOpen" 
              :reactive="allReactives" 
              :exam="exams"
              @close="isModalOpen = false"   
              @add="addReactiveToList"   
          />  

          <AddProviderModal   
            :is-open="isProvidersModalOpen" 
            :provider="providers"  
            @close="isProvidersModalOpen = false"   
            @add="addProviderToList"   
          />  

          <AddShipmentModal   
            :is-open="isAllianceModalOpen" 
            :alliance="reactives" 
            :provider="providers"  
            @close="isAllianceModalOpen = false"   
            @add="addShipmentToList"   
          /> 

          <EditProviderModal  
              :is-open="isEditProviderModalOpen"  
              :provider="selectedProvider"  
              @close="isEditProviderModalOpen = false"  
              @update="updateProviderInList"  
          /> 

          <EditAllianceModal  
              :is-open="isEditAllianceModalOpen"  
              :alliance="selectedAlliance"  
              @close="isEditAllianceModalOpen = false"  
              @update="updateAllianceInList"  
          /> 
          
          <EditReactiveModal  
              :is-open="isEditModalOpen"  
              :reactive="selectedReactive"  
              @close="isEditModalOpen = false"  
              @update="updateReactiveInList"  
          />  
      </div>  
    </ion-content>  
</template>  
  
<script setup lang="ts">  
import { Alliance, Provider, Reactive, ReactiveProvider } from '@/interfaces/interfaces';
import { reactiveStore } from '@/stores/reactiveStore';  
import { onMounted, ref } from 'vue';  
import AddReactiveModal from '@/components/AddReactiveModal.vue';
import EditReactiveModal from '@/components/EditReactiveModal.vue'; 
import AddProviderModal from '@/components/AddProviderModal.vue'; 
import AddShipmentModal from '@/components/AddShipmentModal.vue';
import EditProviderModal from '@/components/EditProviderModal.vue';
import EditAllianceModal from '@/components/EditAllianceModal.vue';
import { providerStore } from '@/stores/providerStore';
import { allianceStore } from '@/stores/allianceStore';
import { examStore } from '@/stores/examStore';

const reactives = ref();  
const providers = ref();
const allReactives = ref();
const quantityReactives = ref();
const exams = ref();
const reactivesStore = reactiveStore();
const providersStore = providerStore();
const alliancesStore = allianceStore();
const examsStore = examStore()
const isModalOpen = ref(false); 
const isProvidersModalOpen = ref(false);
const isAllianceModalOpen = ref(false); 
const selectedReactive = ref();
const selectedAlliance = ref();
const selectedProvider = ref();   
const isEditModalOpen = ref(false); 
const isEditAllianceModalOpen = ref(false); 
const isEditProviderModalOpen = ref(false); 


onMounted(async () => {  
    reactives.value = await reactivesStore.fetchReactiveByProvider();
    providers.value = await providersStore.fecthProviders();
    allReactives.value = await reactivesStore.fecthReactives();
    exams.value = await examsStore.fecthExams();
    quantityReactives.value = await reactivesStore.fecthQuantityReactives();
});  

const editReactive = (reactive: any) => {  
    selectedReactive.value = { ...reactive }; 
    selectedReactive.value = reactive;
    isEditModalOpen.value = true;  
}; 

const editAlliance = (alliance: any) => {  
  selectedAlliance.value = { ...alliance }; 
  selectedAlliance.value = alliance;
  isEditAllianceModalOpen.value = true;  
}; 

const editProvider = (provider: any) => {  
    selectedProvider.value = { ...provider }; 
    selectedProvider.value = provider;
    isEditProviderModalOpen.value = true;  
};  

const updateReactiveInList = async (updatedReactive: Reactive) => {  
  const id = updatedReactive.idreactive
  await reactivesStore.updateReactive(id, updatedReactive)
  reactives.value = await reactivesStore.fetchReactiveByProvider();
  providers.value = await providersStore.fecthProviders();
  allReactives.value = await reactivesStore.fecthReactives();  
};  

const updateAllianceInList = async (updatedAlliance: Alliance) => {  
  const id = updatedAlliance.idalliance
  await alliancesStore.updateAlliance(id, updatedAlliance)
  reactives.value = await reactivesStore.fetchReactiveByProvider();
  providers.value = await providersStore.fecthProviders();
  allReactives.value = await reactivesStore.fecthReactives(); 
}; 

const updateProviderInList = async (updatedProvider: Provider) => {
  const id = updatedProvider.idprovider 
  await providersStore.updateProvider(id, updatedProvider)
  reactives.value = await reactivesStore.fetchReactiveByProvider();
  providers.value = await providersStore.fecthProviders();
  allReactives.value = await reactivesStore.fecthReactives();
}; 

const deleteReactive = async (id: number | string) => {   
    await reactivesStore.deleteReactive(id)
    reactives.value = await reactivesStore.fetchReactiveByProvider();
    providers.value = await providersStore.fecthProviders();
    allReactives.value = await reactivesStore.fecthReactives();   
};

const deleteAlliance = async (id: number | string) => {   
    await alliancesStore.deleteAlliance(id)
    reactives.value = await reactivesStore.fetchReactiveByProvider();
    providers.value = await providersStore.fecthProviders();
    allReactives.value = await reactivesStore.fecthReactives();  
};

const deleteProvider = async (id: number | string) => {  
    await providersStore.deleteProvider(id)
    reactives.value = await reactivesStore.fetchReactiveByProvider();
    providers.value = await providersStore.fecthProviders();
    allReactives.value = await reactivesStore.fecthReactives(); 
};

const addReactiveToList = async (newReactive: ReactiveProvider) => {    
    await reactivesStore.createReactive(newReactive);
    reactives.value = await reactivesStore.fetchReactiveByProvider();
    providers.value = await providersStore.fecthProviders();
    allReactives.value = await reactivesStore.fecthReactives();
};  

const addProviderToList = async (newProvider: Provider) => {   
    await providersStore.createProvider(newProvider) 
    reactives.value = await reactivesStore.fetchReactiveByProvider();
    providers.value = await providersStore.fecthProviders();
    allReactives.value = await reactivesStore.fecthReactives();
};

const addShipmentToList = async (newShipment: Alliance) => {    
    await alliancesStore.createAlliance(newShipment);
    reactives.value = await reactivesStore.fetchReactiveByProvider();
    providers.value = await providersStore.fecthProviders();
    allReactives.value = await reactivesStore.fecthReactives();
}; 

const showModal = async () => { 
  isModalOpen.value = true;  
};  

const showProvidersModal = async () => {  
  isProvidersModalOpen.value = true;  
}; 

const showAllianceModal = async () => {
  isAllianceModalOpen.value = true;  
}; 

</script>  
  
<style scoped>   
.container {  
padding: 16px; 
}  

.table-responsive {  
max-height: 400px; 
}  

.btn-container {  
display: flex;  
justify-content: flex-end;  
margin-bottom: 1rem; 
}  
</style>