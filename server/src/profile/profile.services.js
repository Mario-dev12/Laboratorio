import profileRepository from './profile.repository.js'

const profileServices = {};

function ordenarResultadosLaboratorio(data) {
    const ordenHematologia = [
      "hematies",
      "hemoglobina",
      "hematocrito",
      "chcm",
      "hcm",
      "vcm",
      "contaje de blancos",
      "segmentados",
      "linfocitos",
      "eosinofilos",
      "contaje de plaquetas",
    ];
 
    const ordenQuimicaSanguinea = [
      "glicemia basal",
      "urea",
      "creatinina",
      "acido urico",
      "transaminasa oxalacetica (ast)",
      "transaminasa piruvica (alt)",
      "colesterol",
      "trigliceridos",
      "hdl - colesterol",
      "ldl - colesterol",
      "lipidos totales",
      "calcio",
      "fosforo",
      "bilirrubina total",
      "bilirrubina directa",
      "bilirrubina indirecta",
      "proteinas totales",
      "albumina",
      "globulina",
      "rel a/g",
    ];

    const ordenVSG = [
      "1era Hora",
      "2da Hora",
      "indice",
    ]
 
    const normalizeString = (str) =>
      // Agregamos una comprobación para evitar errores si str es null o undefined
      str 
        ? str.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase()
        : "";
 
    for (const key in data) {
      if (data.hasOwnProperty(key)) {
        const normalizedKey = normalizeString(key);
        const resultados = data[key].resultado;
        
        // Si no hay resultados, saltamos a la siguiente iteración
        if (!resultados) {
            continue;
        }
 
        let ordenEspecifico;
 
        // Esta comparación es muy estricta, podría mejorarse si los nombres varían
        if (normalizedKey === "hematologia completa") {
          ordenEspecifico = ordenHematologia;
        } else if (normalizedKey === "quimica sanguinea") {
          ordenEspecifico = ordenQuimicaSanguinea;
        } else if(normalizedKey === "velocidad de sedimentacion globular (v.s.g)"){
            ordenEspecifico = ordenVSG;
        } else {
          continue;
        }
 
        const resultadosMap = new Map();
        resultados.forEach((item) => {
          resultadosMap.set(normalizeString(item.nombre), item);
        });
 
        const resultadosOrdenados = [];
        
        // ----- INICIO DE LA CORRECCIÓN -----
        ordenEspecifico.forEach((nombreEsperado) => {
          // 1. Normalizamos el nombre que estamos buscando para que coincida con la clave del mapa
          const normalizedNombreEsperado = normalizeString(nombreEsperado);
          
          // 2. Buscamos usando la clave ya normalizada
          if (resultadosMap.has(normalizedNombreEsperado)) {
            resultadosOrdenados.push(resultadosMap.get(normalizedNombreEsperado));
            resultadosMap.delete(normalizedNombreEsperado);
          }
        });
        // ----- FIN DE LA CORRECCIÓN -----
 
        // Los ítems que queden en el mapa no estaban en la lista de orden
        const resultadosNoEncontrados = [...resultadosMap.values()];
 
        data[key].resultado = resultadosOrdenados.concat(resultadosNoEncontrados);
      }
    }
 
    return data;
}

profileServices.readProfiles = async () => {
    return await profileRepository.readProfiles()
}

profileServices.readAllProfiles = async () => {
    return await profileRepository.readAllProfiles()
}

profileServices.readCultives = async () => {
    return await profileRepository.readCultives()
}

profileServices.readSpermiogram = async () => {
    return await profileRepository.readSpermiogram()
}

profileServices.readAntibiotics = async () => {
    return await profileRepository.readAntibiotics()
}

profileServices.readBacterium = async () => {
    return await profileRepository.readBacterium()
}

profileServices.readProfilesInputs = async () => {
    return await profileRepository.readProfilesInputs()
}

profileServices.readInputsByProfile = async id => {
    return await profileRepository.readInputsByProfile(id)
}

profileServices.readInputsProfileByProfile = async (idCampo, idProfile) => {
    return await profileRepository.readInputsProfileByProfile(idCampo, idProfile)
}

profileServices.readProfilesUnits = async () => {
    return await profileRepository.readProfilesUnits()
}

profileServices.readProfilesUnrepeated = async () => {
    return await profileRepository.readProfilesUnrepeated()
}

profileServices.readProfileByType = async name => {
    return await profileRepository.readProfileByType(name)
}

profileServices.readInputsResults = async name => {
    return await profileRepository.readInputsResults(name)
}

profileServices.readInputsbySectionName = async name => {
    return await profileRepository.readInputsbySectionName(name)
}

