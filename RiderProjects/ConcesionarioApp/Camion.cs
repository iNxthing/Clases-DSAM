namespace ConcesionarioApp;

public class Camion : Vehiculo
{
    public double CapacidadCargaToneladas { get; set; }

    public Camion(string marca, string modelo, int anio, decimal precioBase, double capacidadCargaToneladas)
        : base(marca, modelo, anio, precioBase)
    {
        CapacidadCargaToneladas = capacidadCargaToneladas;
    }

    // Los camiones tienen una fórmula más compleja: 20% de impuesto base
    // MÁS un extra fijo de $50 por cada tonelada de capacidad de carga.
    // Esto demuestra que "override" no solo cambia un número, puede
    // cambiar por completo la LÓGICA del cálculo.
    public override decimal CalcularImpuesto()
    {
        decimal impuestoBase = PrecioBase * 0.20m;
        decimal extraPorCarga = (decimal)CapacidadCargaToneladas * 50m;
        return impuestoBase + extraPorCarga;
    }

    public override string MostrarInfo()
    {
        return base.MostrarInfo() + $" | Carga máx: {CapacidadCargaToneladas} ton";
    }
}
