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

INSERT INTO reactive (name, quantity, idExam) VALUES   
('Glucosa', 1, 1),  
('Bilirrubina total', 1, 1),  
('Bilirrubina fraccionada', 1, 1),  
('Proteínas Totales', 1, 1),  
('Albúmina', 1, 1),  
('Sodio', 1, 1),  
('Potasio', 1, 1),  
('Cloro', 1, 1),  
('Bicarbonato', 1, 1),  
('Creatinina', 1, 1),  
('Urea', 1, 1),  
('Fosfatasa alcalina', 1, 1),  
('AST (GOT)', 1, 1),  
('ALT (GPT)', 1, 1),  
('Colesterol total', 1, 1),  
('HDL', 1, 1),  
('LDL', 1, 1),  
('Triglicéridos', 1, 1),  
('Ácido úrico', 1, 1),
('Color', 1, 2),  
('Aspecto', 1, 2),  
('Densidad', 1, 2),  
('pH', 1, 2),  
('Proteínas', 1, 2),  
('Glucosa', 1, 2),  
('Cuerpos cetónicos', 1, 2),  
('Sangre', 1, 2),  
('Nitritos', 1, 2),  
('Leucocitos', 1, 2),  
('Urobilinógeno', 1, 2),  
('Bilirrubina', 1, 2),  
('Cristales', 1, 2),  
('Células epiteliales', 1, 2),  
('Bacterias', 1, 2); 

INSERT INTO alliance (quantity, idReactive, idProvider) VALUES 
(5, 1, 1),  
(5, 2, 1),  
(5, 3, 1),  
(5, 4, 1),  
(5, 5, 1),  
(5, 6, 1),
(5, 7, 2),  
(5, 8, 2),  
(5, 9, 2),  
(5, 10, 2),  
(5, 11, 2),  
(5, 12, 2),
(5, 13, 3),  
(5, 14, 3),  
(5, 15, 3),  
(5, 16, 3),  
(5, 17, 3),  
(5, 18, 3),
(5, 19, 4),  
(5, 20, 4),  
(5, 21, 4),
(5, 22, 4),  
(5, 23, 4),  
(5, 24, 4),
(5, 25, 5),  
(5, 26, 5),  
(5, 27, 5),
(5, 28, 5),  
(5, 29, 5),  
(5, 30, 5);
