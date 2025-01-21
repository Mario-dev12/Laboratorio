import profileRepository from './profile.repository.js'

const profileServices = {};

profileServices.readProfiles = async () => {
    return await profileRepository.readProfiles()
}

profileServices.readProfilesUnrepeated = async () => {
    return await profileRepository.readProfilesUnrepeated()
}

profileServices.readProfileByType = async name => {
    return await profileRepository.readProfileByType(name)
}

profileServices.createProfile = async (name, cost_bs, cost_usd, status) => {
    return await profileRepository.createProfile(name, cost_bs, cost_usd, status)
}

profileServices.updateProfile = async (id, answer) => {
    return await profileRepository.updateProfile(id, answer)
}

profileServices.deleteProfile = async id => {
    return await profileRepository.deleteProfile(id)
}

export default profileServices