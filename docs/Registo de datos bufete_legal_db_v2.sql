USE bufete_legal_db_v2; -- Asegúrate de usar la base de datos correcta

-- ---------------------------------
-- 1. Tabla: usuario (Abogados y Asistentes)
-- ---------------------------------
INSERT INTO usuario (nombre, rol, correo) VALUES
('Alejandra Soto', 'abogado', 'asoto@bufete.com'),         -- ID 1
('Roberto Pérez', 'asistente legal', 'rperez@bufete.com'),   -- ID 2
('Sofía Díaz', 'abogado', 'sdiaz@bufete.com'),             -- ID 3
('Manuel Castro', 'abogado', 'mcastro@bufete.com'),         -- ID 4
('Elena Gómez', 'asistente legal', 'egomez@bufete.com'),    -- ID 5
('Ricardo Velez', 'abogado', 'rvelez@bufete.com'),          -- ID 6
('Laura Montes', 'asistente legal', 'lmontes@bufete.com'),   -- ID 7
('Javier Ríos', 'abogado', 'jrios@bufete.com'),             -- ID 8
('Carla Nuñez', 'asistente legal', 'cnunez@bufete.com'),    -- ID 9
('David Torres', 'abogado', 'dtorres@bufete.com');          -- ID 10

-- ---------------------------------
-- 2. Tabla: cliente
-- ---------------------------------
INSERT INTO cliente (nombre, numero_identidad, telefono, correo, direccion) VALUES
('Industrias Omega S.A.', 3456789, 5551234, 'omega@corp.com', 'Av. Principal 102'),    -- ID 1
('Jorge Martínez', 9876543, 5554321, 'jm@mail.com', 'Calle del Sol 55'),               -- ID 2
('Familia Rodríguez', 1122334, 5558877, 'fr@mail.com', 'Blvd. Las Flores 1A'),          -- ID 3
('Transportes Rápidos Ltda.', 6543210, 5559900, 'tr@trans.com', 'Carrera 7, No. 20'),   -- ID 4
('Ana Beltrán', 5544332, 5550101, 'abeltran@mail.com', 'Residencial Cima'),              -- ID 5
('Carlos Peña', 9988776, 5552020, 'cpena@mail.com', 'Avenida Central 33'),              -- ID 6
('Maria Solano', 1020304, 5553030, 'msolano@mail.com', 'Sector Industrial, Lote 5'),    -- ID 7
('Inversiones Beta', 4030201, 5554040, 'beta@inv.com', 'Zona Franca 15'),               -- ID 8
('Felipe Guzmán', 7060504, 5555050, 'fguzman@mail.com', 'Colonia Obrera 8'),             -- ID 9
('Constructora Del Valle', 2211334, 5556060, 'cdv@const.com', 'Plaza Comercial 1');     -- ID 10

-- ---------------------------------
-- 3. Tabla: caso
-- ---------------------------------
INSERT INTO caso (fecha_inicio, fecha_cierre, estado, descripcion, id_cliente, id_usuario) VALUES
('2024-01-15 10:00:00', '2024-07-20 16:30:00', 'finalizado', 'Demanda por incumplimiento de contrato', 1, 1), -- Caso 1 (Finalizado)
('2024-03-01 14:30:00', NULL, 'en proceso', 'Consulta sobre herencia familiar', 2, 3),                        -- Caso 2 (En Proceso)
('2024-02-20 09:00:00', '2024-05-10 11:00:00', 'finalizado', 'Recuperación de deuda', 3, 1),                    -- Caso 3 (Finalizado)
('2024-04-10 11:30:00', NULL, 'en proceso', 'Defensa laboral contra ex-empleado', 4, 4),                      -- Caso 4
('2024-05-05 08:00:00', NULL, 'en proceso', 'Revisión de propiedad intelectual', 5, 6),                       -- Caso 5
('2024-06-12 15:00:00', NULL, 'presupuesto', 'Solicitud de divorcio', 6, 8),                                 -- Caso 6 (Presupuesto)
('2024-07-01 16:00:00', NULL, 'en proceso', 'Permiso de construcción', 7, 10),                              -- Caso 7
('2024-08-01 09:30:00', '2024-10-30 14:00:00', 'finalizado', 'Fusión de empresas', 8, 4),                      -- Caso 8 (Finalizado)
('2024-09-05 13:00:00', NULL, 'en proceso', 'Asesoría en impuestos', 9, 3),                                 -- Caso 9
('2024-10-20 10:00:00', NULL, 'en proceso', 'Litigio por linderos', 10, 6);                                   -- Caso 10

