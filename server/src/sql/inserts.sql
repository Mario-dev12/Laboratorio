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
(2, '488,7', '10');

INSERT INTO orders (idExam, idProfile, status) VALUES 
(1, 1, 'Pendiente por pasar'),
(1, 2, 'Pendiente por pasar'),
(2, 3, 'Pendiente por pasar'),
(2, 2, 'Pendiente por pasar');

INSERT INTO payment_method (name) VALUES 
('Debito'),
('Pago Movil'),
('Efectivo');

INSERT INTO payment (idPayment_method, idExam, amount_bs, amount_usd, bank, phone, type) VALUES 
(1, 1, '244,35', '5', 'Mercantil', '', 'Bolivares'),
(2, 1, '244,35', '5', 'Venezuela', '0414-894432', 'Bolivares'),
(3, 2, '488,7', '10', '', '', 'Dolares');

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

INSERT INTO campo (nombre, unidad) VALUES   
('glucosa', 'mg/dL'),
('glicemia', 'mg/dL'),  
('colesterol_total', 'mg/dL'),
('colesterol_hdl', 'mg/dL'), 
('colesterol_ldl', 'mg/dL'), 
('trigliceridos', 'mg/dL'),
('lipidos_totales', 'mg/dL'),
('proteina_c_resactiva', 'mg/dL'), 
('creatina', 'g/dL'), 
('transaminasa_oxalacetica', 'U/L'),  
('transaminasa_piruvica', 'U/L'),  
('calcio', 'mg/dL'), 
('fosforo', 'mg/dL'), 
('bilirrubina_total', 'mg/dL'),  
('bilirrubina_directa', 'mg/dL'),  
('bilirrubina_indirecta', 'mg/dL'),   
('albumina', 'g/dL'), 
('globulina', 'g/dL'),
('color', NULL), 
('aspecto', NULL),
('ph', 'Mm/cm3'),
('densidad', 'mm/Hora'), 
('proteinas', 'g/dL'),
('TSH', 'µU/mL'),
('T4', 'ng/dL'),
('T3', 'ng/dL'),
('Anti-TG', 'ng/mL'),
('Anti-TPO', 'ng/mL');

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
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(28, 3);

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
(1, 18, 2.5); 

INSERT INTO resultados_uroanalisis (idOrder, idCampo_perfil, resultado) VALUES  
(2, 19, 'Amarillo Claro'),
(2, 20, 'Transparente'), 
(2, 21, 6.5),
(2, 22, 1.020),
(2, 23, 10.0), 
(4, 19, 'Amarillo Oscuro'),
(4, 20, 'espumosa'), 
(4, 21, 6.5),
(4, 22, 1.020),
(4, 23, 10.0);

INSERT INTO resultados_perfil_tiroideo (idOrder, idCampo_perfil, resultado) VALUES  
(3, 24, 1.5),  
(3, 25, 4.0),
(3, 26, 100.0),
(3, 27, 5.0),
(3, 28, 1.0);