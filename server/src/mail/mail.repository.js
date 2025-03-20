const mailRepository = {};

import nodemailer from "nodemailer";
import fs from "fs";
import path from "path";
import os from "os";

mailRepository.sendMail = async (to, subject, body, attachment, htmlContent = "") => {
	const transporter = nodemailer.createTransport({
		service: "gmail",
		auth: {
			user: "francorm007@gmail.com",
			pass: "",
		},
	});

	const downloadsPath = path.join(os.homedir(), "Downloads");
	const pdfFilename = attachment;
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

	transporter.sendMail(mailOptions, function (error, info) {
		if (error) {
			console.log(error);
		} else {
			console.log("Email sent: " + info.response);
		}
	});
};

export default mailRepository;