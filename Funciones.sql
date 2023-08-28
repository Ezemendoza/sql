DELIMITER //

CREATE FUNCTION PromedioSectoresPorEmpresa()
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE total_empresas INT;
    DECLARE total_sectores INT;
    DECLARE promedio FLOAT;

    SELECT COUNT(*) INTO total_empresas FROM EMPRESA;
    
    IF total_empresas > 0 THEN
        SELECT COUNT(*) INTO total_sectores FROM Sector;
        SET promedio = total_sectores / total_empresas;
    ELSE
        SET promedio = 0;
    END IF;

    RETURN promedio;
END //

DELIMITER ;




DELIMITER //

CREATE FUNCTION SumaCostoModulosActivados()
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE total_costo FLOAT;
    
    SELECT SUM(costo) INTO total_costo FROM MODULO WHERE activado = true;
    
    IF total_costo IS NULL THEN
        SET total_costo = 0;
    END IF;

    RETURN total_costo;
END //

DELIMITER ;


