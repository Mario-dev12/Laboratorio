/*----------------------------------------------------------------------------------------------------------------------
--------------------------------------------- DESPUÉS SEGUNDO CORRE ESTO -------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------ */

INSERT INTO provider (name) VALUES  
('Juan Pérez'),  
('María Gómez'),  
('Carlos Fernández'),  
('Lucía Torres'),  
('Pedro Sánchez');

INSERT INTO users (ci, firstName, lastName, genre, age, address) VALUES  
('1234567', 'Juan', 'Pérez', 'M', 30, 'Calle Falsa 123, Ciudad X'),  
('2345678', 'María', 'Gómez', 'F', 28, 'Avenida Siempre Viva 742, Ciudad Y'),  
('3456789', 'Carlos', 'Fernández', 'M', 35, 'Bulevar de los Sueños Rotos, Ciudad Z'),  
('4567890', 'Lucía', 'Torres', 'F', 22, 'Camino de la Libertad, Ciudad W'),  
('5678901', 'Pedro', 'Sánchez', 'M', 40, 'Ruta del Progreso 99, Ciudad V'); 

INSERT INTO exam (name, cost_bs, cost_usd, status, idUser) VALUES 
('Perfil 20', '244,35', '5', 'Pendiente por pasar', 1),
('Uroanalisis', '244,35', '5', 'Pendiente por pasar', 2);

INSERT INTO unit (name, idExam) VALUES   
('x10/L', 1),  
('g%', 1),  
('%', 1),  
('G/dl', 1),  
('Mm/cm3', 1),  
('ccl/mm3', 1),  
('mm/Hora', 1),  
('mg/dl', 1),  
('gr/li', 1),  
('g/dl', 1),  
('U/L', 1),  
('gr/dl', 1);  

INSERT INTO payment_method (name, amount, bank, type, idExam) VALUES 
('Debito', '244,35', 'Banco Mercantil', 'Bolivares', 1),
('Pago Movil', '122,18', 'Banco Venezuela', 'Bolivares', 2),
('Efectivo', '2,5', '', 'Dolares', 2);

INSERT INTO reactive (name) VALUES   
('Glucosa'),  
('Bilirrubina total'),  
('Bilirrubina fraccionada'),  
('Proteínas Totales'),  
('Albúmina'),  
('Sodio'),  
('Potasio'),  
('Cloro'),  
('Bicarbonato'),  
('Creatinina'),  
('Urea'),  
('Fosfatasa alcalina'),  
('AST (GOT)'),  
('ALT (GPT)'),  
('Colesterol total'),  
('HDL'),  
('LDL'),  
('Triglicéridos'),  
('Ácido úrico'),
('Color'),  
('Aspecto'),  
('Densidad'),  
('pH'),  
('Proteínas'),    
('Cuerpos cetónicos'),  
('Sangre'),  
('Nitritos'),  
('Leucocitos'),  
('Urobilinógeno'),  
('Bilirrubina'),  
('Cristales'),  
('Células epiteliales'),  
('Bacterias'); 

INSERT INTO alliance (quantity, cost_bs, cost_usd, pay_done, pay_amount, idReactive, idProvider) VALUES 
(5, '256.75', '5', true, '', 1, 1),  
(5, '256.75', '5', true, '', 2, 1),  
(5, '256.75', '5', true, '', 3, 1),  
(5, '256.75', '5', true, '', 4, 1),  
(5, '256.75', '5', true, '', 5, 1),  
(5, '256.75', '5', true, '', 6, 1),
(5, '256.75', '5', true, '', 7, 2),  
(5, '256.75', '5', true, '', 8, 2),  
(5, '256.75', '5', true, '', 9, 2),  
(5, '256.75', '5', true, '', 10, 2),  
(5, '256.75', '5', true, '', 11, 2),  
(5, '256.75', '5', true, '', 12, 2),
(5, '256.75', '5', true, '', 13, 3),  
(5, '256.75', '5', true, '', 14, 3),  
(5, '256.75', '5', true, '', 15, 3),  
(5, '256.75', '5', true, '', 16, 3),  
(5, '256.75', '5', true, '', 17, 3),  
(5, '256.75', '5', true, '', 18, 3),
(5, '256.75', '5', true, '', 19, 4),  
(5, '256.75', '5', true, '', 20, 4),  
(5, '256.75', '5', true, '', 21, 4),
(5, '256.75', '5', true, '', 22, 4),  
(5, '256.75', '5', true, '', 23, 4),  
(5, '256.75', '5', true, '', 24, 4),
(5, '256.75', '5', true, '', 25, 5),  
(5, '256.75', '5', true, '', 26, 5),  
(5, '256.75', '5', true, '', 27, 5),
(5, '256.75', '5', true, '', 28, 5),  
(5, '256.75', '5', true, '', 29, 5),  
(5, '256.75', '5', true, '', 30, 5);
