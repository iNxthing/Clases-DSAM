class Visitantes:
    def __init__(self, nombre, edad, tipo_entrada):
        self.nombre = nombre
        self.edad = edad
        self.tipo_entrada = tipo_entrada

    def mostrar_informacion(self):
        print(f"Nombre: {self.nombre}, Edad: {self.edad}, Tipo de entrada: {self.tipo_entrada}")