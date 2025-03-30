import express from "express";
import cookieParser from "cookie-parser";
import cors from "cors";
import monitor from "./logger.js";
import database from "./src/config/database.js";
import ObjLog from "./src/utils/ObjLog.js";
import helmet from "helmet";
import logger from "./src/utils/logger.js";
import routerModule from "./src/routes/index.routes.js";
import bodyParser from "body-parser";
import session from "express-session";
import passport from "passport";

// App initialization
const app = express();

// Middleware
app.use(
	cors({
		origin: ["http://localhost:4200", "http://localhost:5173", "https://localhost:4200", "https://laboratorio-git-dev-mario-dev12s-projects.vercel.app", "https://laboratorio-2s3nj418p-mario-dev12s-projects.vercel.app", "https://laboratorio-5bk0y4nru-mario-dev12s-projects.vercel.app/", "https://laboratorio-phi.vercel.app", "https://laboratorio-rray.onrender.com/api"],
		methods: "GET,HEAD,PUT,PATCH,POST,DELETE",
		optionsSuccessStatus: 204,
		credentials: true,
	})
);

app.use(express.json({ extended: false }));
app.use(monitor("combined"));
app.use(cookieParser());
app.use(
	express.urlencoded({
		extended: true,
	})
);
app.use(
	session({
		secret: "Some_Secret",
		resave: false,
		saveUninitialized: true,
		cookie: {
			expires: 1800000,
			secure: true,
		}, // 1 day (1000 ms / sec * 60 sec /1 min * 60 min /1 h * 24 h/1 day)
	})
);
app.use(passport.initialize());
app.use(passport.session());
const directives = helmet.contentSecurityPolicy.getDefaultDirectives();
delete directives["form-action"];
app.use(
	helmet({
		contentSecurityPolicy: {
			useDefaults: false,
			directives,
		},
	})
);

app.use(bodyParser.json());
app.use(express.json({ limit: "15mb" }));
app.use(`/api`, routerModule);

// Synchronize database
database;

app.use(helmet());

// Listen
const port = process.env.PORT || 3001;

app.listen(port, (err) => {
	logger.info(`Server running on port ${port}`);
	ObjLog.log(`Server running on port ${port}`);
	logger.info(`Sockets connected on port ${port}`);
	ObjLog.log(`Sockets connected on port ${port}`);
});

export default app;
