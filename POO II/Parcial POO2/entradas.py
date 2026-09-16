from visitantes import Visitantes
from atracciones import Atracciones

class Entradas:
    def __init__(self, visitante, atraccion, tipo_entrada):
        self.visitante = visitante
        self.atraccion = atraccion
        self.tipo_entrada = tipo_entrada

    def validar_entrada(self):
        if self.visitante.edad >= self.atraccion.edad_minima:
            print(f"{self.visitante.nombre} puede entrar a {self.atraccion.nombre}")
        elif self.visitante.edad < self.atraccion.edad_minima:
            print(f"{self.visitante.nombre} no puede entrar a {self.atraccion.nombre}")
            return
        elif self.atraccion.estado != True:
            print(f"{self.atraccion.nombre} no está abierta en este momento")