profileServices.readInputsResults2 = async (name, id) => {
    const resp =  await profileRepository.readInputsResults2(name, id)
    const respOrdenada = ordenarResultadosLaboratorio(resp);

    console.log('Full response:', JSON.stringify(respOrdenada, null, 2));

    return respOrdenada;
}

profileServices.readCultivesResult = async (id, name) => {
    return await profileRepository.readCultivesResult(id, name)
}

profileServices.readSpermiogramResult = async (id, name) => {
    return await profileRepository.readSpermiogramResult(id, name)
}

profileServices.createProfile = async (name, cost_bs, cost_usd, externo) => {
    return await profileRepository.createProfile(name, cost_bs, cost_usd, externo)
}

profileServices.createAntibiotics = async (name) => {
    return await profileRepository.createAntibiotics(name)
}

profileServices.createBacterium = async (name) => {
    return await profileRepository.createBacterium(name)
}

profileServices.createInputsInProfile = async (idProfile, inputs) => {
    return await profileRepository.createInputsInProfile(idProfile, inputs)
}

profileServices.createInputs = async (idProfile, inputs) => {
    return await profileRepository.createInputs(idProfile, inputs)
}

profileServices.createProfileInputs = async (name, cost_bs, cost_usd, externo, inputs, section) => {
    return await profileRepository.createProfileInputs(name, cost_bs, cost_usd, externo, inputs, section)
}

profileServices.createCultiveResult = async (idOrder, idBacteria, contaje, observacion, sensibles, resistentes) => {
    return await profileRepository.createCultiveResult(idOrder, idBacteria, contaje, observacion, sensibles, resistentes)
}

profileServices.createSpermiogramResult = async (id, answer) => {
    return await profileRepository.createSpermiogramResult(id, answer)
}

profileServices.createCultive = async (name, cost_bs, cost_usd, externo) => {
    return await profileRepository.createCultive(name, cost_bs, cost_usd, externo)
}

profileServices.createProfileSection = async (idProfile, section) => {
    const sectionArray = [section];
    return await profileRepository.createProfileSection(idProfile, sectionArray)
}

profileServices.updateProfileSection = async (id, answer) => {
    return await profileRepository.updateProfileSection(id, answer)
}

profileServices.createProfileSectionInputs = async (idProfile, nombre, inputs) => {
    return await profileRepository.createProfileSectionInputs(idProfile, nombre, inputs)
}

profileServices.updateProfile = async (id, answer) => {
    return await profileRepository.updateProfile(id, answer)
}

profileServices.updateAntibiotics = async (id, answer) => {
    return await profileRepository.updateAntibiotics(id, answer)
}

profileServices.updateBacterium = async (id, answer) => {
    return await profileRepository.updateBacterium(id, answer)
}

profileServices.updateCultive = async (id, answer) => {
    return await profileRepository.updateCultive(id, answer)
}

profileServices.updateInputs = async (id, answer) => {
    return await profileRepository.updateInputs(id, answer)
}

profileServices.updateInputsProfile = async (id, answer) => {
    return await profileRepository.updateInputsProfile(id, answer)
}

profileServices.deleteProfile = async id => {
    return await profileRepository.deleteProfile(id)
}

profileServices.deleteAntibiotics = async id => {
    return await profileRepository.deleteAntibiotics(id)
}

profileServices.deleteBacterium = async id => {
    return await profileRepository.deleteBacterium(id)
}

profileServices.deleteCultive = async id => {
    return await profileRepository.deleteCultive(id)
}

profileServices.deleteInputs = async id => {
    return await profileRepository.deleteInputs(id)
}

profileServices.deleteInputsInProfile = async (idProfile, idsArray) => {
    let input = [];
    let numerosComoCadenas = idsArray.split(",");

    for (let i = 0; i < numerosComoCadenas.length; i++) {
        input.push(Number(numerosComoCadenas[i]));
    }
    return await profileRepository.deleteInputsInProfile(Number(idProfile), input)
}

profileServices.deleteInputsProfile = async id => {
    return await profileRepository.deleteInputsProfile(id)
}

profileServices.deleteProfileSection = async (idProfile, nombre) => {
    return await profileRepository.deleteProfileSection(idProfile, nombre)
}

profileServices.deleteProfileSectionInputs = async (idProfile, nombre, idsArray) => {
    let input = [];
    let numerosComoCadenas = idsArray.split(",");

    for (let i = 0; i < numerosComoCadenas.length; i++) {
        input.push(Number(numerosComoCadenas[i]));
    }
    return await profileRepository.deleteProfileSectionInputs(Number(idProfile), nombre, input)
}

export default profileServices