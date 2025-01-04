<template>  
  <ion-content>
    <div class="container mt-3">
      
      <div class="d-flex justify-content-center mb-3">  
        <div class="mx-2" style="flex: 1;">  
            <label for="startDate">Fecha de Inicio</label>  
            <input type="date" id="startDate" v-model="startDate" class="form-control" style="font-size: 1rem;">  
        </div>  
        <div class="mx-2" style="flex: 1;">  
            <label for="endDate">Fecha de Fin</label>  
            <input type="date" id="endDate" v-model="endDate" class="form-control" style="font-size: 1rem;">  
        </div>  
        <div class="mx-2 align-self-end">  
            <button @click="handleSearch" class="btn btn-primary" style="height: 38px;">Buscar</button>  
        </div>  
    </div> 

      <h2 class="text-center mb-4">Balance</h2>
      
      <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">  
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
              <td class="ingresos">+{{ totalBs }} bs (+{{totalDolares}} $)</td>  
              <td class="egresos">-{{ billsTotalBs }} bs (-{{ billsTotalDolares }} $)</td> 
              <td :class="{'balance-positivo': totalBs >= billsTotalBs, 'balance-negativo': totalBs < billsTotalBs}">  
                {{ totalBs - billsTotalBs }} bs ({{ totalDolares - billsTotalDolares }}) $
            </td> 
            </tr>  
          </tbody> 
        </table>  
      </div>
    </div>  
    <div class="container mt-3">
      <h2 class="text-center mb-4">Lista de Ingresos</h2>

      <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">  
        <table class="table table-striped">  
          <thead>  
            <tr>  
              <th>Nombre del Paciente</th>  
              <th>Documento Identidad</th>  
              <th>Género</th>  
              <th>Edad</th> 
              <th>Exámen</th>
              <th>Costo BS</th>
              <th>Costo $</th> 
              <th>Método Pago</th>
              <th>Moneda</th>
              <th>Banco</th>
              <th>Monto</th> 
            </tr>  
          </thead>  
          <tbody>  
            <tr v-for="income in incomes" :key="income.idUser">  
              <td>{{ income.firstName }} {{income.lastName}}</td>  
              <td>{{ income.ci ? income.ci : (income.passport ? income.passport : 'N/A') }}</td>  
              <td>{{ income.genre }}</td>
              <td>{{ income.age }}</td> 
              <td>{{ income.examName }}</td>
              <td>{{ income.cost_bs }} bs</td>
              <td>{{ income.cost_usd }} $</td> 
              <td>{{ income.PaymentMethodName }}</td>
              <td>{{ income.type }}</td>
              <td>{{ income.bank }}</td> 
              <td>  
                {{ income.amount }}   
                {{ income.type.toLowerCase() === 'bolivares' ? 'Bs' : income.type.toLowerCase() === 'dolares' ? '$' : '' }}  
              </td>        
            </tr>  
          </tbody>  
        </table>  
      </div>
      <table class="table table-striped">
        <tfoot>  
          <tr>  
              <td colspan="10" style="text-align:right; font-weight:bold;">Total $:</td>  
              <td style="text-align:right; font-weight:bold;">{{ totalDolares }} $</td>   
          </tr>   
          <tr>  
              <td colspan="10" style="text-align:right; font-weight:bold;">Total Bs:</td>  
              <td style="text-align:right; font-weight:bold;">{{ totalBs }} Bs</td>   
          </tr>  
        </tfoot> 
      </table>
    </div>
    <div class="container mt-3">
      <h2 class="text-center mb-4">Lista de Egresos</h2>

      <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">  
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
              <td>{{ bill.pay_done ? 'Sí' : 'No' }}</td>  
              <td>{{ bill.pay_amount }}</td>   
            </tr>  
          </tbody>  
        </table> 
      </div>
      <table class="table table-striped">
        <tfoot>  
          <tr>  
              <td colspan="6" style="text-align:right; font-weight:bold;">Total $:</td>  
              <td style="text-align:right; font-weight:bold;">{{ billsTotalDolares }} $</td>   
          </tr>   
          <tr>  
              <td colspan="6" style="text-align:right; font-weight:bold;">Total Bs:</td>  
              <td style="text-align:right; font-weight:bold;">{{ billsTotalBs }} Bs</td>   
          </tr>  
        </tfoot> 
      </table> 
    </div>
  </ion-content>
</template>  
  
<script setup lang="ts">  
  import { IonContent } from '@ionic/vue';
  import { boxStore } from '@/stores/boxStore';  
  import { onMounted, ref } from 'vue'; 

  const incomes = ref(); 
  const bills = ref(); 
  const totalBs = ref(0);
  const totalDolares = ref(0);
  const billsTotalBs = ref(0);
  const billsTotalDolares = ref(0);
  const boxsStore = boxStore();
  const startDate = ref('');  
  const endDate = ref(''); 

  onMounted(async () => {  
    incomes.value = await boxsStore.fecthIncome(true, '', '');
    bills.value = await boxsStore.fecthBills(true, '', '');
    await totalAmountIncome();
    await totalAmountBills();
  });  

  async function totalAmountIncome() {  
    for(let i = 0; i < incomes.value.length; i++){
      totalBs.value += parseFloat(incomes.value[i].cost_bs.replace(',', '.'));
      totalDolares.value += parseFloat(incomes.value[i].cost_usd.replace(',', '.'));
    }
  } 

  async function totalAmountBills() {  
    for(let i = 0; i < bills.value.length; i++){
      billsTotalBs.value += parseFloat(bills.value[i].cost_bs.replace(',', '.'));
      billsTotalDolares.value += parseFloat(bills.value[i].cost_usd.replace(',', '.'));
    }
  } 

  async function handleSearch() {
    totalBs.value = 0;
    totalDolares.value = 0;
    billsTotalBs.value = 0;
    billsTotalDolares.value = 0;
    incomes.value = await boxsStore.fecthIncome(false, startDate.value, endDate.value);
    bills.value = await boxsStore.fecthBills(false, startDate.value, endDate.value);
    await totalAmountIncome();
    await totalAmountBills();
  }
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

</style>