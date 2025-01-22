import express from 'express'
const profileRouter = express.Router()
import profileController from './profile.controller.js'


profileRouter.get('/', profileController.readProfiles)
profileRouter.get('/unrepeated', profileController.readProfilesUnrepeated)
profileRouter.get('/type/:type', profileController.readProfileByType)
profileRouter.post('/', profileController.createProfile)
profileRouter.put('/:id', profileController.updateProfile)
profileRouter.delete('/:id', profileController.deleteProfile)


export default profileRouter