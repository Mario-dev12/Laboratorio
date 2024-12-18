![image](https://github.com/user-attachments/assets/94ad7bd6-d81c-4d86-a159-042f93db94f0)# Laboratorio  

## Descripción  

Laboratorio es una aplicación web diseñada para gestionar la creación de órdenes de pacientes, llevar registros de exámenes realizados, administrar reactivos disponibles y proporcionar información importante para el laboratorio clínico. Además, permite imprimir y enviar por correo los resultados de los exámenes.  

## Tecnologías  

- **Backend**: Node.js, Express  
- **Frontend**: Vue 3, Pinia  

## Funcionalidades  

- **Crear órdenes de pacientes**: Genera y gestiona órdenes de laboratorio para pacientes de manera sencilla.  
- **Registro de exámenes**: Lleva un control detallado de los exámenes realizados, incluyendo fechas, tipos de pruebas y resultados.  
- **Gestión de reactivos**: Administra el inventario de reactivos disponibles para realizar pruebas.  
- **Información de laboratorio**: Proporciona información relevante y actualizada sobre procedimientos y normativas del laboratorio.  
- **Impresión y envío de resultados**: Permite imprimir los resultados de los exámenes y enviarlos por correo electrónico a los pacientes o médicos solicitantes.  

## Instalación  

1. Clona el repositorio:  
   ```bash  
   git clone https://github.com/Mario-dev12/laboratorio.git
2. Instala las dependencias del backend:  
   ```bash
   cd server  
   npm install
3. Instala las dependencias del frontend:  
   ```bash
   cd client  
   npm install
   
## Configuración 

Configura las variables de entorno necesarias para el backend en un archivo .env.
Asegúrate de tener un entorno de base de datos corriendo (PostgreSQL) y ajusta las configuraciones en el backend según sea necesario.

## Ejecución

1. Para iniciar el servidor de backend:
   ```bash
   cd server  
   npm start
2. Para iniciar el servidor de frontend:
   ```bash
   cd client  
   npm run dev

## Licencia
Este proyecto está bajo la Licencia MIT - consulta el archivo LICENSE para más detalles.
