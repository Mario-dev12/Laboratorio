import express from 'express'
const profileRouter = express.Router()
import profileController from './profile.controller.js'


profileRouter.get('/', profileController.readProfiles)
profileRouter.get('/input', profileController.readProfilesInputs)
profileRouter.get('/unit', profileController.readProfilesUnits)
profileRouter.get('/', profileController.readProfiles)
profileRouter.get('/unrepeated', profileController.readProfilesUnrepeated)
profileRouter.get('/type/:type', profileController.readProfileByType)
profileRouter.get('/inputs/:id', profileController.readInputsByProfile)
profileRouter.post('/', profileController.createProfile)
profileRouter.post('/inputs', profileController.createProfileInputs)
profileRouter.put('/:id', profileController.updateProfile)
profileRouter.delete('/:id', profileController.deleteProfile)


export default profileRouter