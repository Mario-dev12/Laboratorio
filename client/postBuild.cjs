const fs = require('fs');  
const path = require('path');  

const filePath = path.join(__dirname, 'dist', 'index.html');  

fs.readFile(filePath, 'utf8', (err, data) => {  
    if (err) {  
        console.error('Error al leer el archivo:', err);  
        return;  
    }  
    const result = data.replace(/<base href="\/" \/>/, '<base href="./" />');  

    fs.writeFile(filePath, result, 'utf8', (err) => {  
        if (err) {  
            console.error('Error al escribir el archivo:', err);  
        }
    });  
});