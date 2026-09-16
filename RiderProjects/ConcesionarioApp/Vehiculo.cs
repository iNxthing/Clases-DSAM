namespace ConcesionarioApp;

// CLASE BASE ABSTRACTA
// "abstract" significa dos cosas importantes:
//   1) Nadie puede escribir "new Vehiculo(...)" directamente, porque un
//      "vehículo genérico" no existe en la realidad de este programa:
//      siempre es un Auto, una Motocicleta o un Camion.
//   2) Puede contener métodos SIN implementación (abstract) que obligan
//      a cada clase hija a rellenarlos a su manera.
public abstract class Vehiculo
{
    public string Marca { get; set; }
    public string Modelo { get; set; }
    public int Anio { get; set; }
    public decimal PrecioBase { get; set; }

    // El constructor es "protected": solo las clases hijas pueden llamarlo
    // (con "base(...)"), nunca código externo. Es la "ventanilla" por la
    // que TODO vehículo, sin excepción, debe pasar para nacer con sus
    // datos básicos completos.
    protected Vehiculo(string marca, string modelo, int anio, decimal precioBase)
    {
        Marca = marca;
        Modelo = modelo;
        Anio = anio;
        PrecioBase = precioBase;
    }

    // MÉTODO ABSTRACTO: no tiene cuerpo ({ }), solo la firma.
    // Cada clase hija está OBLIGADA a escribir su propia versión con "override".
    // Esto modela que cada tipo de vehículo calcula impuestos distinto,
    // y no existe un valor "por defecto" razonable que sirva para todos.
    public abstract decimal CalcularImpuesto();

    // MÉTODO VIRTUAL: SÍ tiene una implementación por defecto,
    // pero cualquier hija puede reemplazarla con "override" si necesita
    // mostrar información adicional (como el número de puertas de un Auto).
    public virtual string MostrarInfo()
    {
        return $"{Anio} {Marca} {Modelo} - Precio base: {PrecioBase:C}";
    }

    // Método NORMAL (ni abstract ni virtual): la regla es igual para
    // todos los vehículos, así que no tiene sentido que las hijas la
    // puedan cambiar. Pero internamente SÍ depende de CalcularImpuesto(),
    // que varía según el tipo real del objeto. Aquí ya está actuando el
    // polimorfismo, aunque este método en sí no sea "override-able".
    public decimal PrecioFinal()
    {
        return PrecioBase + CalcularImpuesto();
    }
}
