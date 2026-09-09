# from abc import abc

class Estudiante:
    def __init__(self,nombre, edad):
        self.nombre = nombre
        self.edad = edad
        
    def presentacion(self):
        return f"soy {self.nombre} y tengo {self.edad} años"
    


class Profesor:
    def __init__(self,nombre, edad,asignatura):
        self.nombre = nombre
        self.edad = edad
        self.asignatura = asignatura
        
    def presentacion(self):
        return f"soy {self.nombre} y tengo {self.edad} años y doy clases de {self.asignatura}"
    


class Curso:
    def __init__(self,nombre, cupos,profesor):
        self.nombre = nombre
        self.cupos = cupos
        self.profesor = profesor
        
    def mostrar_info(self):
        return f"Curso: {self.nombre} --Profesor: {self.profesor} --Cupos{self.cupos}"
    
p1 = Profesor.presentacion()
# class Animal:
#     def comer(self):
#         print("El animal esta comiendo")
        
# class Perro(Animal):
#     def ladrar(self):
#         print("Woof Woof")


# perro = Perro()

# perro.comer()
# perro.ladrar()



#-- COMPOSICION
# class Motor():
#     def encender(self):
#         print("Motor encendido")


# class Carro(Motor):
#     def __init__(self):
#         self.Motor = Motor()
        
#     def encender(self):
#         self.motor.encender()
        
#Asociacion
# class Profesor:
#     def __init__(self, nombre):
#         self.nombre = nombre
    
# class Curso:
#     def __init__(self,nombre):
#         self.nombre = nombre
#         self.profesor = None
        
#     def asignar_profesor(self,profesor):
#         self.profesor = profesor
        
# Profesor = Profesor("Nothing")
# curso = Curso("POO 2")

# curso.asignar_profesor(Profesor)

#Agregacion

# class Estudiante:
#     def __init__(self,nombre):
#         self.nombre = nombre

# class Curso:
#     def __init__(self,nombre,estudiantes):
#         self.nombre = nombre
#         self.estudiantes = estudiantes


# estudiante1 = Estudiante("Nothing")
# estudiante2 = Estudiante("R")

# curso = Curso("POO 2",[estudiante1,estudiante2])





# class Habitacion:
#     def __init__(self,numero):
#         self.numero = numero

# class Casa:
#     def __init__(self):
#         self.habitaciones = [Habitacion(1),Habitacion(2),Habitacion(3)]