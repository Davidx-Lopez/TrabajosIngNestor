-- ===============================================
-- GANACONTROL - MÓDULOS DE GESTIÓN DE GANADO
-- Tablas adicionales para los módulos asignados
-- ===============================================

USE ganacontrol;

-- ===============================================
-- TABLA: ganado (Inventario)
-- ===============================================

CREATE TABLE IF NOT EXISTS ganado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(100),
    raza VARCHAR(100),
    sexo ENUM('Macho', 'Hembra') NOT NULL,
    fecha_nacimiento DATE,
    peso_actual DECIMAL(10,2),
    estado ENUM('Activo', 'Vendido', 'Muerto', 'Enfermo') DEFAULT 'Activo',
    foto VARCHAR(255),
    ubicacion VARCHAR(100),
    padre_id INT NULL,
    madre_id INT NULL,
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (padre_id) REFERENCES ganado(id) ON DELETE SET NULL,
    FOREIGN KEY (madre_id) REFERENCES ganado(id) ON DELETE SET NULL,
    
    INDEX idx_codigo (codigo),
    INDEX idx_usuario (usuario_id),
    INDEX idx_estado (estado),
    INDEX idx_sexo (sexo)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- TABLA: vacunacion
-- ===============================================

CREATE TABLE IF NOT EXISTS vacunacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    ganado_id INT NOT NULL,
    tipo_vacuna VARCHAR(100) NOT NULL,
    lote_vacuna VARCHAR(50),
    fecha_aplicacion DATE NOT NULL,
    dosis VARCHAR(50),
    via_administracion ENUM('Intramuscular', 'Subcutánea', 'Oral', 'Intranasal') DEFAULT 'Intramuscular',
    proxima_dosis DATE,
    veterinario VARCHAR(100),
    costo DECIMAL(10,2),
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (ganado_id) REFERENCES ganado(id) ON DELETE CASCADE,
    
    INDEX idx_usuario (usuario_id),
    INDEX idx_ganado (ganado_id),
    INDEX idx_fecha_aplicacion (fecha_aplicacion),
    INDEX idx_proxima_dosis (proxima_dosis)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- TABLA: reproduccion
-- ===============================================

CREATE TABLE IF NOT EXISTS reproduccion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    madre_id INT NOT NULL,
    padre_id INT,
    tipo_reproduccion ENUM('Natural', 'Inseminación Artificial') DEFAULT 'Natural',
    fecha_monta DATE,
    fecha_parto_estimada DATE,
    fecha_parto_real DATE,
    tipo_parto ENUM('Natural', 'Cesárea', 'Asistido') DEFAULT 'Natural',
    numero_crias INT DEFAULT 1,
    crias_vivas INT DEFAULT 0,
    estado ENUM('Gestante', 'Parida', 'Fallido', 'Abortado') DEFAULT 'Gestante',
    peso_crias TEXT,
    veterinario VARCHAR(100),
    costo DECIMAL(10,2),
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (madre_id) REFERENCES ganado(id) ON DELETE CASCADE,
    FOREIGN KEY (padre_id) REFERENCES ganado(id) ON DELETE SET NULL,
    
    INDEX idx_usuario (usuario_id),
    INDEX idx_madre (madre_id),
    INDEX idx_padre (padre_id),
    INDEX idx_estado (estado),
    INDEX idx_fecha_parto (fecha_parto_estimada)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- TABLA: peso
-- ===============================================

CREATE TABLE IF NOT EXISTS peso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    ganado_id INT NOT NULL,
    peso DECIMAL(10,2) NOT NULL,
    fecha_pesaje DATE NOT NULL,
    edad_dias INT,
    ganancia_diaria DECIMAL(10,2),
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (ganado_id) REFERENCES ganado(id) ON DELETE CASCADE,
    
    INDEX idx_usuario (usuario_id),
    INDEX idx_ganado (ganado_id),
    INDEX idx_fecha (fecha_pesaje)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- TABLA: produccion
-- ===============================================

CREATE TABLE IF NOT EXISTS produccion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    ganado_id INT NOT NULL,
    tipo_produccion ENUM('Leche', 'Carne', 'Queso', 'Yogurt', 'Crema', 'Otro') NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    unidad ENUM('Litros', 'Kilogramos', 'Unidades') NOT NULL,
    fecha_produccion DATE NOT NULL,
    turno ENUM('Mañana', 'Tarde', 'Noche') DEFAULT 'Mañana',
    calidad ENUM('Excelente', 'Buena', 'Regular', 'Mala'),
    precio_referencia DECIMAL(10,2),
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (ganado_id) REFERENCES ganado(id) ON DELETE CASCADE,
    
    INDEX idx_usuario (usuario_id),
    INDEX idx_ganado (ganado_id),
    INDEX idx_fecha (fecha_produccion),
    INDEX idx_tipo (tipo_produccion)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- TABLA: ventas
