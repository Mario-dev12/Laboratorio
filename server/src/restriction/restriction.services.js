import restrictionRepository from './restriction.repository.js'

const restrictionServices = {};

restrictionServices.readRestrictions = async () => {
    return await restrictionRepository.readRestrictions()
}
  
restrictionServices.readRestrictionByProfile = async id => {
    return await restrictionRepository.readRestrictionByProfile(id)
}

restrictionServices.createRestriction = async (idProfile, restriction) => {
    return await restrictionRepository.createRestriction(idProfile, restriction)
}

restrictionServices.updateRestriction = async (id, answer) => {
    return await restrictionRepository.updateRestriction(id, answer)
}

restrictionServices.deleteRestriction = async id => {
    return await restrictionRepository.deleteRestriction(id)
}

export default restrictionServices