import nodemailer from 'nodemailer';

const mailRepository = {};

mailRepository.sendMail = async (provider, userEmail, userPassword, pdfPath, destinatario) => {
  let transporter;  

    switch (provider) {  
        case 'gmail':  
            transporter = nodemailer.createTransport({  
                service: 'gmail',  
                auth: { user: userEmail, pass: userPassword },  
            });  
            break;  
        case 'hotmail':  
            transporter = nodemailer.createTransport({  
                service: 'hotmail',  
                auth: { user: userEmail, pass: userPassword },  
            });  
            break;  
        case 'yahoo':  
            transporter = nodemailer.createTransport({  
                service: 'yahoo',  
                auth: { user: userEmail, pass: userPassword },  
            });  
            break;  
        default:  
            throw new Error('Proveedor no soportado');  
    }  

    const mailOptions = {  
        from: userEmail,  
        to: destinatario,  
        subject: 'Resultados de tu análisis',  
        text: 'Adjunto encontrarás los resultados de tu análisis.',  
        attachments: [{ filename: 'resultado.pdf', path: pdfPath }],  
    };  

    await transporter.sendMail(mailOptions);  
    
    return 'Correo enviado exitosamente';
}

export default mailRepository