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
    const answer = await profileServices.readProfilesInputs()

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

profileController.readProfilesUnits = async (req, res) => {
  try {
    const answer = await profileServices.readProfilesUnits()

    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

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

profileController.createProfile = async (req, res) => {
	try {
		const answer = await profileServices.createProfile(req.body.name, req.body.cost_bs, req.body.cost_usd);
		res.send(answer);
	} catch (error) {
		return res.status(400).send(error.stack);
	}
};

profileController.createProfileInputs = async (req, res) => {
  try {
    const answer = await profileServices.createProfileInputs(req.body.name, req.body.cost_bs, req.body.cost_usd, req.body.inputs)
    res.send(answer)
  } catch (error) {
    return res.status(400).send(error.stack)
  }
}

profileController.updateProfile = async (req, res) => {
	const { id } = req.params;

	try {
		const answer = await profileServices.updateProfile(id, req.body);
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

export default profileController;