-- ===============================================

CREATE TABLE IF NOT EXISTS ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo_venta ENUM('Ganado', 'Producción', 'Mixta') NOT NULL,
    ganado_id INT,
    produccion_id INT,
    cliente_nombre VARCHAR(100) NOT NULL,
    cliente_telefono VARCHAR(20),
    cliente_email VARCHAR(100),
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2) NOT NULL,
    precio_total DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(10,2) DEFAULT 0,
    fecha_venta DATE NOT NULL,
    metodo_pago ENUM('Efectivo', 'Transferencia', 'Cheque', 'Tarjeta', 'Crédito') DEFAULT 'Efectivo',
    estado ENUM('Pendiente', 'Completada', 'Cancelada') DEFAULT 'Completada',
    factura_numero VARCHAR(50),
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (ganado_id) REFERENCES ganado(id) ON DELETE SET NULL,
    FOREIGN KEY (produccion_id) REFERENCES produccion(id) ON DELETE SET NULL,
    
    INDEX idx_usuario (usuario_id),
    INDEX idx_ganado (ganado_id),
    INDEX idx_cliente (cliente_nombre),
    INDEX idx_fecha (fecha_venta),
    INDEX idx_tipo (tipo_venta),
    INDEX idx_estado (estado)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- TABLA: alimentacion
-- ===============================================

CREATE TABLE IF NOT EXISTS alimentacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    ganado_id INT,
    tipo_alimento VARCHAR(100) NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    unidad VARCHAR(20) NOT NULL,
    fecha_suministro DATE NOT NULL,
    hora_suministro TIME,
    costo DECIMAL(10,2),
    observaciones TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (ganado_id) REFERENCES ganado(id) ON DELETE CASCADE,
    
    INDEX idx_usuario (usuario_id),
    INDEX idx_ganado (ganado_id),
    INDEX idx_fecha (fecha_suministro)
    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- VISTAS ÚTILES
-- ===============================================

-- Vista de producción diaria
CREATE OR REPLACE VIEW v_produccion_diaria AS
SELECT 
    DATE(fecha_produccion) as fecha,
    tipo_produccion,
    SUM(cantidad) as cantidad_total,
    unidad,
    COUNT(*) as numero_registros,
    AVG(cantidad) as promedio
FROM produccion
WHERE fecha_produccion >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY DATE(fecha_produccion), tipo_produccion, unidad
ORDER BY fecha DESC;

-- Vista de ventas mensuales
CREATE OR REPLACE VIEW v_ventas_mensuales AS
SELECT 
    YEAR(fecha_venta) as año,
    MONTH(fecha_venta) as mes,
    tipo_venta,
    COUNT(*) as num_ventas,
    SUM(precio_total) as total_ventas,
    AVG(precio_total) as venta_promedio
FROM ventas
WHERE estado = 'Completada'
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta), tipo_venta
ORDER BY año DESC, mes DESC;

-- Vista de ganado activo con última producción
CREATE OR REPLACE VIEW v_ganado_activo AS
SELECT 
    g.id,
    g.codigo,
    g.nombre,
    g.raza,
    g.sexo,
    g.peso_actual,
    g.estado,
    TIMESTAMPDIFF(MONTH, g.fecha_nacimiento, CURDATE()) as edad_meses,
    (SELECT MAX(fecha_produccion) FROM produccion WHERE ganado_id = g.id) as ultima_produccion,
    (SELECT SUM(cantidad) FROM produccion WHERE ganado_id = g.id AND fecha_produccion >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)) as produccion_mes
FROM ganado g
WHERE g.estado = 'Activo';

-- Vista de vacunaciones pendientes
CREATE OR REPLACE VIEW v_vacunaciones_pendientes AS
SELECT 
    v.id,
    g.codigo,
    g.nombre,
    v.tipo_vacuna,
    v.proxima_dosis,
    DATEDIFF(v.proxima_dosis, CURDATE()) as dias_restantes,
    CASE 
        WHEN DATEDIFF(v.proxima_dosis, CURDATE()) < 0 THEN 'Vencida'
        WHEN DATEDIFF(v.proxima_dosis, CURDATE()) <= 7 THEN 'Urgente'
        WHEN DATEDIFF(v.proxima_dosis, CURDATE()) <= 30 THEN 'Próxima'
        ELSE 'Planificada'
    END as prioridad
FROM vacunacion v
JOIN ganado g ON v.ganado_id = g.id
WHERE v.proxima_dosis IS NOT NULL 
AND v.proxima_dosis >= CURDATE() - INTERVAL 30 DAY
ORDER BY v.proxima_dosis ASC;

-- ===============================================
-- DATOS DE EJEMPLO (OPCIONAL - SOLO DESARROLLO)
-- ===============================================

