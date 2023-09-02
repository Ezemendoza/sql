USE rrhh;

DELIMITER //

CREATE TRIGGER desaprobar_postulacion
BEFORE INSERT ON Postulacion
FOR EACH ROW
BEGIN
    DECLARE today_date DATE;
    DECLARE created_date DATE;
    
    SET today_date = CURDATE();
    
    -- Obtener la fecha de creación de la publicación relacionada
    SELECT 
        fecha_creacion
    INTO created_date 
    FROM
        Publicacion
    WHERE
        id_publicacion = NEW.id_publicacion;
    
    IF DATEDIFF(today_date, created_date) > 90 THEN
        SET NEW.estado = 'Rechazado';
    END IF;
END;
//

DELIMITER ;





DELIMITER //

CREATE TRIGGER eliminar_publicacion
BEFORE INSERT ON Publicacion
FOR EACH ROW
BEGIN
    DECLARE today_date DATE;
    DECLARE created_date DATE;
    
    SET today_date = CURDATE();
    SET created_date = NEW.fecha_creacion;
    
    IF DATEDIFF(today_date, created_date) > 180 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La publicación ha sido eliminada debido a la falta de aprobación en 6 meses';
    END IF;
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
DELIMITER //


CREATE TRIGGER replica_datos_personales
BEFORE UPDATE ON DatosPersonales
FOR EACH ROW
BEGIN
    INSERT INTO HistorialCamposCambiados
    (id_personal, edad, nombre, apellido, telefono, direccion, altura, codigo_postal, localidad, provincia, nombre_actualizo, fecha_actualizado, hora_actualizado)
    VALUES
    (OLD.id_personal, OLD.edad, OLD.nombre, OLD.apellido, OLD.telefono, OLD.direccion, OLD.altura, OLD.codigo_postal, OLD.localidad, OLD.provincia, 'Trigger', CURDATE(), CURTIME());
END;
//

DELIMITER ;

DELIMITER //

-- Trigger para la tabla Postulacion
CREATE TRIGGER replica_postulacion
BEFORE UPDATE ON Postulacion
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPostulacion
    (id_postulacion, id_publicacion, id_candidato, fecha_postulacion, estado, hora_actualizado, fecha_actualizado)
    VALUES
    (OLD.id_postulacion, OLD.id_publicacion, OLD.id_candidato, OLD.fecha_postulacion, OLD.estado, CURTIME(), CURDATE());
END;
//

DELIMITER ;

