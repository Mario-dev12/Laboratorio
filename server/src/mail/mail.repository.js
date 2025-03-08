import env from "../utils/environment.js";

const mailRepository = {};

import nodemailer from "nodemailer";
import fs from "fs";
import path from "path";
import os from "os";

mailRepository.sendMail = async (to, subject, body, attachment, htmlContent = "") => {
	const apiKey = env.ELASTIC_EMAIL_API_KEY;

	// const transporter = nodemailer.createTransport({
	// 	host: "smtp.elasticemail.com",
	// 	port: 2525, // o 587
	// 	secure: false,
	// 	auth: {
	// 		user: "mario12dev@gmail.com",
	// 		pass: apiKey,
	// 	},
	// });

	// const mailOptions = {
	// 	from: "mario12dev@gmail.com",
	// 	to: to,
	// 	subject: subject,
	// 	text: body,
	// 	html: htmlContent || body,
	// };

	const transporter = nodemailer.createTransport({
		service: "gmail",
		auth: {
			user: "francorm007@gmail.com",
			pass: "",
		},
	});

	console.log("this is the pdf name", attachment);

	const downloadsPath = path.join(os.homedir(), "Downloads"); // Get the user's home directory
	const pdfFilename = attachment; // Replace with the actual file name
	const pdfPath = path.join(downloadsPath, pdfFilename);

	if (fs.existsSync(pdfPath)) {
		console.log(pdfPath);
	}

	const pdfData = fs.readFileSync(pdfPath);

	const mailOptions = {
		from: "francorm007@gmail.com",
		to: to,
		subject: subject,
		text: body,
		attachments: [
			{
				filename: pdfFilename,
				content: pdfData,
				contentType: "application/pdf",
			},
		],
	};

	// if (attachment) {
	// 	mailOptions.attachments = [
	// 		{
	// 			filename: attachment.filename,
	// 			content: attachment.content,
	// 			contentType: attachment.contentType,
	// 		},
	// 	];
	// }

	transporter.sendMail(mailOptions, function (error, info) {
		if (error) {
			console.log(error);
		} else {
			console.log("Email sent: " + info.response);
		}
	});

	// try {
	// 	const info = await transporter.sendMail(mailOptions);
	// 	return { status: 200, message: "Correo enviado", response: info };
	// } catch (error) {
	// 	console.error("Error enviando el correo:", error);
	// 	throw new Error("Error al enviar el correo: " + (error.message || "Error desconocido"));
	// }
};

export default mailRepository;

/*
import axios from 'axios';
import env from '../utils/environment.js';

const mailRepository = {};

mailRepository.sendMail = async (to, subject, body, attachment) => {
    const apiKey = env.ELASTIC_EMAIL_API_KEY_HTTP;
    const url = 'https://api.elasticemail.com/v4/emails';

    const params = {
        apiKey: apiKey,
        to: to,
        subject: subject,
        body: body,
        from: 'mario12dev@gmail.com',
    };

    // Intentar enviar el correo principal
    try {
        // Manejo de adjuntos
        if (attachment) {
            // Agregar el adjunto a la solicitud
            params.attachments = [
                {
                    filename: attachment.filename,
                    content: attachment.content,
                    contentType: attachment.contentType,
                },
            ];

            // Enviar el correo con el adjunto
            const attachmentResponse = await axios.post(url, null, { params });
            return { status: 200, message: 'Correo enviado con adjunto', response: attachmentResponse.data };
        }  else {
            const response = await axios.post(url, null, { params });
            return { status: 200, message: 'Correo enviado', response: response.data };
        }

    } catch (error) {
        // Lanza un error para manejarlo en el endpoint
        console.error('Error enviando el correo:', error.response ? error.response.data : error.message);
        throw new Error(error.response ? error.response.data : 'Error al enviar el correo');
    }
};

export default mailRepository;
*/

/*import env from '../utils/environment.js';

import ElasticEmail from '@elasticemail/elasticemail-client';

let defaultClient = ElasticEmail.ApiClient.instance;

let apikey = defaultClient.authentications['apikey'];
apikey.apiKey = env.ELASTIC_EMAIL_API_KEY_HTTP

let api = new ElasticEmail.EmailsApi()

const mailRepository = {};

import nodemailer from 'nodemailer';

mailRepository.sendMail = async (to, subject, text, attachment) => {
    let defaultClient = ElasticEmail.ApiClient.instance;

    let apikey = defaultClient.authentications['apikey'];
    apikey.apiKey = env.ELASTIC_EMAIL_API_KEY_HTTP

    let api = new ElasticEmail.EmailsApi()

    let email = ElasticEmail.EmailMessageData.constructFromObject({
        Recipients: [
          new ElasticEmail.EmailRecipient("mario12dev@gmail.com")
        ],
        Content: {
          Body: [
            ElasticEmail.BodyPart.constructFromObject({
              ContentType: "HTML",
              Content: "My test email content ;)"
            })
          ],
          Subject: "JS EE lib test",
          From: "mario12dev@gmail.com"
        }
      });

      var callback = function(error, data, response) {
        if (error) {
          console.error(error);
        } else {
          console.log('API called successfully.');
        }
      };

      api.emailsPost(email, callback);
};  */

