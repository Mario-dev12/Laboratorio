const fs = require('fs');
const ip = require('ip');

const envContent = `
VITE_PG_DB_HOST=${ip.address()}
`;

fs.writeFileSync('.env.local', envContent);

console.log(`.env.local creado con la IP de la máquina: ${ip.address()}`);