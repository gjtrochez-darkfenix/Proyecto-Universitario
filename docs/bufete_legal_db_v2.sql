CREATE DATABASE IF NOT EXISTS bufete_legal_db_v2;
USE bufete_legal_db_v2;

-- ---------------------------------
-- 1. Tabla: usuario
-- ---------------------------------
CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    rol ENUM('abogado', 'asistente legal') NOT NULL,
    correo VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (id_usuario)
) ENGINE=InnoDB;

-- ---------------------------------
-- 2. Tabla: cliente
-- ---------------------------------
CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    numero_identidad INT UNIQUE,
    telefono INT,
    correo VARCHAR(50) UNIQUE,
    direccion VARCHAR(100),
    PRIMARY KEY (id_cliente)
) ENGINE=InnoDB;

-- ---------------------------------
-- 3. Tabla: caso 
-- ---------------------------------
CREATE TABLE caso (
    id_caso INT NOT NULL AUTO_INCREMENT,
    fecha_inicio DATETIME NOT NULL,
    -- Campo para registrar el cierre real. Es NULL si aún está activo.
    fecha_cierre DATETIME NULL,
    estado ENUM('en proceso', 'finalizado', 'presupuesto') NOT NULL,
    descripcion VARCHAR(150),
    id_cliente INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_caso),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------
-- 4. Tabla: documento 
-- ---------------------------------
CREATE TABLE documento (
    id_documento INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL,
    -- Campo para la alerta de fechas límites
    fecha_limite DATETIME NULL,
    id_caso INT NOT NULL,
    monto DECIMAL(10, 2),
    PRIMARY KEY (id_documento),
    FOREIGN KEY (id_caso) REFERENCES caso(id_caso) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------
-- 5. Tabla: factura 
-- ---------------------------------
CREATE TABLE factura (
    id_factura INT NOT NULL AUTO_INCREMENT,
    monto DECIMAL(5, 2) NOT NULL,
    fecha_emision DATETIME NOT NULL, -- Renombrado para claridad
    estado_pago ENUM('pendiente', 'pagado', 'anulado') NOT NULL, -- Para 'Referente a Cobro'
    fecha_pago DATETIME NULL, -- Fecha real en que se efectuó el pago
    id_caso INT NOT NULL,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_caso) REFERENCES caso(id_caso) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
ALTER TABLE factura
MODIFY COLUMN monto DECIMAL(10, 2) NOT NULL;


-- ---------------------------------
-- 6. NUEVA TABLA: gasto_operacional
-- Necesaria para el flujo de 'Gastos Totales' y 'Cuenta Salida de Caso Cerrado'
-- ---------------------------------
CREATE TABLE gasto_operacional (
    id_gasto INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    descripcion VARCHAR(150) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    id_caso INT NOT NULL,
    PRIMARY KEY (id_gasto),
    FOREIGN KEY (id_caso) REFERENCES caso(id_caso) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

