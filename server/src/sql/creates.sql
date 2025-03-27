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
    phone character varying(255),
    email character varying(255),
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS profile
(
    idProfile serial primary key,
    name character varying(255) not null,
    cost_bs character varying(255),
    cost_usd character varying(255),
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS restriction
(
    idRestriction serial primary key,
    idProfile integer NOT NULL references profile(idProfile) ON DELETE CASCADE,
    restriction character varying(255) NOT NULL,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS exam
(
    idExam serial primary key,
    idUser integer NOT NULL references users(idUser) ON DELETE CASCADE,
    total_cost_bs character varying(255),
    total_cost_usd character varying(255),
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS orders
(
    idOrder serial primary key,
    idExam integer NOT NULL references exam(idExam) ON DELETE CASCADE,
    idProfile integer NOT NULL references profile(idProfile) ON DELETE CASCADE,
    status character varying(255) NOT NULL CHECK (status IN ('Pendiente por pasar', 'Pendiente de enviar', 'Pendiente de imprimir', 'Completado')),
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS payment_method
(
    idPayment_method serial primary key,
    name character varying(255) not null,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS payment
(
    idPayment serial primary key,
    idPayment_method integer NOT NULL references payment_method(idPayment_method) ON DELETE CASCADE,
    idExam integer NOT NULL references exam(idExam) ON DELETE CASCADE,
    amount_bs character varying(255),
    amount_usd character varying(255),
    bank character varying(255),
    phone character varying(255),
    type character varying(255) NOT NULL CHECK (type IN ('Bolivares', 'Dolares', 'bolivares', 'dolares')),
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS reactive
(
    idReactive serial primary key,
    name character varying(255) not null,
    total integer not null default 0,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS alliance
(
    idAlliance serial primary key,
    quantity integer not null,
    cost_bs character varying(255),
    cost_usd character varying(255),
    pay_done boolean not null,
    pay_amount character varying(255),
    idReactive integer NOT NULL references reactive(idReactive) ON DELETE CASCADE,
    idProvider integer NOT NULL references provider(idProvider) ON DELETE CASCADE,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
);

CREATE TABLE IF NOT EXISTS campo (  
    idCampo serial PRIMARY KEY,  
    nombre character varying(255) NOT NULL,  
    unidad character varying(255),
    valor_referencial character varying(255),
    calculado character varying(255) default null,
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
); 

CREATE TABLE IF NOT EXISTS campo_perfil (  
    idCampo_perfil serial PRIMARY KEY,  
    idCampo integer NOT NULL REFERENCES campo(idCampo) ON DELETE CASCADE,
    idProfile integer NOT NULL REFERENCES profile(idProfile) ON DELETE CASCADE, 
    createdDate timestamp with time zone NOT NULL default now(),
    modifiedDate timestamp with time zone NOT NULL default now()
); 

CREATE TABLE IF NOT EXISTS resultados_perfil_20 (  
    idResultado SERIAL PRIMARY KEY,  
    idOrder integer NOT NULL REFERENCES orders(idOrder) ON DELETE CASCADE,  
    idCampo_perfil integer NOT NULL REFERENCES campo_perfil(idCampo_perfil) ON DELETE CASCADE,  
    resultado character varying(255) NOT NULL,
    createdDate timestamp with time zone NOT NULL DEFAULT now(),  
    modifiedDate timestamp with time zone NOT NULL DEFAULT now()   
);  

CREATE TABLE IF NOT EXISTS resultados_uroanalisis (  
    idResultado SERIAL PRIMARY KEY,  
    idOrder INTEGER NOT NULL REFERENCES orders(idOrder) ON DELETE CASCADE,   
    idCampo_perfil integer NOT NULL REFERENCES campo_perfil(idCampo_perfil) ON DELETE CASCADE,   
    resultado character varying(255) NOT NULL,
    createdDate timestamp with time zone NOT NULL DEFAULT now(),  
    modifiedDate timestamp with time zone NOT NULL DEFAULT now()    
);

CREATE TABLE IF NOT EXISTS resultados_perfil_tiroideo (  
    idResultado SERIAL PRIMARY KEY,  
    idOrder INTEGER NOT NULL REFERENCES orders(idOrder) ON DELETE CASCADE,  
    idCampo_perfil integer NOT NULL REFERENCES campo_perfil(idCampo_perfil) ON DELETE CASCADE,   
    resultado character varying(255) NOT NULL,
    createdDate timestamp with time zone NOT NULL DEFAULT now(),  
    modifiedDate timestamp with time zone NOT NULL DEFAULT now()  
);

CREATE TABLE IF NOT EXISTS perfil_division (  
    idDivision SERIAL PRIMARY KEY,  
    idProfile INTEGER NOT NULL REFERENCES profile(idProfile) ON DELETE CASCADE,  
    nombre TEXT NOT NULL,
    orden INTEGER NOT NULL,  
    createdDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),  
    modifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()  
); 

CREATE TABLE IF NOT EXISTS division_campo (  
    idDivisionCampo SERIAL PRIMARY KEY, 
    idDivision INTEGER NOT NULL REFERENCES perfil_division(idDivision) ON DELETE CASCADE,
    idCampo INTEGER NOT NULL REFERENCES campo(idCampo) ON DELETE CASCADE,  
    createdDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),  
    modifiedDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()  
);