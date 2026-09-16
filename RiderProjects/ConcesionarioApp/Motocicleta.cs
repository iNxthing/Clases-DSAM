namespace ConcesionarioApp;

public class Motocicleta : Vehiculo
{
    public int Cilindrada { get; set; }

    public Motocicleta(string marca, string modelo, int anio, decimal precioBase, int cilindrada)
        : base(marca, modelo, anio, precioBase)
    {
        Cilindrada = cilindrada;
    }

    // Las motos pagan menos impuesto que los autos: 8% del precio base.
    // Compara este número con el de Auto.cs (0.15m) y Camion.cs (0.20m):
    // ahí está la prueba de que cada clase decide su propia lógica.
    public override decimal CalcularImpuesto()
    {
        return PrecioBase * 0.08m;
    }

    public override string MostrarInfo()
    {
        return base.MostrarInfo() + $" | Cilindrada: {Cilindrada}cc";
    }
}
