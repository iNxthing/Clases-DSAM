"""
EJEMPLO COMPLETO: Asociacion, Agregacion y Composicion en Python
------------------------------------------------------------------
Los 3 se ven en UN SOLO escenario (una universidad) para poder comparar
qué tan "dependientes" son los objetos entre sí:

- ASOCIACION:  Profesor <-> Curso
               Se conocen y colaboran, pero NINGUNO es dueño del otro.
               Un profesor sigue existiendo aunque el curso se cancele,
               y un curso puede seguir existiendo con otro profesor.

- AGREGACION:  Facultad --- Profesor
               La Facultad "tiene" profesores, pero son PRESTADOS: el
               profesor existía antes de unirse a la facultad, y si la
               facultad cierra, el profesor sigue existiendo (puede
               irse a trabajar a otra facultad).

- COMPOSICION: Universidad --- Facultad
               La Universidad CREA sus propias facultades en su propio
               constructor. Las facultades no tienen sentido ni pueden
               existir fuera de la universidad que las creó; si la
               universidad "muere", sus facultades mueren con ella.
"""


# ==========================================================================
# ASOCIACION: Profesor <-> Curso
# Ninguna clase "contiene" a la otra como parte. Simplemente se relacionan
# a través de un método: uno le pasa una referencia del otro para usarlo
# momentáneamente, pero cada objeto se crea y vive de forma 100% separada.
# ==========================================================================
class Curso:
    def __init__(self, nombre_curso, codigo):
        # El curso no guarda ninguna lista de profesores como atributo
        # permanente; eso es justamente lo que lo distingue de la
        # agregación/composición: no hay una relación de "pertenencia".
        self.nombre_curso = nombre_curso
        self.codigo = codigo


class Profesor:
    def __init__(self, nombre, cedula):
        # Igual que Curso: el profesor no "almacena" cursos como parte
        # de su estructura. Solo interactúa con ellos puntualmente.
        self.nombre = nombre
        self.cedula = cedula

    def dictar_clase(self, curso):
        # AQUI ocurre la asociación: el profesor RECIBE un curso como
        # parámetro (una simple referencia temporal), lo usa, y listo.
        # No hay relación de propiedad ni de ciclo de vida entre ellos.
        print(f"El profesor {self.nombre} está dictando el curso "
              f"'{curso.nombre_curso}' ({curso.codigo})")

    def calificar(self, curso, nota_promedio):
        # Otra interacción puntual con Curso: de nuevo, solo se "usa"
        # el objeto curso, no se vuelve parte permanente de Profesor.
        print(f"{self.nombre} registró nota promedio {nota_promedio} "
              f"en {curso.nombre_curso}")


# ==========================================================================
# AGREGACION: Facultad "tiene" Profesores, pero no los crea ni es dueña
# de su ciclo de vida. Los profesores se construyen POR FUERA y luego
# se "prestan" o asignan a la facultad.
# ==========================================================================
class Facultad:
    def __init__(self, nombre):
        self.nombre = nombre
        # Lista vacía: la Facultad NO fabrica profesores en su propio
        # constructor. Solo prepara un espacio para recibirlos después.
        # Esto es la clave de la agregación: el contenedor no controla
        # cuándo nace o muere cada parte.
        self.profesores = []

    def asignar_profesor(self, profesor):
        # Recibe un objeto Profesor que YA EXISTE de antes (fue creado
        # afuera, en el bloque de uso). La facultad solo guarda una
        # referencia a él, no toma posesión de su ciclo de vida.
        self.profesores.append(profesor)
        print(f"{profesor.nombre} fue asignado a la facultad {self.nombre}")

    def retirar_profesor(self, profesor):
        # Si se retira de la facultad, el objeto Profesor SIGUE
        # existiendo en memoria (puede seguir usándose afuera).
        # Eso es justamente lo que diferencia la agregación de la
        # composición: aquí "soltar" la parte no la destruye.
        self.profesores.remove(profesor)
        print(f"{profesor.nombre} fue retirado de {self.nombre}, "
              f"pero el profesor sigue existiendo como objeto")

    def listar_profesores(self):
        print(f"Profesores en {self.nombre}:")
        for p in self.profesores:
            print(f"  - {p.nombre}")


