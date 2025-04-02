import profileRepository from './profile.repository.js'

const profileServices = {};

profileServices.readProfiles = async () => {
    return await profileRepository.readProfiles()
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
    return await profileRepository.readInputsResults2(name, id)
}

profileServices.createProfile = async (name, cost_bs, cost_usd) => {
    return await profileRepository.createProfile(name, cost_bs, cost_usd)
}

profileServices.createInputsInProfile = async (idProfile, inputs) => {
    return await profileRepository.createInputsInProfile(idProfile, inputs)
}

profileServices.createInputs = async (idProfile, inputs) => {
    return await profileRepository.createInputs(idProfile, inputs)
}

profileServices.createProfileInputs = async (name, cost_bs, cost_usd, inputs, section) => {
    return await profileRepository.createProfileInputs(name, cost_bs, cost_usd, inputs, section)
}

profileServices.createProfileSection = async (idProfile, section) => {
    const sectionArray = [section];
    return await profileRepository.createProfileSection(idProfile, sectionArray)
}

profileServices.createProfileSectionInputs = async (idProfile, nombre, inputs) => {
    return await profileRepository.createProfileSectionInputs(idProfile, nombre, inputs)
}

profileServices.updateProfile = async (id, answer) => {
    return await profileRepository.updateProfile(id, answer)
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