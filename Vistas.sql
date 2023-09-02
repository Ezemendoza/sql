
-- Vista Permite ver los candidatos postulados, días que pasaron desde que se postulo, nombre de la empresa en la cual se postulo, numero de teléfono y link del cv del candidato
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rrhh`.`postulacionesconcandidatos` AS
    SELECT 
        `p`.`id_postulacion` AS `id_postulacion`,
        `c`.`nombre` AS `nombre_candidato`,
        (TO_DAYS(CURDATE()) - TO_DAYS(`p`.`fecha_postulacion`)) AS `Dias_desde_que_se_postulo`,
        `e`.`nombre` AS `nombre_empresa`,
        `c`.`telefono` AS `telefono_candidato`,
        `c`.`url_cv` AS `url_cv`
    FROM
        ((((`rrhh`.`postulacion` `p`
        JOIN `rrhh`.`publicacion` `pu` ON ((`p`.`id_publicacion` = `pu`.`id_publicacion`)))
        JOIN `rrhh`.`candidato` `c` ON ((`p`.`id_candidato` = `c`.`id_candidato`)))
        JOIN `rrhh`.`empresa` `e` ON ((`pu`.`Id_empresa` = `e`.`Id_empresa`)))
        JOIN `rrhh`.`sector` `s` ON ((`e`.`Id_empresa` = `e`.`Id_empresa`)));
        
        select DISTINCT  * from postulacionesconcandidatos ORDER BY id_postulacion ASC;
        
        
-- Permite ver la cantidad de personas que se encuentran en las distintas provincias por empresa
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rrhh`.`vista_empleados_por_empresa` AS
    SELECT 
        `e`.`provincia` AS `Provincia`,
        `em`.`nombre` AS `Nombre_empresa`,
        COUNT(`p`.`Id_personal`) AS `Total_Empleados`,
        ROUND(AVG(`e`.`edad`), 0) AS `Promedio_Edad`
    FROM
        (((`rrhh`.`datospersonales` `e`
        JOIN `rrhh`.`personal` `p` ON ((`e`.`id_personal` = `p`.`Id_personal`)))
        JOIN `rrhh`.`sector` `s` ON ((`p`.`id_sector` = `s`.`Id_sector`)))
        JOIN `rrhh`.`empresa` `em` ON ((`s`.`id_empresa` = `em`.`Id_empresa`)))
    GROUP BY `e`.`provincia` , `s`.`Id_sector` , `s`.`id_empresa` , `em`.`nombre`;
    
    select * from vista_empleados_por_empresa;
    
-- Permite ver al candidato con su respectiva información y el nombre del puesto al que se postuló
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rrhh`.`vistacandidatopostulacion` AS
    SELECT 
        `c`.`id_candidato` AS `id_candidato`,
        `c`.`nombre` AS `nombre_candidato`,
        `pu`.`titulo` AS `nombre_publicacion`,
        `c`.`telefono` AS `telefono_candidato`,
        `c`.`url_cv` AS `url_cv`,
        `p`.`fecha_postulacion` AS `fecha_postulacion`
    FROM
        ((`rrhh`.`candidato` `c`
        JOIN `rrhh`.`postulacion` `p` ON ((`c`.`id_candidato` = `p`.`id_candidato`)))
        JOIN `rrhh`.`publicacion` `pu` ON ((`p`.`id_publicacion` = `pu`.`id_publicacion`)));
        
        select * from vistacandidatopostulacion;
        
-- Permite ver todos los módulos activado de la empresa y su valor.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rrhh`.`vistamodulosporempresa` AS
    SELECT 
        `e`.`nombre` AS `NombreEmpresa`,
        `m`.`id_modulo` AS `IdModulo`,
        `m`.`activado` AS `ModuloActivado`,
        `m`.`costo` AS `CostoModulo`
    FROM
        (`rrhh`.`empresa` `e`
        JOIN `rrhh`.`modulo` `m` ON ((`e`.`Id_empresa` = `m`.`empresa_id`)));
        
select * from vistamodulosporempresa;


-- Permite ver todo el persona con su correspondiente empresa y sector.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rrhh`.`vistapersonasensectores` AS
    SELECT 
        `p`.`Id_personal` AS `Id_personal`,
        `e`.`nombre` AS `NombreEmpresa`,
        `s`.`direccion` AS `Sector`,
        `dp`.`nombre` AS `NombrePersonal`,
        `dp`.`apellido` AS `ApellidoPersonal`,
        `dp`.`edad` AS `EdadPersonal`,
        `dp`.`telefono` AS `TelefonoPersonal`,
        `dp`.`direccion` AS `DireccionPersonal`,
        `dp`.`altura` AS `AlturaDireccionPersonal`,
        `dp`.`codigo_postal` AS `CodigoPostalPersonal`,
        `dp`.`localidad` AS `LocalidadPersonal`,
        `dp`.`provincia` AS `ProvinciaPersonal`
    FROM
        (((`rrhh`.`personal` `p`
        JOIN `rrhh`.`sector` `s` ON ((`p`.`id_sector` = `s`.`Id_sector`)))
        JOIN `rrhh`.`datospersonales` `dp` ON ((`p`.`Id_personal` = `dp`.`id_personal`)))
        JOIN `rrhh`.`empresa` `e` ON ((`s`.`id_empresa` = `e`.`Id_empresa`)));
        
        select * from vistapersonasensectores ORDER BY Id_personal asc;
        
	-- Permite ver todos los sectores de las empresas con su respectivo líder.
    
    CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `rrhh`.`vistasectoresempresa` AS
    SELECT 
        `s`.`Id_sector` AS `Id_sector`,
        `s`.`direccion` AS `DireccionSector`,
        `s`.`descripcion` AS `DescripcionSector`,
        `l`.`nombre` AS `NombreLider`,
        `l`.`apellido` AS `ApellidoLider`,
        `l`.`fecha_ingreso` AS `FechaIngresoLider`,
        `e`.`nombre` AS `NombreEmpresa`
    FROM
        ((`rrhh`.`sector` `s`
        JOIN `rrhh`.`lider` `l` ON ((`s`.`Id_sector` = `l`.`id_sector`)))
        JOIN `rrhh`.`empresa` `e` ON ((`s`.`id_empresa` = `e`.`Id_empresa`)));
        
        select * from vistasectoresempresa;
        
	-- Por empresa mostrar a la empresa y la cantidad de facturas con su respectivo montos y la cantidad de empleados a pagar
CREATE VIEW vista_resumen_empresa AS
SELECT
    E.Id_empresa,
    E.nombre AS Empresa,
    COUNT(DISTINCT C.id_costo) AS CantidadFacturas,
    SUM(C.monto) AS MontoCostos,
    COUNT(DISTINCT DP.id_personal) AS CantidadEmpleados,
    SUM(DP.sueldo) AS MontoSueldos
FROM
    Empresa E
LEFT JOIN
    COSTO C ON E.Id_empresa = C.id_empresa
LEFT JOIN
    DatosPersonales DP ON E.Id_empresa = DP.id_empresa
GROUP BY
    E.Id_empresa, E.nombre;


select * from vista_resumen_empresa;
