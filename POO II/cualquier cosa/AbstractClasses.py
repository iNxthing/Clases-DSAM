"""
EJEMPLO COMPLETO: Clase Abstracta en Python
--------------------------------------------
Analogía: la clase abstracta 'Empleado' es como un MOLDE de contrato laboral.
El molde ya trae ciertas casillas llenas (métodos concretos, iguales para
todos), pero deja otras casillas EN BLANCO (métodos abstractos) que cada
tipo de empleado debe llenar a su manera, porque cada uno calcula su pago
de forma distinta.
"""

from abc import ABC, abstractmethod
from datetime import date


class Empleado(ABC):
    """
    Clase abstracta = el MOLDE.
    No se puede crear un 'Empleado' genérico directamente (no tiene sentido
    en la vida real: todo empleado es de ALGÚN tipo específico).
    """

    # --- Atributos que TODOS los empleados van a tener, sin excepción ---
    def __init__(self, nombre, identificacion, fecha_ingreso, departamento):
        # Estos atributos se guardan igual sin importar el tipo de empleado.
        # Por eso viven en la clase base: para no repetir código en cada subclase.
        self.nombre = nombre
        self.identificacion = identificacion
        self.fecha_ingreso = fecha_ingreso
        self.departamento = departamento
        self.activo = True  # todo empleado nuevo entra como activo

    # ------------------------------------------------------------------
    # MÉTODOS ABSTRACTOS ("casillas en blanco" del molde)
    # No tienen cuerpo real (solo 'pass'), porque su lógica CAMBIA según
    # el tipo de empleado. Python obliga a que cada subclase los rellene;
    # si una subclase se olvida de alguno, Python no la deja crear objetos.
    # ------------------------------------------------------------------

    @abstractmethod
    def calcular_salario(self):
        """Cada tipo de empleado calcula su salario de forma distinta."""
        pass

    @abstractmethod
    def calcular_bonificacion(self):
        """La bonificación también depende del tipo de contrato."""
        pass

    @abstractmethod
    def tipo_contrato(self):
        """Devuelve un texto describiendo el tipo de contrato (para reportes)."""
        pass

    # ------------------------------------------------------------------
    # MÉTODOS CONCRETOS ("casillas ya llenas" del molde)
    # Tienen cuerpo real y se heredan TAL CUAL. Como el cálculo o la
    # lógica es igual para todos los empleados, no tiene sentido que cada
    # subclase lo vuelva a escribir: eso sería repetir código.
    # ------------------------------------------------------------------

    def antiguedad_en_anios(self):
        """
        Método concreto: calcula la antigüedad. Es igual para todos los
        empleados (una simple resta de fechas), así que se define UNA
        sola vez aquí y todas las subclases lo heredan gratis.
        """
        hoy = date.today()
        return hoy.year - self.fecha_ingreso.year

    def aplicar_descuento_salud(self, porcentaje=0.04):
        """
        Método concreto que SÍ depende de un método abstracto
        (calcular_salario). Esto es clave: la clase abstracta puede
        combinar métodos abstractos dentro de métodos concretos.
        Python no sabe todavía CÓMO se calcula el salario (eso lo
        decide la subclase), pero sí sabe QUÉ hacer con ese resultado.
        """
        salario = self.calcular_salario()  # usa la versión de la subclase
        descuento = salario * porcentaje
        return round(salario - descuento, 2)

    def desactivar(self):
        """Método concreto simple: cambia el estado, igual para todos."""
        self.activo = False
        print(f"{self.nombre} ha sido desactivado del sistema.")

    def mostrar_info(self):
        """
        Método concreto que arma un reporte combinando:
        - atributos propios de la clase base (nombre, departamento, etc.)
        - un método concreto (antiguedad_en_anios)
        - métodos abstractos que cada subclase implementa distinto
          (tipo_contrato, calcular_salario, calcular_bonificacion)
        Esto demuestra el VALOR real de la abstracción: este método
        funciona para CUALQUIER subclase futura, sin modificarlo nunca.
        """
        print("=" * 40)
        print(f"Nombre:         {self.nombre}")
        print(f"ID:             {self.identificacion}")
        print(f"Departamento:   {self.departamento}")
        print(f"Tipo contrato:  {self.tipo_contrato()}")
        print(f"Antigüedad:     {self.antiguedad_en_anios()} año(s)")
        print(f"Salario bruto:  ${self.calcular_salario():,.2f}")
        print(f"Bonificación:   ${self.calcular_bonificacion():,.2f}")
        print(f"Salario neto:   ${self.aplicar_descuento_salud():,.2f}")
        print("=" * 40)


