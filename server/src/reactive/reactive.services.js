import reactiveRepository from './reactive.repository.js'

const reactiveServices = {};

reactiveServices.readReactives = async () => {
    return await reactiveRepository.readReactives()
}
  
reactiveServices.readReactiveByName = async name => {
    return await reactiveRepository.readReactiveByName(name)
}

reactiveServices.createReactive = async (name, quantity, idExam) => {
    return await reactiveRepository.createReactive(name, quantity, idExam)
}

reactiveServices.updateReactive = async (id, answer) => {
    return await reactiveRepository.updateReactive(id, answer)
}

reactiveServices.deleteReactive = async id => {
    return await reactiveRepository.deleteReactive(id)
}

export default reactiveServices