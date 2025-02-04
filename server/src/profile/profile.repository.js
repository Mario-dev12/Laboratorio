import pool from "../config/database.js"

const profileRepository = {};

async function createProfileResults(name){
  try {
    const resp = await pool.query(`SELECT * FROM sp_create_tabla_resultados('${name}')`);
    return resp.rows[0].sp_find_all_profile;
  } catch (error) {
    throw error;
  }
}

async function agregarCampos(inputs) {  
  try {   
    const camposJson = JSON.stringify(inputs);
 
    const resp = await pool.query(`  
      SELECT public.sp_agregar_campos_if_not_exists(  
        ARRAY[  
          ${camposJson}  
        ]::jsonb[]  
      ) AS result  
    `);  

    return resp.rows[0].result;  

  } catch (error) {  
    throw error;
  }  
}  

profileRepository.readProfiles = async () => {
  try {
    const resp = await pool.query(`SELECT * FROM sp_find_all_profile()`);
    return resp.rows[0].sp_find_all_profile;
  } catch (error) {
    throw error;
  }
}

profileRepository.readProfilesUnrepeated = async () => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_all_profile_unrepeated()`);
    return resp.rows[0].sp_find_all_profile_unrepeated;
  } catch (error) {
    throw error;
  }
}

profileRepository.readProfileByType = async name => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_find_profile_by_name('${name}')`);
    return resp.rows[0].sp_find_profile_by_name;
  } catch (error) {
    throw error;
  }
}

profileRepository.createProfile = async (name, cost_bs, cost_usd) => {
  try {
    const resp = await pool.query(`SELECT * FROM sp_create_profile('${name}', '${cost_bs}', '${cost_usd}')`);
    //await agregarCampos(inputs);
    await createProfileResults(name);
    return resp.rows[0].sp_create_profile;
  } catch (error) {
    throw error;
  }
}

profileRepository.createProfileInputs = async (name, cost_bs, cost_usd, inputs) => {
  try {
    const resp = await pool.query(`SELECT * FROM sp_create_profile('${name}', '${cost_bs}', '${cost_usd}')`);
    await agregarCampos(inputs);
    await createProfileResults(name);
    return resp.rows[0].sp_create_profile;
  } catch (error) {
    throw error;
  }
}

profileRepository.updateProfile = async (id, answer) => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_update_profile(${id}, '${answer.name}', '${answer.cost_bs}', '${answer.cost_usd}', '${answer.status}')`);
    return resp.rows[0].sp_update_profile;
  } catch (error) {
    throw error;
  }
}

profileRepository.deleteProfile = async id => {
  try {
    
    const resp = await pool.query(`SELECT * FROM sp_delete_profile(${id})`);
    return resp.rows[0].sp_delete_profile;
  } catch (error) {
    throw error;
  }
}

export default profileRepository