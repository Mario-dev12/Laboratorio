import pool from "../config/database.js";

const restrictionRepository = {};

restrictionRepository.readRestrictions = async () => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_find_all_restriction()`);
		return resp.rows[0].sp_find_all_restriction;
	} catch (error) {
		throw error;
	}
};

restrictionRepository.readRestrictionByProfile = async (id) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_find_restriction_by_profile(${id})`);
		return resp.rows[0].sp_find_restriction_by_profile;
	} catch (error) {
		throw error;
	}
};

restrictionRepository.createRestriction = async (idProfile, restrictions) => {  
    try {   
        const restrictionValues = restrictions.map(item => item.restriction);  
        
        const restrictionArray = `{${restrictionValues.join(',')}}`;   
 
        const resp = await pool.query(`SELECT * FROM sp_create_restriction(${idProfile}, '${restrictionArray}')`);  
        
        return resp.rows[0].sp_create_restriction;  
    } catch (error) {  
        throw error;  
    }  
}; 

restrictionRepository.updateRestriction = async (id, answer) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_update_restriction(${id}, ${answer.idProfile}, '${answer.restriction}')`);
		return resp.rows[0].sp_update_restriction;
	} catch (error) {
		throw error;
	}
};

restrictionRepository.deleteRestriction = async (id) => {
	try {
		const resp = await pool.query(`SELECT * FROM sp_delete_restriction(${id})`);
		return resp.rows[0].sp_delete_restriction;
	} catch (error) {
		throw error;
	}
};

export default restrictionRepository;
