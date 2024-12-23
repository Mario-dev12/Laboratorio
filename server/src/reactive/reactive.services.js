import reactiveRepository from './reactive.repository.js'

const reactiveServices = {};

reactiveServices.readReactives = async () => {
    return await reactiveRepository.readReactives()
}

reactiveServices.readReactivesQuantity = async () => {
    return await reactiveRepository.readReactivesQuantity()
}
  
reactiveServices.readReactiveByName = async name => {
    return await reactiveRepository.readReactiveByName(name)
}

reactiveServices.readReactivesByProvider = async () => {
    return await reactiveRepository.readReactivesByProvider()
}

reactiveServices.createReactive = async (name) => {
    return await reactiveRepository.createReactive(name)
}

reactiveServices.updateReactive = async (id, answer) => {
    return await reactiveRepository.updateReactive(id, answer)
}

reactiveServices.deleteReactive = async id => {
    return await reactiveRepository.deleteReactive(id)
}

export default reactiveServices