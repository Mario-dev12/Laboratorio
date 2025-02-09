<template>  
    <div id="pdfTemplate">  
      <img :src="logoUrl" alt="Logo del Laboratorio" />  
      <h2>Perfil del Laboratorio Clínico</h2>  
      <table>  
        <thead>  
          <tr>  
            <th>Campo</th>  
            <th>Resultado</th>  
            <th>Unidad</th>  
            <th>Valores Preferenciales</th>  
          </tr>  
        </thead>  
        <tbody>  
          <tr v-for="(item, index) in labResults" :key="index">  
            <td>{{ item.campo }}</td>  
            <td>{{ item.resultado }}</td>  
            <td>{{ item.unidad }}</td>  
            <td>{{ item.valoresPreferenciales }}</td>  
          </tr>  
        </tbody>  
      </table>  
      <button @click="generatePDF">Generar PDF</button>  
    </div>  
  </template>  
  
  <script setup lang="ts">  
  import { ref } from 'vue';  
  import html2pdf from 'html2pdf.js';  
   
  const logoUrl = 'https://via.placeholder.com/150'; 
  const labResults = ref([  
    { campo: 'Hematíes', resultado: '4.5', unidad: 'millones/uL', valoresPreferenciales: '4.5-5.9' },  
    { campo: 'Hemoglobina', resultado: '15.5', unidad: 'g/dL', valoresPreferenciales: '13.5-17.5' },  
    { campo: 'Hematocrito', resultado: '45', unidad: '%', valoresPreferenciales: '38.8-50.0' },  
    { campo: 'CHCM', resultado: '35', unidad: 'g/dL', valoresPreferenciales: '32-36' },  
    { campo: 'HCM', resultado: '26', unidad: 'pg', valoresPreferenciales: '27-31' },  
    { campo: 'VCM', resultado: '93', unidad: 'fL', valoresPreferenciales: '80-100' },  
    { campo: 'Contaje de Blancos', resultado: '8000', unidad: 'células/uL', valoresPreferenciales: '4000-10000' },  
    { campo: 'Glicemia Basal', resultado: '90', unidad: 'mg/dL', valoresPreferenciales: '70-100' },  
  ]);  
   
  const generatePDF = () => {  
    const element = document.getElementById('pdfTemplate');  
    const options = {  
      margin:       1,  
      filename:     'perfil_laboratorio.pdf',  
      image:        { type: 'jpeg', quality: 0.98 },  
      html2canvas:  { scale: 2 },  
      jsPDF:        { unit: 'in', format: 'letter', orientation: 'portrait' },  
    };  
  
    html2pdf().from(element).set(options).save();  
  };  
  </script>  
  
  <style scoped>  
  table {  
    width: 100%;  
    border-collapse: collapse;  
    margin-top: 20px;  
  }  
  th, td {  
    border: 1px solid black;  
    padding: 8px;  
    text-align: left;  
  }  
  th {  
    background-color: #f2f2f2; 
  }  
  img {  
    width: 150px;
  }  
  </style>