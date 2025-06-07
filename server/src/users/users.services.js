import usersRepository from './users.repository.js'

const usersServices = {};

usersServices.readUsers = async () => {
    return await usersRepository.readUsers()
}
  
usersServices.readUserByName = async name => {
    return await usersRepository.readUserByName(name)
}

usersServices.readUserByNameLastName = async (name, lastName) => {
    return await usersRepository.readUserByNameLastName(name, lastName)
}

usersServices.readUserById = async id => {
    return await usersRepository.readUserById(id)
}

usersServices.createUser = async (ci, passport, firstName, lastName, genre, age, address, phone, email, doctor) => {
    return await usersRepository.createUser(ci, passport, firstName, lastName, genre, age, address, phone, email, doctor)
}

usersServices.updateUser = async (id, answer) => {
    return await usersRepository.updateUser(id, answer)
}

usersServices.deleteUser = async id => {
    return await usersRepository.deleteUser(id)
}

export default usersServices