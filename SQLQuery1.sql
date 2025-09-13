CREATE DATABASE GameStore2;
USE GameStore2;

CREATE TABLE Tabla_Ganancias (
    ID_JUEGO INT PRIMARY KEY,
    TITULO VARCHAR(50) NOT NULL, 
    PRESUPUESTO DECIMAL(10,2) DEFAULT 0,
    GANANCIAS DECIMAL(10,2),
    ID_DESARROLLADOR INT UNIQUE 
);

CREATE TABLE Tabla_Desarrollador ( 
    ID_DESARROLLADOR INT PRIMARY KEY, 
    AÑO_LANZAMIENTO DATE NOT NULL, 
    PLATAFORMA VARCHAR(50) DEFAULT 'Multiplataforma',
    ID_JUEGO INT UNIQUE, 
    FOREIGN KEY (ID_JUEGO) REFERENCES Tabla_Ganancias (ID_JUEGO)
);

CREATE TABLE Tabla_Reseñas ( 
    ID_RESEÑAS VARCHAR(2) PRIMARY KEY,
    ID_JUEGO INT NOT NULL,
    RESEÑAS_CRITICOS DECIMAL(3,1) DEFAULT 0,
    FOREIGN KEY (ID_JUEGO) REFERENCES Tabla_Ganancias (ID_JUEGO)
);

-- INGRESO DE DATOS
INSERT INTO Tabla_Ganancias (ID_JUEGO, TITULO, PRESUPUESTO, GANANCIAS, ID_DESARROLLADOR) 
VALUES
('1', 'GTA_V', 265, 1000, '101'), 
('2', 'The_Legend_of_Zelda', 100, 700, '202'),
('3', 'SEKIRO_Shadows_Die_Twice', 184, 626, '303'),
('4', 'Cyberpunk', 316, 800, '404'), 
('5', 'Call_of_Duty', 575, 1000, '505'),
('6', 'Marvel_Spider_Man', 100, 180, '606'),
('7', 'Red_Dead_Redemption_2', 370, 1200, '707'),
('8', 'Elden_Ring', 200, 900, '808'),
('9', 'God_of_War', 150, 500, '909'),
('10', 'The_Witcher_3', 81, 500, '1010');

INSERT INTO Tabla_Desarrollador (ID_DESARROLLADOR, AÑO_LANZAMIENTO, PLATAFORMA, ID_JUEGO)
VALUES
('101', '2013-09-17', 'Multiplataforma', '1'),
('202', '2023-05-12', 'Nintendo', '2'),
('303', '2022-02-25', 'Multiplataforma', '3'),
('404', '2020-12-10', 'Multiplataforma', '4'),
('505', '2022-10-28', 'Multiplataforma', '5'),
('606', '2018-09-07', 'PlayStation', '6'),
('707', '2018-10-26', 'Multiplataforma', '7'),
('808', '2022-02-25', 'Multiplataforma', '8'),
('909', '2018-04-20', 'PlayStation', '9'),
('1010', '2015-05-19', 'Multiplataforma', '10');

INSERT INTO Tabla_Reseñas (ID_RESEÑAS, ID_JUEGO, RESEÑAS_CRITICOS)
VALUES
('01', '1', '9.7'),
('02', '2', '9.6'),
('03', '3', '9.6'),
('04', '4', '7.4'),
('05', '5', '7.9'),
('06', '6', '8.7'),
('07', '7', '9.8'),
('08', '8', '9.5'),
('09', '9', '9.4'),
('10', '10', '9.3');


-- OPERACIONES ORIGINALES (Santiago García)
SELECT * FROM Tabla_Ganancias;
UPDATE Tabla_Ganancias
SET TITULO = 'Sifu', PRESUPUESTO = '1000', GANANCIAS = '100', ID_DESARROLLADOR = '505'
WHERE ID_JUEGO = 5;

