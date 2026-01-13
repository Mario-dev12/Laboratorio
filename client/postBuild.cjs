const fs = require("fs");
const path = require("path");

const filePath = path.join(__dirname, "dist", "index.html");

fs.readFile(filePath, "utf8", (err, data) => {
	if (err) {
		console.error("Error al leer el archivo:", err);
		return;
	}

	// Expresiones regulares para capturar el contenido necesario
	const baseHrefReplace = /<base href="\/" \/>/;
	const legacyChunkRegex =
		/<script nomodule crossorigin id="vite-legacy-entry" data-src="(.*?\/assets\/index-legacy-)(.*?)">.*?<\/script>/; // Captura el <script>
	const cssFileRegex = /<link rel="stylesheet" crossorigin href="(.*?)\/assets\/index-DR98lWJv\.css">/;

	// Captura el nuevo nombre del archivo legacy
	const legacyChunkMatch = data.match(legacyChunkRegex);
	const cssFileMatch = data.match(cssFileRegex);

	// Construir los nuevos vínculos para el CSS y el script legado
	const newLegacyChunk = legacyChunkMatch
		? `<script nomodule crossorigin id="vite-legacy-entry" src="${legacyChunkMatch[1]}${legacyChunkMatch[2]}">System.import(document.getElementById('vite-legacy-entry').getAttribute('data-src'))</script>`
		: "";
	const newCssFile = cssFileMatch
		? `<link rel="stylesheet" crossorigin href="${path.resolve(
				__dirname,
				"dist",
				cssFileMatch[1] + "/assets/index-DR98lWJv.css"
		  )}">`
		: "";

	// Crear el nuevo contenido con el nuevo enlace CSS dinámico
	let result = data // Cambiar a let aquí
		.replace(baseHrefReplace, '<base href="./" />')
		.replace(legacyChunkRegex, newLegacyChunk) // Reemplazo del script
		.replace(cssFileRegex, `$&\n${newCssFile}`); // Agregar primer nuevo link de CSS

	// Añadir rutas completas de nuevos archivos CSS
	const dynamicCssRegex = /<link rel="stylesheet" crossorigin href="(.*?)\/assets\/index-([A-Za-z0-9]+)\.css">/g; // Matcher para el nuevo archivo CSS
	let match;
	while ((match = dynamicCssRegex.exec(data)) !== null) {
		const originalHref = match[0];
		const fileName = match[2]; // Captura el nombre dinámico del archivo
		const dynamicPath = path.resolve(__dirname, "dist", `assets/index-${fileName}.css`); // Construir la ruta dinámica
		const newDynamicLink = `<link rel="stylesheet" crossorigin href="${dynamicPath}">`;
		result = result.replace(originalHref, `${originalHref}\n${newDynamicLink}`);
	}

	fs.writeFile(filePath, result, "utf8", (err) => {
		if (err) {
			console.error("Error al escribir el archivo:", err);
		}
	});
});
