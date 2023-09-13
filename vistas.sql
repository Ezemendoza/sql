-- Permite ver la cantidad de personas que se encuentran en las distintas provincias por empresa
CREATE VIEW `rrhh`.`vista_empleados_por_empresa` AS
SELECT 
    `dp`.`provincia` AS `Provincia`,
    `em`.`nombre` AS `Nombre_empresa`,
    COUNT(`pe`.`Id_personal`) AS `Total_Empleados`,
    ROUND(AVG(`dp`.`edad`), 0) AS `Promedio_Edad`
FROM
    `rrhh`.`empresa` AS `em`
    JOIN `rrhh`.`sector` AS `se` ON `em`.`Id_empresa` = `se`.`id_empresa`
    JOIN `rrhh`.`personal` AS `pe` ON `se`.`Id_sector` = `pe`.`id_sector`
    JOIN `rrhh`.`datospersonales` AS `dp` ON `pe`.`Id_personal` = `dp`.`id_personal`
GROUP BY `em`.`provincia`, `em`.`Id_empresa`;

SELECT * FROM `vista_empleados_por_empresa`;



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
        
        select * from `vistacandidatopostulacion`;
        
        -- Permite ver todos los módulos activados de la empresa y su valor.
CREATE VIEW `rrhh`.`vistamodulosporempresa` AS
SELECT 
    `e`.`Id_empresa` AS `IdEmpresa`,
    `e`.`nombre` AS `NombreEmpresa`,
    `m`.`id_modulo` AS `IdModulo`,
    `m`.`activado` AS `ModuloActivado`,
    `m`.`costo` AS `CostoModulo`
FROM
    `rrhh`.`empresa` `e`
JOIN
    `rrhh`.`modulo` `m` ON `e`.`Id_empresa` = `m`.`id_empresa`
WHERE
    `m`.`activado` = TRUE
GROUP BY
    `e`.`Id_empresa`, `m`.`id_modulo`;

SELECT * FROM `vistamodulosporempresa`;


-- Vista para ver personas con su correspondiente empresa y sector:
CREATE VIEW `rrhh`.`vistapersonasensectores` AS
SELECT 
    `pe`.`Id_personal` AS `Id_personal`,
    `em`.`nombre` AS `NombreEmpresa`,
    `se`.`direccion` AS `Sector`,
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
    `rrhh`.`personal` AS `pe`
    JOIN `rrhh`.`sector` AS `se` ON `pe`.`id_sector` = `se`.`Id_sector`
    JOIN `rrhh`.`datospersonales` AS `dp` ON `pe`.`Id_personal` = `dp`.`id_personal`
    JOIN `rrhh`.`empresa` AS `em` ON `se`.`id_empresa` = `em`.`Id_empresa`;

SELECT * FROM `vistapersonasensectores` ORDER BY `Id_personal` ASC;







-- Vista para ver todos los sectores de las empresas con su respectivo líder:

CREATE VIEW `rrhh`.`vistasectoresempresa` AS
SELECT 
    `se`.`Id_sector` AS `Id_sector`,
    `se`.`direccion` AS `DireccionSector`,
    `se`.`descripcion` AS `DescripcionSector`,
    `li`.`nombre` AS `NombreLider`,
    `li`.`apellido` AS `ApellidoLider`,
    `li`.`fecha_ingreso` AS `FechaIngresoLider`,
    `em`.`nombre` AS `NombreEmpresa`
FROM
    `rrhh`.`sector` AS `se`
    JOIN `rrhh`.`lider` AS `li` ON `se`.`Id_sector` = `li`.`id_sector`
    JOIN `rrhh`.`empresa` AS `em` ON `se`.`id_empresa` = `em`.`Id_empresa`;

SELECT * FROM `vistasectoresempresa`;

-- Vista para mostrar resumen de empresa con cantidad de facturas y sueldos:
CREATE VIEW `vista_resumen_empresa` AS
SELECT
    e.Id_empresa AS id_empresa,
    e.nombre AS nombre_empresa,
    SUM(dp.sueldo) AS total_sueldos,
    SUM(co.monto) AS total_facturas
FROM
    Empresa e
LEFT JOIN
    Sector s ON e.Id_empresa = s.id_empresa
LEFT JOIN
    Lider l ON s.Id_sector = l.id_sector
LEFT JOIN
    Personal p ON s.Id_sector = p.id_sector
LEFT JOIN
    DatosPersonales dp ON p.Id_personal = dp.id_personal
LEFT JOIN
    Costo co ON e.Id_empresa = co.id_empresa
GROUP BY
    e.Id_empresa, e.nombre;


select * from `vista_resumen_empresa`;

