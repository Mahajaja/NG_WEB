SELECT * FROM CATEGORIA

id_categoria	nombre_categoria	clasificacion
8	AGRÍCOLA	MAQUINARIA --
9	AGRÍCOLA	HERRAMIENTA
10	PESADA	MAQUINARIA


id_categoria	nombre_categoria	clasificacion
29	INSTALACIONES	MTTO


TODAS LAS UBICACIONES
--EN ESPERA POR EMPLEADOS
EQUIPO = CATEGORIA 


select * from MAQUINARIA

Combo de números economicos que se cargan dependiendo de categoria y ubicacion 
maquinaria informativo - este cambia en caso de que sea herramienta 

Asignado a -> capura
Horometro cuando sea mantenimiento de instalaciones no aparece 

Combo que se carga de la tabla de instalaciones cuando es mantenimiento de instalaciones = Nombre depende de ubicacion 
Descripcion sería USO 

GRADO DE URGENCIA SE CALCULA DEPENDIENDO DE LAS FECHAS QUE SELECCIONEN 
1 DIA URGENTE
2 A 4 ES MEDIO
5 EN ADELANTE ES BAJO

RESPONSABLE DE SOLUCION = SON LAS MISMAS DE QUIEN REPORTA
SI ES SERVICIO INTERNO SE LLENA UN COMBO CON 

USE NEO_GENESIS

SELECT E.id_empleado, E.nombre, E.apellido_paterno, E.apellido_materno FROM EMPLEADO E
INNER JOIN DEPARTAMENTO D ON E.id_departamento = D.id_departamento
WHERE E.id_departamento = 11

SELECT * FROM INSTALACION