# ==========================================================================
# COMPOSICION: Universidad CREA sus propias Facultades dentro de su
# constructor. Las facultades no existen antes de la universidad, y no
# tiene sentido que una facultad "flote" sin universidad.
# ==========================================================================
class Universidad:
    def __init__(self, nombre):
        self.nombre = nombre
        # AQUI está la diferencia clave con la agregación: en vez de
        # dejar una lista vacía esperando objetos externos, la propia
        # Universidad INSTANCIA sus facultades en este mismo constructor.
        # Nadie por fuera de esta clase puede crear una Facultad "suelta"
        # que pertenezca a esta universidad.
        self.facultades = [
            Facultad("Ingeniería"),
            Facultad("Ciencias de la Salud"),
            Facultad("Ciencias Económicas"),
        ]
        print(f"Universidad '{self.nombre}' creada junto con "
              f"{len(self.facultades)} facultades propias")

    def listar_facultades(self):
        print(f"Facultades de {self.nombre}:")
        for f in self.facultades:
            print(f"  - {f.nombre}")

    def cerrar(self):
        # Al "cerrar" la universidad, sus facultades desaparecen con
        # ella (se pierde la única referencia que existía hacia ellas).
        # Esto simula el vínculo de ciclo de vida propio de la
        # composición: no había forma de que las facultades sobrevivieran
        # por fuera de esta universidad, porque nunca existieron aparte.
        print(f"Cerrando {self.nombre}... sus facultades se eliminan "
              f"junto con ella")
        self.facultades = []


# ==========================================================================
# USO DEL SISTEMA — aquí se ve la diferencia práctica entre las 3 relaciones
# ==========================================================================
if __name__ == "__main__":

    print("\n--- 1) COMPOSICION: la Universidad crea sus Facultades ---")
    uninorte = Universidad("Uninorte")
    uninorte.listar_facultades()
    # Tomamos una referencia a una facultad que YA fue creada por la
    # universidad, para poder seguir trabajando con ella más abajo.
    fac_ingenieria = uninorte.facultades[0]

    print("\n--- 2) AGREGACION: los Profesores existen antes y se asignan ---")
    # Los profesores se crean COMPLETAMENTE APARTE de cualquier facultad.
    # En este punto no pertenecen a nadie todavía.
    prof_ana = Profesor("Ana Gómez", cedula=1001)
    prof_luis = Profesor("Luis Rojas", cedula=1002)

    # Ahora sí los "prestamos" a la facultad de Ingeniería.
    fac_ingenieria.asignar_profesor(prof_ana)
    fac_ingenieria.asignar_profesor(prof_luis)
    fac_ingenieria.listar_profesores()

    # Retiramos a Luis de la facultad...
    fac_ingenieria.retirar_profesor(prof_luis)
    # ...pero el objeto prof_luis SIGUE EXISTIENDO y se puede seguir usando,
    # por ejemplo, dictando clases (asociación) sin pertenecer a ninguna
    # facultad en este momento:
    print(f"¿Sigue existiendo Luis? -> {prof_luis.nombre}, "
          f"cédula {prof_luis.cedula}")

    print("\n--- 3) ASOCIACION: Profesor y Curso se relacionan sin ")
    print("      pertenecer el uno al otro ---")
    curso_bd = Curso("Bases de Datos", codigo="ISW-204")
    prof_ana.dictar_clase(curso_bd)   # Ana "usa" el curso momentáneamente
    prof_ana.calificar(curso_bd, nota_promedio=4.3)
    # El curso jamás quedó "guardado" dentro de prof_ana ni viceversa;
    # fue solo una interacción puntual entre dos objetos independientes.

    print("\n--- Cerrando la universidad (demuestra la composición) ---")
    uninorte.cerrar()
    uninorte.listar_facultades()  # queda vacío: las facultades murieron
    # PERO los profesores (agregación) y el curso (asociación) siguen
    # existiendo en memoria, porque nunca dependieron del ciclo de vida
    # de la universidad:
    print(f"\nProfesor Ana sigue existiendo: {prof_ana.nombre}")
    print(f"Curso sigue existiendo: {curso_bd.nombre_curso}")