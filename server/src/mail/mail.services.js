import mailRepository from './mail.repository.js'

const mailServices = {};

mailServices.sendMail = async (to, subject, text, attachment) => {
    return await mailRepository.sendMail(to, subject, text, attachment)
}

export default mailServices