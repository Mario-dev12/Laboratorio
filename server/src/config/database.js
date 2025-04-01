import pkg from "pg";
const { Pool, Client } = pkg;
import logger from "../utils/logger.js";
import ObjLog from "../utils/ObjLog.js";
import env from "../utils/environment.js";

const connectionData = {
	user: env.PG_DB_USER,
	host: env.PG_DB_HOST,
	database: env.PG_DB_NAME,
	password: env.PG_DB_PASSWORD,
	port: env.PG_DB_PORT,
	// ssl: {
	//   rejectUnauthorized: true,
	//   ca: env.SSL
	// }
};

const pool = new Pool(connectionData);
const client = new Client(connectionData);

pool
	.connect()
	.then((response) => {
		logger.info(`PGDB is connected`);
		ObjLog.log(`PGDB is connected`);
		pool.on("connect", (client) => {
			client.on("notice", (notice) => {
				console.log(notice.message);
			});
		});
	})
	.catch((err) => {
		logger.error(`PGDB is not connected: ${err}`);
		ObjLog.log(`PGDB is not connected: ${err}`);
		client.end();
	});
client
	.connect()
	.then((response) => {
		logger.info("PG-DB client-listener is connected");
		ObjLog.log("PG-DB client-listener is connected");
	})
	.catch((err) => {
		logger.error(`PG-DB client-listener is not connected: ${err}`);
		client.end();
	});

export default pool;
