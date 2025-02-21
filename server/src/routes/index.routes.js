import Router from "express-promise-router";

import allianceRouter from "../alliance/alliance.routes.js";
import examRouter from "../exam/exam.routes.js";
import payment_methodRouter from "../payment_method/payment_method.routes.js";
import providersRouter from "../providers/providers.routes.js";
import reactiveRouter from "../reactive/reactive.routes.js";
import unitRouter from "../unit/unit.routes.js";
import usersRouter from "../users/users.routes.js";
import boxRouter from "../box/box.routes.js";
import paymentRouter from "../payment/payment.routes.js";
import profileRouter from "../profile/profile.routes.js";
import orderRouter from "../order/order.routes.js"
import mailRouter from "../mail/mail.routes.js"

const routerModule = Router();

routerModule.use("/alliance", allianceRouter);
routerModule.use("/profile", profileRouter);
routerModule.use("/exam", examRouter);
routerModule.use("/order", orderRouter);
routerModule.use("/payment_method", payment_methodRouter);
routerModule.use("/payment", paymentRouter);
routerModule.use("/providers", providersRouter);
routerModule.use("/reactive", reactiveRouter);
routerModule.use("/unit", unitRouter);
routerModule.use("/users", usersRouter);
routerModule.use("/box", boxRouter);
routerModule.use("/mail", mailRouter);

export default routerModule