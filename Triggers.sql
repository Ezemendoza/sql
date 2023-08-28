DELIMITER //
CREATE TRIGGER update_num_empleados_sector
AFTER INSERT ON Personal
FOR EACH ROW
BEGIN
    UPDATE Sector
    SET num_empleados = num_empleados + 1
    WHERE Id_sector = NEW.id_sector;
END;
//
DELIMITER ;



DELIMITER //
CREATE TRIGGER update_estado_postulacion
AFTER UPDATE ON Postulacion
FOR EACH ROW
BEGIN
    IF NEW.estado = 'Aprobado' THEN
        UPDATE Publicacion
        SET plazas_disponibles = plazas_disponibles - 1
        WHERE Id_publicacion = NEW.Id_publicacion;
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_num_postulaciones_candidato
AFTER INSERT ON Postulacion
FOR EACH ROW
BEGIN
    UPDATE Candidato
    SET num_postulaciones = num_postulaciones + 1
    WHERE id_candidato = NEW.id_candidato;
END;
//
DELIMITER ;




DELIMITER //
CREATE TRIGGER eliminar_postulaciones
AFTER DELETE ON Publicacion
FOR EACH ROW
BEGIN
    DELETE FROM Postulacion WHERE Id_publicacion = OLD.id_publicacion;
END;
//
DELIMITER ;
