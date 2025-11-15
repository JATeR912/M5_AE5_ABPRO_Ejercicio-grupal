CREATE DATABASE eco_electronicos;
USE eco_electronicos;

CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(100) NOT NULL,
  direccion_cliente VARCHAR(150) NOT NULL,
  telefono_cliente VARCHAR(15) NOT NULL,
  correo_cliente VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE articulos_reciclados (
  id_articulo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_articulo VARCHAR(100) NOT NULL,
  precio_articulo DECIMAL(10,2) NOT NULL CHECK (precio_articulo >= 0),
  descripcion_articulo TEXT
);

CREATE TABLE solicitudes_retiros (
  id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  fecha_solicitud DATETIME NOT NULL,
  fecha_retiro DATETIME NOT NULL,
  estado_solicitud ENUM('Pendiente','En Proceso','Completada','Cancelada') NOT NULL DEFAULT 'Pendiente',
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE solicitudes_articulos (
  id_solicitud INT NOT NULL,
  id_articulo INT NOT NULL,
  cantidad_articulo INT NOT NULL CHECK (cantidad_articulo > 0),
  PRIMARY KEY (id_solicitud, id_articulo),
  FOREIGN KEY (id_solicitud) REFERENCES solicitudes_retiros(id_solicitud),
  FOREIGN KEY (id_articulo) REFERENCES articulos_reciclados(id_articulo)
);

CREATE TABLE vehiculos (
  id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
  patente_vehiculo VARCHAR(10) NOT NULL UNIQUE,
  modelo_vehiculo VARCHAR(50) NOT NULL,
  capacidad_vehiculo INT NOT NULL CHECK (capacidad_vehiculo > 0),
  disponibilidad_vehiculo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE vehiculos_solicitudes (
  id_vehiculo INT NOT NULL,
  id_solicitud INT NOT NULL,
  PRIMARY KEY (id_vehiculo, id_solicitud),
  FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
  FOREIGN KEY (id_solicitud) REFERENCES solicitudes_retiros(id_solicitud)
);
