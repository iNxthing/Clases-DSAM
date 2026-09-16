from atracciones import Atracciones
from visitantes import Visitantes
from entradas import Entradas


class Parque:
    def __init__(self, nombre):
        self.nombre = nombre
        self.atracciones = []
        self.visitantes = []

    def agregar_atraccion(self, atraccion):
        self.atracciones.append(atraccion)
        
    def agregar_visitante(self, visitante):
        self.visitantes.append(visitante)

    def eliminar_atraccion(self, nombre):
        atraccion = self.buscar_atraccion(nombre)
        if atraccion is not None:
            self.atracciones.remove(atraccion)
            print(f"Se eliminó la atracción: {nombre}")
        else:
            print("La atraccion no se encuentra en el parque")

    def buscar_atraccion(self, nombre):
        for atraccion in self.atracciones:
            if atraccion.nombre == nombre:
                return atraccion
        return None

    def mostrar_informacion(self):
        print(f"Nombre del parque: {self.nombre}")
        print("Atracciones:")
        if not self.atracciones:
            print("No hay atracciones registradas.")
            return
        for atraccion in self.atracciones:
            atraccion.mostrar_informacion()
            print()

    def menu(self):
        while True:
            print("\n--- Menú del Parque ---")
            print("1. Iniciar atraccion")
            print("\n2. Agregar atraccion")
            print("3. Registrar visitante")
            print("4. Eliminar atraccion")
            print("5. Buscar atraccion")
            print("6. Mostrar informacion del parque")
            print("7. Salir")
            opcion = input("Seleccione una opcion: ")
            if opcion == "1":
                nombre = input("Ingrese el nombre de la atraccion a iniciar: ")
                atraccion = self.buscar_atraccion(nombre)
                if atraccion is not None:
                    print(atraccion.iniciar_atraccion())
                else:
                    print("La atraccion no se encuentra en el parque")
            elif opcion == "2":
                nombre = input("Ingrese el nombre de la atraccion: ")
                capacidad = int(input("Ingrese la capacidad de la atraccion: "))
                edad_minima = int(input("Ingrese la edad minima para la atraccion: "))
                detalle = input("Ingrese el detalle: ")
                nueva_atraccion = Atracciones(nombre, capacidad, edad_minima, detalle)
                self.agregar_atraccion(nueva_atraccion)
            elif opcion == "3":
                nombre = input("Ingrese el nombre del visitante: ")
                edad = int(input("Ingrese la edad del visitante: "))
                nombre_atraccion = input("Ingrese el nombre de la atraccion a la que desea ingresar: ")
                atraccion = self.buscar_atraccion(nombre_atraccion)
                if atraccion is None:
                    print("La atraccion no se encuentra en el parque")
                    continue
                tipo = input("Ingrese el tipo de visitante ( General o VIP): ")
                nuevo_visitante = Visitantes(nombre, edad, tipo)
                self.agregar_visitante(nuevo_visitante)
                entrada = Entradas(nuevo_visitante, atraccion, tipo)
                entrada.validar_entrada()

            elif opcion == "4":
                nombre = input("Ingrese el nombre de la atraccion a eliminar: ")
                self.eliminar_atraccion(nombre)

            elif opcion == "5":
                nombre = input("Ingrese el nombre de la atraccion a buscar: ")
                atraccion = self.buscar_atraccion(nombre)
                if atraccion is not None:
                    print("La atraccion se encuentra en el parque")
                    atraccion.mostrar_informacion()
                else:
                    print("La atraccion no se encuentra en el parque")

            elif opcion == "6":
                self.mostrar_informacion()

            elif opcion == "7":
                break

            else:
                print("Opcion invalida")
