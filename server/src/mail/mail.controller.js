import mailServices from './mail.services.js'

const mailController = {};

mailController.sendMail = async (req, res) => {
    try {
      const { provider, userEmail, userPassword, pdfPath, destinatario } = req.body; 
      
      const answer = await mailServices.sendMail(provider, userEmail, userPassword, pdfPath, destinatario);
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

export default mailController