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
        "fibrinógeno",
        "grupo sanguíneo",
        "rh"
    ];

    const ordenQuimicaSanguinea = [
        "glicemia basal",
        "urea",
        "creatinina",
        "ácido úrico",
        "transaminasa oxalacética (ast)",
        "transaminasa pirúvica (alt)",
        "colesterol",
        "triglicéridos",
        "hdl - colesterol",
        "ldl - colesterol",
        "vldl",
        "lipidos totales",
        "calcio",
        "fósforo",
        "bilirrubina total",
        "bilirrubina directa",
        "bilirrubina indirecta",
        "proteínas totales",
        "albúmina",
        "globulina",
        "rel a/g",
        "glicemia postpandrial",
        "fosfatasa alcalina",
        "ldh",
        "hierro sérico",
        "cpk",
        "cpk mb",
        "hemoglobina glicosilada (hba1c)",
        "ggtp",
        "amilasa",
        "magnesio",
        "lipasa"
    ];

    const ordenUroanalisisFisico = [
        "cantidad",
        "color",
        "olor",
        "reacción",
        "aspecto",
        "densidad",
        "ph"
    ];

    const ordenUroanalisisQuimico = [
        "proteínas - orina",
        "glucosa",
        "hemoglobina - orina",
        "cuerpos cetónicos",
        "bilirrubina - orina",
        "urobilinógeno",
        "nitritos",
        "leucocitos"
    ];

    const ordenUroanalisisMicroscopico = [
        "células epiteliales",
        "leucocitos",
        "hematies - orina",
        "bacterias",
        "filamento de mucina",
        "cristales",
        "células redondas",
        "conidias",
        "blastoconidias"
    ];


    const ordenVSG = ["1era hora", "2da hora", "índice"];

    const normalizeString = (str) =>
        str ? str.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().trim() : "";

    const dataOrdenada = {};

    for (const key in data) {
        if (data.hasOwnProperty(key) && data[key].resultado && Array.isArray(data[key].resultado)) {
            let resultados = data[key].resultado;

            const uniqueResultadosMap = new Map();
            resultados.forEach((item) => {
                const normalizedItemName = normalizeString(item.nombre);
                if (!uniqueResultadosMap.has(normalizedItemName)) {
                    uniqueResultadosMap.set(normalizedItemName, item);
                }
            });
            let resultadosUnicos = [...uniqueResultadosMap.values()];

            const normalizedKey = normalizeString(key);
            let ordenEspecifico = [];

            if (normalizedKey === "hematologia completa") {
                ordenEspecifico = ordenHematologia;
            } else if (normalizedKey === "quimica sanguinea") {
                ordenEspecifico = ordenQuimicaSanguinea;
            } else if (normalizedKey === "uroanalisis - analisis fisico") {
                ordenEspecifico = ordenUroanalisisFisico;
            } else if (normalizedKey === "uroanalisis - analisis quimico") {
                ordenEspecifico = ordenUroanalisisQuimico;
            } else if (normalizedKey === "uroanalisis - analisis microscopico") {
                ordenEspecifico = ordenUroanalisisMicroscopico;
            } else if (normalizedKey === "velocidad de sedimentacion globular (v.s.g)") {
                ordenEspecifico = ordenVSG;
            }

            const resultadosMapParaOrden = new Map();
            resultadosUnicos.forEach((item) => {
                resultadosMapParaOrden.set(normalizeString(item.nombre), item);
            });

            const resultadosOrdenados = [];
            ordenEspecifico.forEach((nombreEsperado) => {
                const normalizedNombreEsperado = normalizeString(nombreEsperado);
                if (resultadosMapParaOrden.has(normalizedNombreEsperado)) {
                    resultadosOrdenados.push(resultadosMapParaOrden.get(normalizedNombreEsperado));
                    resultadosMapParaOrden.delete(normalizedNombreEsperado);
                }
            });

            const resultadosNoEncontrados = [...resultadosMapParaOrden.values()];
            
            dataOrdenada[key] = {
                ...data[key],
                resultado: resultadosOrdenados.concat(resultadosNoEncontrados)
            };

        } else {
            dataOrdenada[key] = data[key];
        }
    }

    return dataOrdenada;
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
    const resp = await profileRepository.readInputsResults2(name, id);
    const respOrdenada = ordenarResultadosLaboratorio(resp);
    
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