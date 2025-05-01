import { app, BrowserWindow } from "electron";
import path from "path";
import { fileURLToPath } from "url";
import { spawn } from "child_process";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const distFolder = path.join(__dirname, "dist/index.html");
const assetPathJs = path.join(__dirname, "dist/assets/index-B34d1c8P.js");
let serverProcess;
const rootDir = path.join(__dirname, "..");
const serverDir = path.join(rootDir, "server", "app.js");
const nodePath = process.execPath;
const gotTheLock = app.requestSingleInstanceLock();
let win;

console.log(serverDir);

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

function startServer() {
	serverProcess = spawn(nodePath, [serverDir], {
		stdio: "inherit",
	});

	serverProcess.on("error", (err) => {
		console.error("Failed to start server:", err);
	});
}

function stopServer() {
	if (serverProcess) {
		serverProcess.kill();
		serverProcess = null;
	}
}

app.whenReady().then(() => {
	if (!gotTheLock) {
		app.quit();
		return;
	}
	createWindow();
	startServer();
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
