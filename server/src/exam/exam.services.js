import examRepository from './exam.repository.js'

const examServices = {};

examServices.readExams = async () => {
    return await examRepository.readExams()
}

examServices.readExamByType = async name => {
    return await examRepository.readExamByType(name)
}

examServices.createExam = async (name, cost_bs, cost_usd, status, idUser) => {
    return await examRepository.createExam(name, cost_bs, cost_usd, status, idUser)
}

examServices.updateExam = async (id, answer) => {
    return await examRepository.updateExam(id, answer)
}

examServices.deleteExam = async id => {
    return await examRepository.deleteExam(id)
}

export default examServices