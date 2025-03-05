import mailServices from './mail.services.js'

const mailController = {};

mailController.sendMail = async (req, res) => {
    try {
      const { to, subject, text, attachment } = req.body;
      
      const answer = await mailServices.sendMail(to, subject, text, attachment);
  
      res.send(answer)
    } catch (error) {
      return res.status(400).send(error.stack)
    }
}

export default mailController