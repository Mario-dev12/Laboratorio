import reactiveRepository from './reactive.repository.js'

const reactiveServices = {};

reactiveServices.readReactives = async () => {
    return await reactiveRepository.readReactives()
}

reactiveServices.readCampo = async () => {
    return await reactiveRepository.readCampo()
}

reactiveServices.readReactivesQuantity = async () => {
    return await reactiveRepository.readReactivesQuantity()
}
  
reactiveServices.readReactiveByName = async (name) => {
    return await reactiveRepository.readReactiveByName(name)
}

reactiveServices.readReactivesByProvider = async () => {
    return await reactiveRepository.readReactivesByProvider()
}

reactiveServices.createReactive = async (name, total) => {
    return await reactiveRepository.createReactive(name, total)
}

reactiveServices.updateReactive = async (id, answer) => {
    return await reactiveRepository.updateReactive(id, answer)
}

reactiveServices.updateCampo = async (id, answer) => {
    return await reactiveRepository.updateCampo(id, answer)
}

reactiveServices.deleteReactive = async id => {
    return await reactiveRepository.deleteReactive(id)
}

reactiveServices.deleteCampo = async id => {
    return await reactiveRepository.deleteCampo(id)
}

export default reactiveServices