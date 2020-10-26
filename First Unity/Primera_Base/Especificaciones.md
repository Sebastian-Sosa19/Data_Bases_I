

Ejercicio Bases de Datos.

Las tablas a crear son:
    - Gerencia
    - Departamento
    - Usuario
    - Lista
    - Tarea

Nótese que cada una de estas sigue un orden jerárquico de pertenencia.
Una tarea pertenece a una lista, una lista pertenece a un usuario, un usuario pertenece a un departamento, y un departamento pertenece a una gerencia.

Los atributos, que luego se convertirán en la columna de cada tabla, son los siguientes:
    - Para Gerencia:
        - id
        - nombre_gr
    
    - Para Departamento:
        - id
        - id_ger (Hace referencia a la gerencia a la que pertenece)
        - nombre_dp
    
    - Para Usuario:
        - id
        - id_dp (Hace referencia al Departamento al que pertenece)
        - nombre_us
    
    - Para Lista:
        - id
        - id_us (Hace referencia al Usuario al que pertenece)
        - fecha
        - estado (vigente como default, archviada, eliminada)
    
    - Para Tarea:
        - id
        - id_ls (Hace referencia a la Lista a la que pertenece)
        - descripcion
        - fecha
        - estado (completado, no completado como default)