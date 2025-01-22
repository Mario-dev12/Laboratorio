<template>  
    <ion-modal :is-open="isOpen" @did-dismiss="closeModal" css-class="modal-ancho">  
        <ion-header>  
            <ion-toolbar>  
                <ion-title>  
                    Métodos de Pago  
                    <div>  
                        Total: {{ totales.totalBs }} Bs | {{ totales.total$ }} $  
                    </div>  
                    <div>  
                        Tasa: {{ precioDolar }} 
                    </div>  
                </ion-title>  
                <ion-buttons slot="end">  
                    <ion-button @click="closeModal">Cerrar</ion-button>  
                </ion-buttons>  
            </ion-toolbar>  
        </ion-header>  
        <ion-content>  
            <form @submit.prevent="submit" class="p-3">  
                <div class="tasa-container">  
                    <label v-if="!isEditingTasa">Tasa: {{ precioDolar }}</label>  
                    <input  
                        v-if="isEditingTasa"  
                        v-model.number="nuevoMontoDolar"  
                        type="number"  
                        placeholder="Nuevo monto"  
                        @keyup.enter="guardarTasa"  
                    />  
                    <i class="fas fa-edit" @click="isEditingTasa = !isEditingTasa" style="cursor: pointer; margin-left: 10px;"></i>  
                    
                    <i  
                        v-if="isEditingTasa"  
                        class="fas fa-check accept-icon"  
                        @click="guardarTasa"  
                        style="cursor: pointer; margin-left: 10px;"  
                    ></i>  
                    <i  
                        v-if="isEditingTasa"  
                        class="fas fa-times reject-icon"  
                        @click="cancelarEdicion"  
                        style="cursor: pointer; margin-left: 10px;"  
                    ></i>  
                </div>   

                <div v-for="(metodo, index) in metodos" :key="index" class="metodo-pago">  
                    <div class="form-group">  
                        <label for="metodoPago">Método de Pago</label>  
                        <select v-model="metodo.metodo" class="form-control" id="metodoPago" required>  
                            <option value="" disabled>Select...</option>  
                            <option value="Debito">Débito</option>  
                            <option value="Efectivo">Efectivo</option>  
                            <option value="Pago Movil">Pago Móvil</option>  
                        </select>  
                    </div>  

                    <div v-if="metodo.metodo === 'Efectivo'" class="form-inline">  
                        <div class="form-group mx-2">  
                            <label for="divisaEfectivo">Divisa:</label>  
                            <select v-model="metodo.divisaEfectivo" class="form-control" id="divisaEfectivo" required>  
                                <option value="Bolivares">Bolívares</option>  
                                <option value="Dolares">Dólares</option>  
                            </select>  
                        </div>  
                        <div class="form-group mx-2">  
                            <label for="montoEfectivo">Monto:</label>  
                            <input  
                                v-model.number="metodo.montoEfectivo"  
                                type="text"  
                                class="form-control"  
                                id="montoEfectivo"  
                                required  
                                placeholder="Ingrese el monto"  
                            />  
                        </div>  
                        <div v-if="metodo.divisaEfectivo === 'Bolivares'" class="form-group mx-2">  
                            <label for="montoEfectivoEquivalente">Monto Equivalente (USD):</label>  
                            <input  
                                :value="(metodo.montoEfectivo / precioDolar).toFixed(2)"  
                                type="text"  
                                class="form-control"  
                                id="montoEfectivoEquivalente"  
                                readonly  
                            />  
                        </div>  
                        <div v-if="metodo.divisaEfectivo === 'Dolares'" class="form-group mx-2">  
                            <label for="montoEfectivoBS">Monto Equivalente (BS):</label>  
                            <input  
                                :value="(metodo.montoEfectivo * precioDolar).toFixed(2)"  
                                type="text"  
                                class="form-control"  
                                id="montoEfectivoBS"  
                                readonly  
                            />  
                        </div>  
                    </div> 

                    <div v-if="metodo.metodo === 'Debito'" class="form-inline">  
                        <div class="form-group mx-2">  
                            <label for="divisaDebito">Divisa:</label>  
                            <select v-model="metodo.divisaDebito" class="form-control" id="divisaDebito" required>  
                                <option value="Bolivares">Bolívares</option>  
                            </select>  
                        </div>  
                        <div class="form-group mx-2">  
                            <label for="banco">Banco:</label>  
                            <select v-model="metodo.banco" class="form-control" id="banco" required>  
                                <option value="Mercantil">Mercantil</option>  
                                <option value="Venezuela">Venezuela</option>  
                                <option value="Bancaribe">Bancaribe</option>  
                            </select>  
                        </div> 
                        <div class="form-group mx-2">  
                            <label for="montoDebito">Monto:</label>  
                            <input  
                                v-model.number="metodo.montoDebito"  
                                type="text"  
                                class="form-control"  
                                id="montoDebito"  
                                required  
                                placeholder="Ingrese el monto"  
                            />  
                        </div>  
                        <div class="form-group mx-2">  
                            <label for="montoDebitoEquivalente">Monto Equivalente (USD):</label>  
                            <input  
                                :value="(metodo.montoDebito / precioDolar).toFixed(2)"  
                                type="text"  
                                class="form-control"  
                                id="montoDebitoEquivalente"  
                                readonly  
                            />  
                        </div>   
                    </div>  
                    
                    <div v-if="metodo.metodo === 'Pago Movil'" class="form-inline">  
                        <div class="form-group mx-2">  
                            <label for="divisaPagoMovil">Divisa:</label>  
                            <select v-model="metodo.divisaPagoMovil" class="form-control" id="divisaPagoMovil" required>  
                                <option value="Bolivares">Bolívares</option>  
                            </select>  
                        </div>  
                        <div class="form-group mx-2">  
                            <label for="bancoPagoMovil">Banco:</label>  
                            <select v-model="metodo.bancoPagoMovil" class="form-control" id="bancoPagoMovil" required>  
                                <option value="Mercantil">Mercantil</option>  
                                <option value="Venezuela">Venezuela</option>  
                                <option value="Bancaribe">Bancaribe</option>  
                            </select>  
                        </div>  
                        <div class="form-group mx-2">  
                            <label for="montoPagoMovil">Monto:</label>  
                            <input  
                                v-model.number="metodo.montoPagoMovil"  
                                type="text"  
                                class="form-control"  
                                id="montoPagoMovil"  
                                required  
                                placeholder="Ingrese el monto"  
                            />  
                        </div>  
                        <div class="form-group mx-2">  
                            <label for="montoPagoMovilEquivalente">Monto Equivalente (USD):</label>  
                            <input  
                                :value="(metodo.montoPagoMovil / precioDolar).toFixed(2)"  
                                type="text"  
                                class="form-control"  
                                id="montoPagoMovilEquivalente"  
                                readonly  
                            />  
                        </div>  
                    </div>

                    <ion-item-divider></ion-item-divider>  
                </div>  

                <div v-if="method && !esMontoEquivalente" class="total-container pt-3"> 
                    <label>Total Restante Bs: {{ montoRestanteBolivares }}</label>
                </div>

                <div v-if="method && !esMontoEquivalente" class="total-container pt-3"> 
                    <label>Total Restante $: {{ montoRestanteDolares }}</label>
                </div>

                <ion-item-divider v-if="method && !esMontoEquivalente"></ion-item-divider> 

                <a class="a-class" v-if="!esMontoEquivalente" @click="agregarMetodoPago">+ Nuevo Método de Pago</a>  

                <ion-footer style="position: absolute; bottom: 0; left: 0; right: 0;">  
                    <ion-button expand="full" type="submit">Añadir Métodos de Pago</ion-button>  
                </ion-footer>  
            </form>  
        </ion-content>  
    </ion-modal>  
