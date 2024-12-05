/*----------------------------------------------------------------------------------------------------------------------
--------------------------------------------- PRIMERO CORRE ESTO -------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------ */

CREATE TABLE IF NOT EXISTS provider
(
    idProvider serial primary key,
    name character varying(255) not null,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS users
(
    idUser serial primary key,
    ci character varying(255),
    passport character varying(255),
    firstName character varying(255) not null,
    lastName character varying(255) not null,
    genre CHAR(1) NOT NULL CHECK (genre IN ('M', 'F', 'm', 'f')),
    age integer not null,
    address character varying(255) not null,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS unit
(
    idUnit serial primary key,
    name character varying(255) not null,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS exam
(
    idExam serial primary key,
    name character varying(255) not null,
    cost_bs character varying(255),
    cost_usd character varying(255),
    idUnit integer NOT NULL references unit(idUnit) ON DELETE CASCADE,
    idUser integer NOT NULL references users(idUser) ON DELETE CASCADE,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS payment_method
(
    idPayment_method serial primary key,
    name character varying(255) not null,
    amount character varying(255) not null,
    bank character varying(255),
    type character varying(255) NOT NULL CHECK (type IN ('Bolivares', 'Dolares', 'bolivares', 'dolares')),
    idExam integer NOT NULL references exam(idExam) ON DELETE CASCADE,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS reactive
(
    idReactive serial primary key,
    quantity integer not null,
    idExam integer NOT NULL references exam(idExam) ON DELETE CASCADE,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS alliance
(
    idAlliance serial primary key,
    quantity integer not null,
    idReactive integer NOT NULL references reactive(idReactive) ON DELETE CASCADE,
    idProvider integer NOT NULL references provider(idProvider) ON DELETE CASCADE,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);