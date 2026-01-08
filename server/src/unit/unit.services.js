import unitRepository from './unit.repository.js'

const unitServices = {};

unitServices.readUnits = async () => {
    return await unitRepository.readUnits()
}
  
unitServices.readUnitByName = async name => {
    return await unitRepository.readUnitByName(name)
}

unitServices.createUnit = async (name, idProfile) => {
    return await unitRepository.createUnit(name, idProfile)
}

unitServices.updateUnit = async (id, answer) => {
    return await unitRepository.updateUnit(id, answer)
}

unitServices.deleteUnit = async id => {
    return await unitRepository.deleteUnit(id)
}

export default unitServices