namespace ConcesionarioApp;

// ": Vehiculo" es la sintaxis de herencia en C#.
// Un Auto "ES UN" Vehiculo: tiene todo lo que tiene Vehiculo,
// más lo que le agreguemos aquí (NumeroPuertas).
public class Auto : Vehiculo
{
    public int NumeroPuertas { get; set; }

    // "base(marca, modelo, anio, precioBase)" manda esos 4 datos
    // al constructor del padre (Vehiculo), para que él los guarde.
    // Aquí solo nos encargamos de lo que es exclusivo de Auto.
    public Auto(string marca, string modelo, int anio, decimal precioBase, int numeroPuertas)
        : base(marca, modelo, anio, precioBase)
    {
        NumeroPuertas = numeroPuertas;
    }

    // "override" es obligatorio porque el padre lo declaró "abstract".
    // Sin este método, el código no compilaría.
    // Regla de negocio: los autos pagan 15% de impuesto sobre el precio base.
    public override decimal CalcularImpuesto()
    {
        return PrecioBase * 0.15m;
    }

    // Este "override" es opcional (el padre lo declaró "virtual"),
    // pero lo usamos para agregar el dato de puertas al texto.
    public override string MostrarInfo()
    {
        // "base.MostrarInfo()" ejecuta la versión ORIGINAL del padre
        // y le concatenamos algo extra, en vez de reescribir todo el texto.
        return base.MostrarInfo() + $" | Puertas: {NumeroPuertas}";
    }
}
