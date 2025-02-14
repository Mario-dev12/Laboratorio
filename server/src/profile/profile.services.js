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

profileServices.createProfile = async (name, cost_bs, cost_usd) => {
    return await profileRepository.createProfile(name, cost_bs, cost_usd)
}

profileServices.createInputsInProfile = async (idProfile, inputs) => {
    return await profileRepository.createInputsInProfile(idProfile, inputs)
}

profileServices.createInputs = async (idProfile, inputs) => {
    return await profileRepository.createInputs(idProfile, inputs)
}

profileServices.createProfileInputs = async (name, cost_bs, cost_usd, inputs) => {
    return await profileRepository.createProfileInputs(name, cost_bs, cost_usd, inputs)
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

export default profileServices