</template>  

<script setup lang="ts">  
import { ref, defineEmits, defineProps, computed } from "vue";  
import { IonButton, IonContent, IonHeader, IonModal, IonTitle, IonFooter, IonToolbar, IonButtons, IonItemDivider } from "@ionic/vue";

const props = defineProps<{  
    isOpen: boolean;  
    precioDolar: number;
    totales: {  
        totalBs: number;  
        total$: number;  
    };  
}>();  

const montoRestanteBolivares = ref(0);  
const montoRestanteDolares = ref(0);  

const method = ref(false);

const emit = defineEmits(["close", "add", "update-precio-dolar"]);  

const metodos = ref([{ metodo: '', divisaEfectivo: '', montoEfectivo: 0, divisaDebito: 'Bolivares', montoDebito: 0, montoUSD: 0, banco: '', divisaPagoMovil: 'Bolivares', bancoPagoMovil: '', montoPagoMovil: 0 }]);  

const closeModal = () => {  
    emit("close");  
};  

const agregarMetodoPago = async () => { 
    method.value = true; 
    await calcularMontosRestantes();
    metodos.value.push({ metodo: '', divisaEfectivo: '', montoEfectivo: 0, divisaDebito: 'Bolivares', montoDebito: 0, montoUSD: 0, banco: '', divisaPagoMovil: 'Bolivares', bancoPagoMovil: '', montoPagoMovil: 0 });  
};  

