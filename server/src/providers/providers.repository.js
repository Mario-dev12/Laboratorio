import pool from "../config/database.js";

const providersRepository = {};

providersRepository.readProviders = async () => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_find_all_provider()`);
		return resp.rows[0].sp_find_all_provider;
	} catch (error) {
		throw error;
	}
};

providersRepository.readProviderByName = async (name) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_find_provider_by_name('${name}')`);
		console.log(resp.rows[0].sp_find_provider_by_name);
		return resp.rows[0].sp_find_provider_by_name;
	} catch (error) {
		throw error;
	}
};

providersRepository.createProvider = async (name) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_create_provider('${name}')`);
		return resp.rows[0].sp_create_provider;
	} catch (error) {
		throw error;
	}
};

providersRepository.updateProvider = async (id, answer) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_update_provider(${id}, '${answer.name}')`);
		return resp.rows[0].sp_update_provider;
	} catch (error) {
		throw error;
	}
};

providersRepository.deleteProvider = async (id) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_delete_provider(${id})`);
		return resp.rows[0].sp_delete_provider;
	} catch (error) {
		throw error;
	}
};

export default providersRepository;
