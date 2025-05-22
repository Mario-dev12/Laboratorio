const { app, BrowserWindow } = require("electron");  
const path = require("path");  
const { exec } = require("child_process");  
require("dotenv").config();  

let serverProcess;  
const nodePathPc = "C:/Program Files/nodejs/node.exe";  // Asegúrate de que esta ruta es correcta  
const gotTheLock = app.requestSingleInstanceLock();  
let win;  

async function createWindow() {  
    try {  
        if (win) {  
            win.focus();  
            return;  
        }  

        win = new BrowserWindow({  
            width: 1200,  
            height: 600,  
            webPreferences: {  
                nodeIntegration: true,  
                contextIsolation: false,  
                enableRemoteModule: true,  
                webSecurity: true,  
            },  
        });  

        win.loadFile(path.join(__dirname, "dist", "index.html")).catch(error => {  
            console.error("Error loading file:", error);  
        });  

        win.on("closed", () => {  
            win = null;  
        });  
    } catch (error) {  
        console.error("Failed to create window:", error);  
    }  
}  

async function startServer(serverRoute) {  
    const command = `"${nodePathPc}" "C:/Users/pancho/Desktop/Laboratorio/server"`; // Comando completo  

    console.log("Starting server with command:", command);  

    serverProcess = exec(command, {   
        env: {  
            PORT: 600,  
            PG_DB_NAME: "lab",  
            PG_DB_HOST: "localhost",  
            PG_DB_PORT: 5432,  
            PG_DB_USER: "postgres",  
            PG_DB_PASSWORD: "admin",  
        },  
    }, (error, stdout, stderr) => {  
        if (error) {  
            console.error(`Error starting server: ${error.message}`);  
            return;  
        }  
        if (stderr) {  
            console.error(`stderr: ${stderr}`);  
            return;  
        }  
        console.log(`stdout: ${stdout}`);  
    });  
}  

async function stopServer() {  
    if (serverProcess) {  
        serverProcess.kill();  
        serverProcess = null;  
    }  
}  

app.whenReady().then(async () => {  
    const appPath = app.getAppPath();  
    const rootDir = path.join(appPath, "..", "..", "..", "..", "..");  
    const serverDir = path.join(rootDir, "server", "app.js");  

    if (!gotTheLock) {  
        app.quit();  
        return;  
    }  

    await startServer(serverDir);  
    createWindow();  
});  

app.on("window-all-closed", () => {  
    if (process.platform !== "darwin") {  
        app.quit();  
    }  
});  

app.on("activate", () => {  
    if (BrowserWindow.getAllWindows().length === 0) {  
        createWindow();  
    }  
});  

app.on("before-quit", async () => {  
    await stopServer();  
});