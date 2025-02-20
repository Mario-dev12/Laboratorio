import mailRepository from './mail.repository.js'

const mailServices = {};

mailServices.sendMail = async (provider, userEmail, userPassword, pdfPath, destinatario) => {
    return await mailRepository.sendMail(provider, userEmail, userPassword, pdfPath, destinatario)
}

export default mailServices