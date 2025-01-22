import examRepository from './exam.repository.js'

const examServices = {};

examServices.readExams = async () => {
    return await examRepository.readExams()
}

examServices.createExam = async (idUser, total_cost_bs, total_cost_usd) => {
    return await examRepository.createExam(idUser, total_cost_bs, total_cost_usd)
}

examServices.updateExam = async (id, answer) => {
    return await examRepository.updateExam(id, answer)
}

examServices.deleteExam = async id => {
    return await examRepository.deleteExam(id)
}

export default examServices