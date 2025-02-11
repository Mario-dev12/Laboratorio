import profileServices from "./profile.services.js";

const profileController = {};

profileController.readProfiles = async (req, res) => {
	try {
		const answer = await profileServices.readProfiles();

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.readProfilesInputs = async (req, res) => {
	try {
		const answer = await profileServices.readProfilesInputs();

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.readInputsByProfile = async (req, res) => {
	try {
		const { id } = req.params;
		const answer = await profileServices.readInputsByProfile(id);

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.readInputsProfileByProfile = async (req, res) => {
	try {
		const { idCampo, idProfile } = req.params;
		const answer = await profileServices.readInputsProfileByProfile(idCampo, idProfile);

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.readProfilesUnits = async (req, res) => {
	try {
		const answer = await profileServices.readProfilesUnits();

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.readProfilesUnrepeated = async (req, res) => {
	try {
		const answer = await profileServices.readProfilesUnrepeated();

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.readProfileByType = async (req, res) => {
	try {
		const { type } = req.params;
		const answer = await profileServices.readProfileByType(type);

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.readInputsResults = async (req, res) => {
	try {
		const { name } = req.params;
		const answer = await profileServices.readInputsResults(name);

		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.createProfile = async (req, res) => {
	try {
		const answer = await profileServices.createProfile(req.body.name, req.body.cost_bs, req.body.cost_usd);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.createInputsInProfile = async (req, res) => {
	try {
		const answer = await profileServices.createInputsInProfile(req.body.idProfile, req.body.inputs);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.createProfileInputs = async (req, res) => {
	try {
		const answer = await profileServices.createProfileInputs(
			req.body.data.name,
			req.body.data.cost_bs,
			req.body.data.cost_usd,
			req.body.inputs
		);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.updateProfile = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await profileServices.updateProfile(id, req.body);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.message);
	}
};

profileController.updateInputs = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await profileServices.updateInputs(id, req.body);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.message);
	}
};

profileController.updateInputsProfile = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await profileServices.updateInputsProfile(id, req.body);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.message);
	}
};

profileController.deleteProfile = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await profileServices.deleteProfile(id);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.deleteInputs = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await profileServices.deleteInputs(id);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.deleteInputsInProfile = async (req, res) => {
	try {
		const answer = await profileServices.deleteInputsInProfile(req.body.idProfile, req.body.inputs);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.deleteInputsProfile = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await profileServices.deleteInputsProfile(id);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

export default profileController;
