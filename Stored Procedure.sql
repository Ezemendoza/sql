DELIMITER //

CREATE PROCEDURE DesactivarModulosPorEmpresa(
    IN idEmpresa INT
)
BEGIN
    UPDATE MODULO
    SET activado = false
    WHERE empresa_id = idEmpresa;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE EliminarEmpresaConDatosRelacionados(
    IN idEmpresa INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM Postulacion WHERE Id_publicacion IN (SELECT id_publicacion FROM Publicacion WHERE Id_empresa = idEmpresa);
    DELETE FROM Publicacion WHERE Id_empresa = idEmpresa;
    DELETE FROM MODULO WHERE empresa_id = idEmpresa;
    DELETE FROM Sector WHERE id_empresa = idEmpresa;
    DELETE FROM Lider WHERE id_sector IN (SELECT id_sector FROM Sector WHERE id_empresa = idEmpresa);
    DELETE FROM Personal WHERE id_sector IN (SELECT id_sector FROM Sector WHERE id_empresa = idEmpresa);
    DELETE FROM PETICIONES WHERE id_personal IN (SELECT Id_personal FROM Personal WHERE id_sector IN (SELECT id_sector FROM Sector WHERE id_empresa = idEmpresa));
    DELETE FROM OrdenPeticiones WHERE id_lider IN (SELECT Id_lider FROM Lider WHERE id_sector IN (SELECT id_sector FROM Sector WHERE id_empresa = idEmpresa));
    DELETE FROM DatosPersonales WHERE id_personal IN (SELECT Id_personal FROM Personal WHERE id_sector IN (SELECT id_sector FROM Sector WHERE id_empresa = idEmpresa));
    DELETE FROM Candidato WHERE Id_publicacion IN (SELECT id_publicacion FROM Publicacion WHERE Id_empresa = idEmpresa);
    DELETE FROM Candidato WHERE Id_publicacion IN (SELECT Id_publicacion FROM Publicacion WHERE Id_empresa = idEmpresa);
    DELETE FROM Empresa WHERE Id_empresa = idEmpresa;

    COMMIT;
END //

DELIMITER ;