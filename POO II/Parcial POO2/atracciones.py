
class Atracciones:
    def __init__(self, nombre, capacidad, edad_minima, detalle):
        self.nombre = nombre
        self.capacidad = capacidad
        self.edad_minima = edad_minima
        self.estado = False
        self.detalle = detalle
        
    def iniciar_atraccion(self):
        self.estado = True
        return f"La atracción {self.nombre} ha sido iniciada."
        

    def mostrar_informacion(self):
        print(f"Nombre: {self.nombre}")
        print(f"Capacidad: {self.capacidad}")
        print(f"Edad mínima: {self.edad_minima}")
        if self.estado:
            print(f"Estado: Abierta")
        else:
            print(f"Estado: Cerrada")
        print(f"Detalle: {self.detalle}")