/*import env from '../utils/environment.js';

import ElasticEmail from '@elasticemail/elasticemail-client';

const mailRepository = {};

mailRepository.sendMail = async (to, subject, text, attachment) => {
    const client = ElasticEmail.ApiClient.instance;

    const apikey = client.authentications['apikey'];
    apikey.apiKey = env.ELASTIC_EMAIL_API_KEY_HTTP;

    const emailsApi = new ElasticEmail.EmailsApi();

    const emailData = {
        Recipients: {
            To: ["mario12dev@gmail.com"]
        },
        Content: {
            Body: [
                {
                    ContentType: "HTML",
                    Charset: "utf-8",
                    Content: "Mail content."
                },
                {
                    ContentType: "PlainText",
                    Charset: "utf-8",
                    Content: "Mail content."
                }
            ],
            From: "mario12dev@gmail.com",
            Subject: "Example transactional email"
        }
    };

    const callback = (error, data, response) => {
        if (error) {
            console.error(error);
        } else {
            console.log('API called successfully.');
            console.log('Email sent.');
        }
    };

    emailsApi.emailsTransactionalPost(emailData, callback);

}


export default mailRepository;
*/

/*import EmailClient  from 'elasticemail-webapiclient';
import env from '../utils/environment.js';

const mailRepository = {};

mailRepository.sendMail = async ({ to, from, subject, message }) => {
    const elasticEmailClient = new EmailClient(env.ELASTIC_EMAIL_API_KEY_HTTP);

    const emailData = {
        to: [{ email: to }],
        from: { email: from },
        subject: subject,
        body: message,
    };

    try {
        const response = await elasticEmailClient.Email.Send(emailData);

        console.log('Email sent successfully:', response);
        return response;
    } catch (error) {
        console.error('Error sending email:', error);
        throw error;
    }
}

export default mailRepository;*/

/*import ElasticEmail from '@elasticemail/elasticemail-client';
import env from '../utils/environment.js';

const mailRepository = {};

mailRepository.sendMail = async (to, subject, text, attachment) => {
    const client = ElasticEmail.ApiClient.instance;
    const apikey = client.authentications['apikey'];
    apikey.apiKey = env.ELASTIC_EMAIL_API_KEY_HTTP;

    const emailsApi = new ElasticEmail.EmailsApi();

    const emailData = {
        Recipients: [
            {
                Email: to,
                Fields: {
                    city: "New York",
                    age: "34"
                }
            }
        ],
        Content: {
            Body: [
                {
                    ContentType: "HTML",
                    Content: `<p>${text}</p>`, // Mensaje en HTML
                    Charset: "utf-8"
                },
                {
                    ContentType: "PlainText",
                    Content: text, // Mensaje en texto plano
                    Charset: "utf-8"
                }
            ],
            From: "mario12dev@gmail.com",
            Subject: subject,
            // Eliminar Attachments si no hay archivos adjuntos
            Attachments: attachment ? [
                {
                    BinaryContent: attachment.binaryContent, // Aquí deberías proporcionar el contenido binario del archivo
                    Name: attachment.name, // Nombre del archivo
                    ContentType: attachment.contentType, // Tipo de contenido del archivo
                    Size: attachment.size // Tamaño del archivo
                }
            ] : []
        },
        Options: {
            TrackOpens: true,
            TrackClicks: true,
            PoolName: "My Custom Pool",
            ChannelName: "Channel01"
        }
    };

    const callback = (error, data, response) => {
        if (error) {
            console.error('Error al enviar el correo:', error);
        } else {
            console.log('Correo enviado con éxito:', data);
        }
    };

    emailsApi.emailsTransactionalPost(emailData, callback);
};

export default mailRepository;
*/

/*import env from '../utils/environment.js';

import ElasticEmail from '@elasticemail/elasticemail-client';

const mailRepository = {};

mailRepository.sendMail = async (to, subject, text, attachment) => {
    let defaultClient = ElasticEmail.ApiClient.instance;

    let apikey = defaultClient.authentications['apikey'];
    apikey.apiKey = env.ELASTIC_EMAIL_API_KEY_HTTP

    let api = new ElasticEmail.EmailsApi()

    const emailData = {
        Recipients: {
            To: ["mario12dev@gmail.com"]
        },
        Content: {
            Body: [
                {
                    ContentType: "HTML",
                    Charset: "utf-8",
                    Content: "Hi you name"
                }
            ],
            From: "maavena.17@est.ucab.edu.ve",
            Subject: "Example email"
        }
    };
    const callback = (error, data, response) => {
        if (error) {
            console.error(error);
           // res.status(200).json({success:error});
        } else {
            console.log('API called successfully.');
            console.log('Email sent.');
            //res.status(200).json({success:"done"});
        }
    };

      api.emailsTransactionalPost(emailData,callback);
};

export default mailRepository;
*/

// import { MailerSend, EmailParams, Sender, Recipient } from "mailersend";
// import env from "../utils/environment.js";

// const mailRepository = {};

// mailRepository.sendMail = async (to, subject, text, attachment) => {
// 	const mailerSend = new MailerSend({
// 		apiKey: env.ELASTIC_EMAIL_API_KEY_HTTP,
// 	});

// 	const sentFrom = new Sender("tucorreo@trial-jpzkmgq1x5ml059v.mlsender.net", "Your name");

// 	const recipients = [
// 		new Recipient(to, "Your Client"), // Asegúrate de usar el parámetro `to`
// 	];

// 	const emailParams = new EmailParams()
// 		.setFrom(sentFrom)
// 		.setTo(recipients)
// 		.setReplyTo(sentFrom)
// 		.setSubject(subject) // Usa el parámetro `subject`
// 		.setHtml("<strong>" + text + "</strong>") // Usa el parámetro `text`
// 		.setText(text);

// 	try {
// 		const response = await mailerSend.email.send(emailParams);
// 		console.log("Email enviado: ", response);
// 	} catch (error) {
// 		console.error("Error enviando el email: ", error);
// 	}
// };
// export default mailRepository;
