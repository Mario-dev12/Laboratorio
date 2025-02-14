import express from "express";
const profileRouter = express.Router();
import profileController from "./profile.controller.js";

// Profile
profileRouter.get("/", profileController.readProfiles);
profileRouter.get("/unrepeated", profileController.readProfilesUnrepeated);
profileRouter.get("/type/:type", profileController.readProfileByType);
profileRouter.post("/", profileController.createProfile);
profileRouter.put("/:id", profileController.updateProfile);
profileRouter.delete("/:id", profileController.deleteProfile);

//Inputs
profileRouter.get("/input", profileController.readProfilesInputs);
profileRouter.get("/unit", profileController.readProfilesUnits);
profileRouter.get("/inputresults/:name", profileController.readInputsResults);
profileRouter.get("/inputs/:id", profileController.readInputsByProfile);
profileRouter.get("/inputsprofile/:idCampo/:idProfile", profileController.readInputsProfileByProfile);
profileRouter.post("/inputs", profileController.createProfileInputs);
profileRouter.post("/inputsinprofile", profileController.createInputsInProfile);
profileRouter.post("/createinputs", profileController.createInputs);
profileRouter.put("/input/:id", profileController.updateInputs);
profileRouter.put("/profileinputs/:id", profileController.updateInputsProfile);
profileRouter.delete("/input/:id", profileController.deleteInputs);
profileRouter.delete("/inputsinprofile/:idProfile/:idsArray", profileController.deleteInputsInProfile);
profileRouter.delete("/profileinputs/:id", profileController.deleteInputsProfile);

export default profileRouter;
