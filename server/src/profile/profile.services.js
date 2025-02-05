import profileRepository from './profile.repository.js'

const profileServices = {};

profileServices.readProfiles = async () => {
    return await profileRepository.readProfiles()
}

profileServices.readProfilesInputs = async () => {
    return await profileRepository.readProfilesInputs()
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

profileServices.deleteProfile = async id => {
    return await profileRepository.deleteProfile(id)
}

export default profileServices