const fs = require("fs");
const path = require("path");

const filePath = path.join(__dirname, "dist", "index.html");

fs.readFile(filePath, "utf8", (err, data) => {
	if (err) {
		console.error("Error al leer el archivo:", err);
		return;
	}
	const result = data
		.replace(/<base href="\/" \/>/, '<base href="./" />')
		.replace(
			/(<script nomodule crossorigin id="vite-legacy-entry" data-src=")(\.\/assets\/index-legacy-)/,
			"./dist/assets/index-legacy-"
		)
		// Agregar la nueva línea con la ruta del CSS
		.replace(
			/(<link rel="stylesheet" crossorigin href=".\/assets\/index-DR98lWJv.css">)/,
			`\$1\n<link rel="stylesheet" crossorigin href="C:/Users/pancho/Desktop/Laboratorio/client/dist/assets/index-DR98lWJv.css">`
		)
		// Corrección de la etiqueta <script>
		.replace(
			/.\/dist\/assets\/index-legacy-hwQ9gVz3\.js">System.import\(document\.getElementById\('vite-legacy-entry'\)\.getAttribute\('data-src'\)\)/,
			"<script nomodule crossorigin id=\"vite-legacy-entry\" src=\"./assets/index-legacy-hwQ9gVz3.js\">System.import(document.getElementById('vite-legacy-entry').getAttribute('data-src'))</script>"
		);

	fs.writeFile(filePath, result, "utf8", (err) => {
		if (err) {
			console.error("Error al escribir el archivo:", err);
		}
	});
});
