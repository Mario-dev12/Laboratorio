import { app, BrowserWindow } from "electron";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const distFolder = path.join(__dirname, "dist/index.html");
console.log(distFolder);
const assetPathJs = path.join(__dirname, "dist/assets/index-B34d1c8P.js");
console.log(assetPathJs);

function createWindow() {
	try {
		const win = new BrowserWindow({
			width: 800,
			height: 600,
			webPreferences: {
				nodeIntegration: true,
				contextIsolation: false,
				enableRemoteModule: true, // Enable the remote module
				webSecurity: true,
			},
		});
		win.loadFile(distFolder).catch((error) => {
			console.log(distFolder);
			console.error("Error loading file:", error);
		});
	} catch (error) {
		console.error("Failed to create window:", error);
	}
}

app.whenReady().then(createWindow);

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
