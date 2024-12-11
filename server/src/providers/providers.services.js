import providersRepository from './providers.repository.js'

const providersServices = {};

providersServices.readProviders = async () => {
    return await providersRepository.readProviders()
}
  
providersServices.readProviderByName = async name => {
    return await providersRepository.readProviderByName(name)
}

providersServices.createProvider = async (name) => {
    return await providersRepository.createProvider(name)
}

providersServices.updateProvider = async (id, answer) => {
    return await providersRepository.updateProvider(id, answer)
}

providersServices.deleteProvider = async id => {
    return await providersRepository.deleteProvider(id)
}

export default answerServices