CREATE DATABASE sistema_conteo_numeros;
USE sistema_conteo_numeros;

-- 2. Tabla: Usuarios
CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('Sordo', 'Oyente', 'Interprete', 'Administrador') NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Tabla: Digitos
CREATE TABLE Digitos (
    id_digito INT AUTO_INCREMENT PRIMARY KEY,
    valor_numerico INT NOT NULL,
    descripcion_mano TEXT,
    puntos_landmark_base TEXT
) ENGINE=InnoDB;

-- 4. Tabla: Interacciones
CREATE TABLE Interacciones (
    id_interaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_emisor INT NOT NULL,
    id_digito_detectado INT NOT NULL,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    precision_modelo DECIMAL(5,2),

    CONSTRAINT fk_usuario_interaccion 
        FOREIGN KEY (id_usuario_emisor) REFERENCES Usuarios(id_usuario),

    CONSTRAINT fk_digito_interaccion 
        FOREIGN KEY (id_digito_detectado) REFERENCES Digitos(id_digito)
) ENGINE=InnoDB;

-- 5. Tabla: Logs_Sistema
CREATE TABLE Logs_Sistema (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_admin INT NOT NULL,
    accion_realizada VARCHAR(255) NOT NULL,
    detalle_evento TEXT,
    fecha_evento DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_admin_log 
FOREIGN KEY (id_usuario_admin) REFERENCES Usuarios(id_usuario)
) ENGINE=InnoDB;

-- ==========================================================
-- INSERTAR DATOS DE PRUEBA (CORREGIDOS)
-- ==========================================================

-- Usuarios de prueba (CORREGIDO)
INSERT INTO Usuarios 
(primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, correo_electronico, contrasena, rol) 
VALUES
('Juan', NULL, 'Pérez', NULL, 'juan@sordo.com', 'hash_pass_1', 'Sordo'),
('Ana', NULL, 'García', NULL, 'ana@oyente.com', 'hash_pass_2', 'Oyente'),
('Carlos', NULL, 'Admin', NULL, 'carlos@admin.com', 'hash_pass_3', 'Administrador');

-- Catálogo de Dígitos
INSERT INTO Digitos (valor_numerico, descripcion_mano) VALUES
(0, 'Puño completamente cerrado'),
(1, 'Dedo índice levantado'),
(2, 'Dedos índice y medio levantados (forma de V)'),
(3, 'Dedos pulgar, índice y medio levantados'),
(4, 'Cuatro dedos levantados (sin el pulgar)'),
(5, 'Mano completamente abierta');

-- Interacción
INSERT INTO Interacciones 
(id_usuario_emisor, id_digito_detectado, precision_modelo) 
VALUES
(1, 4, 97.80);

-- Log
INSERT INTO Logs_Sistema 
(id_usuario_admin, accion_realizada, detalle_evento) 
VALUES
(3, 'Gestión de Usuarios', 'Se actualizó el perfil del usuario Juan Pérez');