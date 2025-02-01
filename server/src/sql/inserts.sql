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

INSERT INTO profile (name, cost_bs, cost_usd) VALUES 
('Perfil 20', '244,35', '5'),
('Uroanalisis', '244,35', '5'),
('Perfil Tiroideo', '244,35', '5');

INSERT INTO exam (idUser, total_cost_bs, total_cost_usd) VALUES 
(1, '488,7', '10'),
(2, '244,35', '5');

INSERT INTO orders (idExam, idProfile, status) VALUES 
(1, 1, 'Pendiente por pasar'),
(1, 2, 'Pendiente por pasar'),
(2, 2, 'Pendiente por pasar');

INSERT INTO payment_method (name) VALUES 
('Debito'),
('Pago Movil'),
('Efectivo');

INSERT INTO payment (idPayment_method, idExam, amount_bs, amount_usd, bank, phone, type) VALUES 
(1, 1, '244,35', '5', 'Mercantil', '', 'Bolivares'),
(2, 1, '244,35', '5', 'Venezuela', '0414-894432', 'Bolivares'),
(3, 2, '244,35', '5', '', '', 'Dolares');

INSERT INTO unit (name, idProfile) VALUES   
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

INSERT INTO reactive (name, total) VALUES   
('Glucosa', 5),  
('Bilirrubina total', 5),  
('Bilirrubina fraccionada', 5),  
('Proteínas Totales', 5),  
('Albúmina', 5),  
('Sodio', 5),  
('Potasio', 5),  
('Cloro', 5),  
('Bicarbonato', 5),  
('Creatinina', 5),  
('Urea', 5),  
('Fosfatasa alcalina', 5),  
('AST (GOT)', 5),  
('ALT (GPT)', 5),  
('Colesterol total', 5),  
('HDL', 5),  
('LDL', 5),  
('Triglicéridos', 5),  
('Ácido úrico', 5),
('Color', 5),  
('Aspecto', 5),  
('Densidad', 5),  
('pH', 5),  
('Proteínas', 5),    
('Cuerpos cetónicos', 5),  
('Sangre', 5),  
('Nitritos', 5),  
('Leucocitos', 5),  
('Urobilinógeno', 5),  
('Bilirrubina', 5),  
('Cristales', 5),  
('Células epiteliales', 5),  
('Bacterias', 5); 

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
(5, '256.75', '5', true, '', 30, 5),
(5, '256.75', '5', true, '', 31, 5),  
(5, '256.75', '5', true, '', 32, 5),  
(5, '256.75', '5', true, '', 33, 5);