# ==========================================================================
# SUBCLASE 1: EmpleadoTiempoCompleto
# Debe implementar OBLIGATORIAMENTE los 3 métodos abstractos del molde.
# Si le faltara alguno, Python lanzaría TypeError al intentar instanciarla.
# ==========================================================================
class EmpleadoTiempoCompleto(Empleado):
    def __init__(self, nombre, identificacion, fecha_ingreso, departamento,
                 salario_mensual):
        # super().__init__() reutiliza el constructor del molde,
        # para no reescribir nombre, identificacion, etc. otra vez.
        super().__init__(nombre, identificacion, fecha_ingreso, departamento)
        self.salario_mensual = salario_mensual  # atributo propio de ESTA subclase

    def calcular_salario(self):
        # Regla propia: el salario es simplemente el fijo mensual.
        return self.salario_mensual

    def calcular_bonificacion(self):
        # Regla propia: bono fijo del 10% del salario por cada año trabajado,
        # con un tope de 3 años para el cálculo del bono.
        anios = min(self.antiguedad_en_anios(), 3)
        return self.salario_mensual * 0.10 * anios

    def tipo_contrato(self):
        return "Tiempo completo"


# ==========================================================================
# SUBCLASE 2: EmpleadoPorHoras
# Implementa las mismas 3 "casillas", pero con lógica completamente distinta.
# ==========================================================================
class EmpleadoPorHoras(Empleado):
    def __init__(self, nombre, identificacion, fecha_ingreso, departamento,
                 tarifa_hora, horas_trabajadas):
        super().__init__(nombre, identificacion, fecha_ingreso, departamento)
        self.tarifa_hora = tarifa_hora
        self.horas_trabajadas = horas_trabajadas

    def calcular_salario(self):
        # Regla propia: se paga solo por hora trabajada.
        return self.tarifa_hora * self.horas_trabajadas

    def calcular_bonificacion(self):
        # Regla propia: sin bono si trabaja menos de 100 horas al mes.
        if self.horas_trabajadas >= 100:
            return self.calcular_salario() * 0.05
        return 0.0

    def tipo_contrato(self):
        return "Por horas"


# ==========================================================================
# USO DEL SISTEMA
# ==========================================================================
if __name__ == "__main__":
    # empleado_generico = Empleado("X", 1, date(2020,1,1), "TI")  # ❌ ERROR:
    # No se puede instanciar la clase abstracta directamente porque le
    # faltan las 3 "casillas" (calcular_salario, calcular_bonificacion,
    # tipo_contrato) sin llenar.

    fijo = EmpleadoTiempoCompleto(
        nombre="Ana Torres",
        identificacion=101,
        fecha_ingreso=date(2021, 3, 15),
        departamento="Sistemas",
        salario_mensual=3_000_000,
    )

    por_horas = EmpleadoPorHoras(
        nombre="Luis Pérez",
        identificacion=102,
        fecha_ingreso=date(2023, 6, 1),
        departamento="Soporte",
        tarifa_hora=25_000,
        horas_trabajadas=120,
    )

    # POLIMORFISMO: guardamos objetos de DISTINTAS subclases en la misma
    # lista, tratándolos a todos como "Empleado". Cada uno ejecuta SU
    # propia versión de calcular_salario() y tipo_contrato() sin que
    # el código de abajo necesite saber de qué subclase es cada uno.
    empleados = [fijo, por_horas]

    for emp in empleados:
        emp.mostrar_info()