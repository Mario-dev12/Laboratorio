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

profileServices.createProfile = async (name, cost_bs, cost_usd) => {
    return await profileRepository.createProfile(name, cost_bs, cost_usd)
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

profileServices.deleteInputsProfile = async id => {
    return await profileRepository.deleteInputsProfile(id)
}

export default profileServices