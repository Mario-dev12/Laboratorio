import { app, BrowserWindow } from "electron";
import path from "path";
import { fileURLToPath } from "url";
import { spawn } from "child_process";
import * as dotenv from "dotenv";

dotenv.config();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const distFolder = path.join(__dirname, "dist/index.html");
let serverProcess;
const nodePathPc = "C:/Program Files/nodejs/node.exe";
const gotTheLock = app.requestSingleInstanceLock();
let win;

function createWindow() {
	try {
		if (win) {
			win.focus();
			return;
		}

		win = new BrowserWindow({
			width: 800,
			height: 600,
			webPreferences: {
				nodeIntegration: true,
				contextIsolation: false,
				enableRemoteModule: true,
				webSecurity: true,
			},
		});
		win.loadFile(distFolder).catch((error) => {
			console.error("Error loading file:", error);
		});

		win.on("closed", () => {
			win = null;
		});
	} catch (error) {
		console.error("Failed to create window:", error);
	}
}

function startServer(serverRoute) {
	try {
		console.log("connecting to my server");
		serverProcess = spawn(nodePathPc, [serverRoute], {
			stdio: "inherit",
			detached: true,
			windowsHide: true,
			env: {
				PORT: 3000,
				PG_DB_NAME: "Laboratorio",
				PG_DB_HOST: "localhost",
				PG_DB_PORT: 5432,
				PG_DB_USER: "postgres",
				PG_DB_PASSWORD: "realmadrid",
			},
		});

		serverProcess.on("error", (err) => {
			console.error("Failed to start server:", err);
		});
	} catch (error) {
		console.log("couldn't connect to server", error);
	}
}

function stopServer() {
	if (serverProcess) {
		serverProcess.kill();
		serverProcess = null;
	}
}

app.whenReady().then(() => {
	const appPath = app.getAppPath();
	const rootDir = path.join(appPath, "..", "..", "..", "..", "..");
	const serverDir = path.join(rootDir, "server", "app.js");

	if (!gotTheLock) {
		app.quit();
		return;
	}

	createWindow();

	startServer(serverDir);
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

app.on("before-quit", () => {
	stopServer();
});