-- Insertar ganado de ejemplo (ajustar usuario_id según tu usuario de prueba)
-- INSERT INTO ganado (usuario_id, codigo, nombre, raza, sexo, fecha_nacimiento, peso_actual, estado) VALUES
-- (1, 'G001', 'Margarita', 'Holstein', 'Hembra', '2022-03-15', 450.50, 'Activo'),
-- (1, 'G002', 'Bruno', 'Angus', 'Macho', '2021-08-20', 580.00, 'Activo'),
-- (1, 'G003', 'Lola', 'Jersey', 'Hembra', '2023-01-10', 380.25, 'Activo'),
-- (1, 'G004', 'Torito', 'Brahman', 'Macho', '2022-11-05', 520.75, 'Activo'),
-- (1, 'G005', 'Manchas', 'Holstein', 'Hembra', '2023-05-20', 340.00, 'Activo');

-- ===============================================
-- PROCEDIMIENTOS ALMACENADOS
-- ===============================================

-- Procedimiento para calcular ganancia de peso
DELIMITER $$

CREATE PROCEDURE calcular_ganancia_peso(IN p_ganado_id INT)
BEGIN
    DECLARE v_peso_anterior DECIMAL(10,2);
    DECLARE v_fecha_anterior DATE;
    DECLARE v_peso_actual DECIMAL(10,2);
    DECLARE v_fecha_actual DATE;
    DECLARE v_dias INT;
    DECLARE v_ganancia DECIMAL(10,2);
    
    -- Obtener los dos últimos pesos
    SELECT peso, fecha_pesaje INTO v_peso_actual, v_fecha_actual
    FROM peso 
    WHERE ganado_id = p_ganado_id 
    ORDER BY fecha_pesaje DESC 
    LIMIT 1;
    
    SELECT peso, fecha_pesaje INTO v_peso_anterior, v_fecha_anterior
    FROM peso 
    WHERE ganado_id = p_ganado_id 
    ORDER BY fecha_pesaje DESC 
    LIMIT 1 OFFSET 1;
    
    IF v_peso_anterior IS NOT NULL THEN
        SET v_dias = DATEDIFF(v_fecha_actual, v_fecha_anterior);
        SET v_ganancia = (v_peso_actual - v_peso_anterior) / v_dias;
        
        UPDATE peso 
        SET ganancia_diaria = v_ganancia 
        WHERE ganado_id = p_ganado_id 
        AND fecha_pesaje = v_fecha_actual;
    END IF;
END$$

DELIMITER ;

-- Procedimiento para estadísticas de producción
DELIMITER $$

CREATE PROCEDURE estadisticas_produccion(IN p_usuario_id INT, IN p_dias INT)
BEGIN
    SELECT 
        tipo_produccion,
        SUM(cantidad) as total,
        AVG(cantidad) as promedio,
        MIN(cantidad) as minimo,
        MAX(cantidad) as maximo,
        COUNT(*) as registros
    FROM produccion
    WHERE usuario_id = p_usuario_id
    AND fecha_produccion >= DATE_SUB(CURDATE(), INTERVAL p_dias DAY)
    GROUP BY tipo_produccion;
END$$

DELIMITER ;

-- ===============================================
-- TRIGGERS
-- ===============================================

-- Trigger para actualizar peso del ganado
DELIMITER $$

CREATE TRIGGER after_peso_insert
AFTER INSERT ON peso
FOR EACH ROW
BEGIN
    UPDATE ganado 
    SET peso_actual = NEW.peso 
    WHERE id = NEW.ganado_id;
    
    CALL calcular_ganancia_peso(NEW.ganado_id);
END$$

DELIMITER ;

-- Trigger para registrar en logs cuando se vende ganado
DELIMITER $$

CREATE TRIGGER after_venta_ganado
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    IF NEW.tipo_venta = 'Ganado' AND NEW.ganado_id IS NOT NULL THEN
        UPDATE ganado 
        SET estado = 'Vendido' 
        WHERE id = NEW.ganado_id;
        
        INSERT INTO logs_actividad (usuario_id, accion, descripcion)
        VALUES (NEW.usuario_id, 'VENTA_GANADO', 
                CONCAT('Venta de ganado ID: ', NEW.ganado_id, ' por $', NEW.precio_total));
    END IF;
END$$

DELIMITER ;

-- ===============================================
-- VERIFICACIÓN
-- ===============================================

-- Mostrar todas las tablas
SHOW TABLES;

-- Verificar estructuras
SELECT 
    TABLE_NAME, 
    TABLE_ROWS 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'ganacontrol' 
AND TABLE_NAME IN ('ganado', 'vacunacion', 'reproduccion', 'peso', 'produccion', 'ventas', 'alimentacion');

-- ===============================================
-- FIN DEL SCRIPT
-- ===============================================

SELECT 'Módulos de Gestión de Ganado instalados correctamente' as mensaje;