-- ---------------------------------
-- 4. Tabla: factura
-- ---------------------------------
INSERT INTO factura (monto, fecha_emision, estado_pago, fecha_pago, id_caso) VALUES
(500.00, '2024-01-31 18:00:00', 'pagado', '2024-02-15 10:00:00', 1),   -- Caso 1
(1500.00, '2024-03-28 18:00:00', 'pagado', '2024-04-10 12:00:00', 3),   -- Caso 3
(250.00, '2024-03-05 17:00:00', 'pendiente', NULL, 2),                -- Caso 2 (Pendiente)
(750.00, '2024-04-30 16:00:00', 'pagado', '2024-05-05 09:00:00', 4),   -- Caso 4
(120.00, '2024-05-30 18:00:00', 'pagado', '2024-06-01 10:00:00', 5),   -- Caso 5
(800.00, '2024-07-31 18:00:00', 'pagado', '2024-08-05 15:00:00', 8),   -- Caso 8
(100.00, '2024-09-01 17:00:00', 'anulado', NULL, 6),                  -- Caso 6 (Presupuesto, anulado)
(450.00, '2024-10-15 16:00:00', 'pendiente', NULL, 9),                -- Caso 9 (Pendiente)
(180.00, '2024-11-01 18:00:00', 'pagado', '2024-11-05 11:00:00', 10), -- Caso 10
(320.00, '2024-11-15 17:00:00', 'pendiente', NULL, 7);                -- Caso 7 (Pendiente)

-- ---------------------------------
-- 5. Tabla: documento
-- ---------------------------------
INSERT INTO documento (tipo, fecha, fecha_limite, id_caso, monto) VALUES
('Contrato', '2024-01-15 10:30:00', NULL, 1, 0.00),
('Poder Legal', '2024-01-20 16:00:00', '2024-03-01 23:59:59', 1, 50.00),
('Acta de Reunión', '2024-03-05 15:00:00', NULL, 2, 0.00),
('Demanda', '2024-04-15 08:30:00', '2024-05-15 23:59:59', 4, 100.00),
('Escritura', '2024-05-10 12:00:00', NULL, 5, 0.00),
('Oficio Fiscal', '2024-06-20 11:00:00', '2024-07-25 23:59:59', 7, 0.00),
('Balance Anual', '2024-08-05 09:00:00', NULL, 8, 0.00),
('Certificado Catastral', '2024-10-25 15:00:00', '2024-12-10 23:59:59', 10, 80.00), 
('Cálculo de Impuestos', '2024-09-10 14:00:00', NULL, 9, 0.00),
('Propuesta de Servicios', '2024-06-15 16:00:00', NULL, 6, 0.00);

-- ---------------------------------
-- 6. Tabla: gasto_operacional 
-- ---------------------------------
INSERT INTO gasto_operacional (fecha, descripcion, monto, id_caso) VALUES
('2024-01-25 09:00:00', 'Tasas judiciales iniciales', 80.00, 1),      
('2024-03-10 10:00:00', 'Costo de notario', 50.00, 3),                
('2024-04-05 11:00:00', 'Viáticos para reunión', 25.00, 4),            
('2024-05-15 14:00:00', 'Registro de Marca', 200.00, 5),               
('2024-06-01 12:00:00', 'Timbres Fiscales', 10.00, 6),                 
('2024-07-10 13:00:00', 'Fotocopias de expediente', 5.00, 7),          
('2024-08-15 15:00:00', 'Viaje de representación', 150.00, 8),         
('2024-09-20 09:00:00', 'Software de cálculo fiscal', 120.00, 9),      
('2024-10-22 16:00:00', 'Peritaje topográfico', 300.00, 10),           
('2024-04-20 10:00:00', 'Publicaciones legales', 40.00, 4);            