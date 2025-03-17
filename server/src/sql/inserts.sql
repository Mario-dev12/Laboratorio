INSERT INTO provider (name) VALUES  
('Juan Pérez'),  
('María Gómez'),  
('Carlos Fernández'),  
('Lucía Torres'),  
('Pedro Sánchez');

INSERT INTO users (ci, firstName, lastName, genre, age, address, phone, email) VALUES  
('1234567', 'Juan', 'Pérez', 'M', 30, 'Calle Falsa 123, Ciudad X', '+5812345678', 'juanperez@gmail.com'),  
('2345678', 'María', 'Gómez', 'F', 28, 'Avenida Siempre Viva 742, Ciudad Y', '', 'mariagomez@hotmail.com'),  
('3456789', 'Carlos', 'Fernández', 'M', 35, 'Bulevar de los Sueños Rotos, Ciudad Z', '+5834598764', ''),  
('4567890', 'Lucía', 'Torres', 'F', 22, 'Camino de la Libertad, Ciudad W', '', ''),  
('5678901', 'Pedro', 'Sánchez', 'M', 40, 'Ruta del Progreso 99, Ciudad V', '', ''); 

INSERT INTO profile (name, cost_bs, cost_usd) VALUES 
('Perfil 20', '244,35', '5'),
('Uroanalisis', '244,35', '5'),
('Perfil Tiroideo', '244,35', '5');

INSERT INTO exam (idUser, total_cost_bs, total_cost_usd) VALUES 
(1, '488,7', '10'),
(2, '488,7', '10'),
(3, '244,35', '5');

INSERT INTO orders (idExam, idProfile, status) VALUES 
(1, 1, 'Pendiente por pasar'),
(1, 2, 'Pendiente por pasar'),
(2, 3, 'Pendiente por pasar'),
(2, 2, 'Pendiente por pasar'),
(3, 3, 'Pendiente por pasar');

INSERT INTO payment_method (name) VALUES 
('Debito'),
('Pago Movil'),
('Efectivo');

INSERT INTO payment (idPayment_method, idExam, amount_bs, amount_usd, bank, phone, type) VALUES 
(1, 1, '244,35', '5', 'Mercantil', '', 'Bolivares'),
(2, 1, '244,35', '5', 'Venezuela', '0414-894432', 'Bolivares'),
(3, 2, '488,7', '10', '', '', 'Dolares'),
(1, 3, '244,35', '5', 'Mercantil', '', 'Bolivares');

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

INSERT INTO campo (nombre, unidad, valor_referencial) VALUES  
('hematies', 'x10/L', '4,30 - 5,60'),
('hemoglobina', 'g/%', 'Hombre: 14 - 16,5; Mujer: 12 - 14,5'),  
('hematocrito', '%', 'Hombre: 42 - 50; Mujer: 39 - 45'), 
('glucosa', 'mg/dL', ''),
('glicemia', 'mg/dL', '70 - 110'),  
('colesterol_total', 'mg/dL', '0 - 200'),
('colesterol_hdl', 'mg/dL', 'Hombre: 40 - 55; Mujer: 45 - 65'), 
('colesterol_ldl', 'mg/dL', 'Favorable menor a 150'), 
('trigliceridos', 'mg/dL', '0 - 150'),
('lipidos_totales', 'mg/dL', '400 - 800'),
('proteina_c_resactiva', 'mg/dL', '6,6 - 8,7'), 
('creatina', 'g/dL', '0,6 - 1,4'), 
('transaminasa_oxalacetica', 'U/L', '8 - 33'),  
('transaminasa_piruvica', 'U/L', '3 - 35'),  
('calcio', 'mg/dL', '8,1- 11,4'), 
('fosforo', 'mg/dL', 'Adulto: 2,5 - 4,8; Niño: 4,5 - 6,5'), 
('bilirrubina_total', 'mg/dL', 'Hasta 1,50'),  
('bilirrubina_directa', 'mg/dL', 'Hasta 0,35'),  
('bilirrubina_indirecta', 'mg/dL', 'Hasta 0,80'),   
('albumina', 'g/dL', '3,7 - 5,1'), 
('globulina', 'g/dL', '2,8 - 3,2'),
('color', NULL, ''), 
('aspecto', NULL, ''),
('ph', 'Mm/cm3', ''),
('densidad', 'mm/Hora', ''), 
('proteinas', 'g/dL', ''),
('leucocitos', '2-3XC', ''),
('cristales', NULL, ''),
('TSH', 'µU/mL', '0,37 - 4,7'),
('T4', 'ng/dL', '0,8 - 1.9'),
('T3', 'ng/dL', '0,37 - 4,7'),
('Anti-TG', 'ng/mL', '10 - 20'),
('Anti-TPO', 'ng/mL', 'Menor a 15');

INSERT INTO campo_perfil (idCampo, idProfile) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 3),
(30, 3),
(31, 3),
(32, 3),
(33, 3);

INSERT INTO resultados_perfil_20 (idOrder, idCampo_perfil, resultado) VALUES  
(1, 1, 90.5),
(1, 2, 85.0),
(1, 3, 190.0), 
(1, 4, 55.0), 
(1, 5, 120.0),
(1, 6, 150.0),
(1, 7, 250.0),  
(1, 8, 5.0),  
(1, 9, 0.9),  
(1, 10, 25.0), 
(1, 11, 30.0), 
(1, 12, 9.2), 
(1, 13, 3.5), 
(1, 14, 1.0), 
(1, 15, 0.3), 
(1, 16, 0.7), 
(1, 17, 4.0), 
(1, 18, 2.5),
(1, 19, 0.7), 
(1, 20, 4.0), 
(1, 21, 2.5); 

INSERT INTO resultados_uroanalisis (idOrder, idCampo_perfil, resultado) VALUES  
(2, 22, 'Amarillo Claro'),
(2, 23, 'Transparente'), 
(2, 24, 6.5),
(2, 25, 1.020),
(2, 26, 10.0), 
(2, 27, '3-4XC'),
(2, 28, 'No prentes'),
(4, 22, 'Amarillo Oscuro'),
(4, 23, 'espumosa'), 
(4, 24, 6.5),
(4, 25, 1.020),
(4, 26, 10.0),
(4, 27, '3-4XC'),
(4, 28, 'Oxalato de calcio');

INSERT INTO resultados_perfil_tiroideo (idOrder, idCampo_perfil, resultado) VALUES  
(3, 28, 1.5),  
(3, 30, 4.0),
(3, 31, 100.0),
(3, 32, 5.0),
(3, 33, 1.0);

INSERT INTO perfil_division (idProfile, nombre, orden) VALUES 
(1, 'Hematología completa', 1),
(1, 'Química Sanguinea', 2),
(2, 'Análisis Físico', 1),
(2, 'Análisis Microscópico', 2),
(2, 'Análisis Químico', 3),
(3, 'Perfil Tiroideo', 1);

INSERT INTO division_campo (idDivision, idCampo) VALUES   
(1, 1),  
(1, 2),
(1, 3),
(2, 5), 
(2, 6),  
(2, 7),
(2, 8),
(2, 9), 
(2, 10),  
(2, 11),  
(2, 12),  
(2, 13),
(2, 14), 
(2, 15),  
(2, 16),
(2, 17),
(2, 18), 
(2, 19),  
(2, 20),  
(2, 21),
(3, 22), 
(3, 23),  
(3, 24),
(3, 25),
(4, 27), 
(4, 18),
(5, 26),
(6, 28),  
(6, 29),
(6, 30), 
(6, 31),  
(6, 32);