SELECT * FROM Tabla_Ganancias;
DELETE FROM Tabla_Reseñas WHERE ID_JUEGO = 8;
DELETE FROM Tabla_Desarrollador WHERE ID_JUEGO = 8;
DELETE FROM Tabla_Ganancias WHERE ID_JUEGO = 8;

ALTER TABLE Tabla_Ganancias
DROP COLUMN GANANCIAS;


SELECT 
    G.TITULO,
    G.GANANCIAS,
    D.PLATAFORMA,
    D.AÑO_LANZAMIENTO
FROM Tabla_Ganancias G
INNER JOIN Tabla_Desarrollador D ON G.ID_JUEGO = D.ID_JUEGO;

-- Valentina Díaz
-- Update

SELECT * FROM Tabla_Ganancias;
UPDATE Tabla_Ganancias
SET TITULO = 'Super Mario Party Jamboree', PRESUPUESTO = '1000', GANANCIAS = '100', ID_DESARROLLADOR = '202'
WHERE ID_JUEGO = 2;

--Delete

DELETE FROM Tabla_Reseñas WHERE ID_JUEGO = 4;
DELETE FROM Tabla_Desarrollador WHERE ID_JUEGO = 4;
DELETE FROM Tabla_Ganancias WHERE ID_JUEGO = 4;

SELECT * FROM Tabla_Ganancias;

--INNER JOIN

SELECT 
    G.TITULO,
    D.PLATAFORMA,
    G.GANANCIAS,
    G.PRESUPUESTO,
    D.AÑO_LANZAMIENTO
FROM Tabla_Desarrollador D 
INNER JOIN Tabla_Ganancias G ON G.ID_JUEGO = D.ID_JUEGO;

--Alter Table

ALTER TABLE Tabla_Ganancias
ADD GANANCIAS DECIMAL(10,2);

SELECT * FROM Tabla_Ganancias
SELECT * FROM Tabla_Desarrollador
SELECT * FROM Tabla_Reseñas



--Bonus

-- Máximas y mínimas ganancias
SELECT 
    MAX(PRESUPUESTO) AS Maxima_PRESUPUESTO,
    MIN(PRESUPUESTO) AS Minima_PRESUPUESTO,
    AVG(PRESUPUESTO) AS Promedio_PRESUPUESTO
FROM Tabla_Ganancias;

SELECT * 
FROM Tabla_Ganancias;


-- Juegos con mejor ROI (Return on Investment)
SELECT 
    TITULO,
    GANANCIAS,
    PRESUPUESTO,
    (GANANCIAS/PRESUPUESTO) AS ROI
FROM Tabla_Ganancias
ORDER BY ROI DESC;

-- Procedimiento almacenado para buscar juegos por plataforma 

CREATE PROCEDURE FiltradoPorPlataforma1
    @PLATAFORMA VARCHAR(50)
AS 
BEGIN
    SELECT 
        PLATAFORMA,
        ID_DESARROLLADOR,
        AÑO_LANZAMIENTO,
        ID_JUEGO
    FROM Tabla_Desarrollador
    WHERE PLATAFORMA = @PLATAFORMA
    ORDER BY AÑO_LANZAMIENTO DESC;
END;
GO

-- Ejecutar el procedimiento con comillas
EXEC FiltradoPorPlataforma1 @PLATAFORMA = 'PlayStation';
EXEC FiltradoPorPlataforma1 @PLATAFORMA = 'Nintendo';

-- Procedimiento almacenado para buscar juegos por presupuesto 

CREATE PROCEDURE FiltradoPorPresupuesto
    @PRESUPUESTO DECIMAL(10,2)
AS 
BEGIN
    SELECT 
        ID_JUEGO,
        TITULO,
        PRESUPUESTO,
        ID_DESARROLLADOR,
        GANANCIAS
    FROM Tabla_Ganancias
    WHERE PRESUPUESTO = @PRESUPUESTO
    ORDER BY PRESUPUESTO DESC;
END;
GO
-- Buscar juegos con presupuesto exacto de 100
EXEC FiltradoPorPresupuesto @PRESUPUESTO = 100.00;