const submit = () => {  
    const paymentDetails = metodos.value.filter(m => m.metodo).map(m => ({  
        metodo: m.metodo,  
        monto: m.metodo === 'Efectivo' ? m.montoEfectivo : m.metodo === 'Pago Movil' ? m.montoPagoMovil : m.montoDebito,  
        divisa: m.metodo === 'Efectivo' ? m.divisaEfectivo : m.metodo === 'Pago Movil' ? m.divisaPagoMovil : m.divisaDebito,  
        banco: m.metodo === 'Debito' ? m.banco : m.metodo === 'Pago Movil' ? m.bancoPagoMovil : null,  
    }));  

    if (paymentDetails.length === 0) {  
        alert("Por favor, seleccione al menos un método de pago.");  
        return;  
    }  

    emit("add", paymentDetails); 
    resetForm();  
    closeModal(); 
};  

const resetForm = () => {  
    metodos.value = [{ metodo: '', divisaEfectivo: '', montoEfectivo: 0, divisaDebito: 'Bolivares', montoDebito: 0, montoUSD: 0, banco: '', divisaPagoMovil: 'Bolivares', bancoPagoMovil: '', montoPagoMovil: 0 }];  
};  

const isEditingTasa = ref(false);  
const nuevoMontoDolar = ref(props.precioDolar);  

const guardarTasa = () => {  
    emit("update-precio-dolar", nuevoMontoDolar.value); 
    isEditingTasa.value = false; 
};  

const cancelarEdicion = () => {  
    nuevoMontoDolar.value = props.precioDolar; 
    isEditingTasa.value = false; 
}; 

const esMontoEquivalente = computed(() => {  
    let totalBolivares = 0;  
    let totalDolares = 0;  

    metodos.value.forEach(metodo => {  
        if (metodo.metodo === 'Efectivo') {  
            if (metodo.divisaEfectivo === 'Bolivares') {  
                totalBolivares += metodo.montoEfectivo;  
                metodo.montoUSD = metodo.montoEfectivo / props.precioDolar;
                totalDolares += metodo.montoUSD;
            } else if (metodo.divisaEfectivo === 'Dolares') {  
                totalBolivares += metodo.montoEfectivo * props.precioDolar; 
                totalDolares += metodo.montoEfectivo; 
            }  
        } else if (metodo.metodo === 'Debito') {  
            totalBolivares += metodo.montoDebito;
            metodo.montoUSD = metodo.montoDebito / props.precioDolar;
            totalDolares += metodo.montoUSD;
        } else if (metodo.metodo === 'Pago Movil') {  
            totalBolivares += metodo.montoPagoMovil;
            metodo.montoUSD = metodo.montoPagoMovil / props.precioDolar;
            totalDolares += metodo.montoUSD;
        }  
    });  

    return totalBolivares === props.totales.totalBs && totalDolares === props.totales.total$;  
});  

async function calcularMontosRestantes() {  
    const totalBolivares = metodos.value.reduce((acc, metodo) => {  
        const montoEfectivoBs = (metodo.metodo === 'Efectivo' && metodo.divisaEfectivo === 'Bolivares')  
            ? metodo.montoEfectivo  
            : (metodo.metodo === 'Efectivo' && metodo.divisaEfectivo === 'Dolares'  
                ? metodo.montoEfectivo * props.precioDolar  
                : 0);  

        return acc + montoEfectivoBs +  
                   (metodo.metodo === 'Debito' ? metodo.montoDebito : 0) +  
                   (metodo.metodo === 'Pago Movil' ? metodo.montoPagoMovil : 0);  
    }, 0);  

    montoRestanteBolivares.value = props.totales.totalBs - totalBolivares;  

    const totalDolares = metodos.value.reduce((acc, metodo) => {  
        const montoEfectivoUsd = (metodo.metodo === 'Efectivo' && metodo.divisaEfectivo === 'Dolares')  
            ? metodo.montoEfectivo  
            : (metodo.metodo === 'Efectivo' && metodo.divisaEfectivo === 'Bolivares'  
                ? metodo.montoEfectivo / props.precioDolar  
                : 0);  

        // Incluimos la línea que divide el monto de Pago Movil por la tasa  
        const montoPagoMovilUsd = (metodo.metodo === 'Pago Movil') ? metodo.montoPagoMovil / props.precioDolar : 0;  

        return acc + montoEfectivoUsd +  
                   (metodo.metodo === 'Debito' ? metodo.montoDebito / props.precioDolar : 0) +  
                   montoPagoMovilUsd; // Añadimos el monto de Pago Movil en USD  
    }, 0);  

    montoRestanteDolares.value = props.totales.total$ - totalDolares;  
}  
</script>  

<style scoped>  
.modal-ancho {  
    --width: 900px; 
    --height: 700px;
}  

.form-inline {  
    display: flex;  
    align-items: center;  
    margin-top: 1rem;  
}  

.form-group {  
    margin-right: 1rem;
}  

.metodo-pago {  
    margin-bottom: 1rem;
}  

.tasa-container {  
    margin-bottom: 1rem;
    font-weight: bold;
}  

.total-container {  
    font-weight: bold;
}  

.a-class{
    color: blue;
    cursor: pointer;
}
</style>