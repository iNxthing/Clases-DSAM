namespace ConcesionarioApp;

// Esta clase es el "gerente" del negocio: no calcula impuestos ni
// almacena datos de un vehículo en particular, sino que administra
// la COLECCIÓN completa y genera reportes sobre ella.
public class Concesionario
{
    // *** LA COLECCIÓN CLAVE DE ESTE EJERCICIO ***
    // Fíjate que el tipo es "List<Vehiculo>", NO "List<Auto>".
    // Esto es lo que permite guardar Autos, Motocicletas y Camiones
    // TODOS juntos en la misma lista, porque los tres "SON UN" Vehiculo.
    // Si hubiéramos usado "List<Auto>", jamás podríamos meter una Motocicleta.
    private readonly List<Vehiculo> _inventario = new();

    public void AgregarVehiculo(Vehiculo vehiculo)
    {
        _inventario.Add(vehiculo);
    }

    public void MostrarInventario()
    {
        Console.WriteLine("=== INVENTARIO DEL CONCESIONARIO ===\n");

        // *** AQUÍ OCURRE EL POLIMORFISMO ***
        // La variable "v" está declarada como tipo Vehiculo, pero en
        // tiempo de ejecución, C# mira el tipo REAL de cada objeto
        // guardado en la lista (¿es un Auto? ¿una Motocicleta? ¿un Camion?)
        // y ejecuta la versión "override" correspondiente de MostrarInfo()
        // y CalcularImpuesto(). Un mismo foreach produce resultados
        // distintos según el objeto, sin usar ningún "if (v is Auto)".
        foreach (Vehiculo v in _inventario)
        {
            Console.WriteLine(v.MostrarInfo());
            Console.WriteLine($"  Impuesto: {v.CalcularImpuesto():C} | Precio final: {v.PrecioFinal():C}\n");
        }
    }

    // Segunda colección del ejercicio: un Dictionary.
    // A diferencia de la List (una fila de elementos en orden),
    // el Dictionary guarda pares CLAVE -> VALOR. Aquí la clave es
    // el nombre de la marca (string) y el valor es cuántos vehículos
    // hay de esa marca (int). Es ideal para "agrupar y contar".
    public Dictionary<string, int> ContarVehiculosPorMarca()
    {
        var conteo = new Dictionary<string, int>();

        foreach (Vehiculo v in _inventario)
        {
            if (conteo.ContainsKey(v.Marca))
                conteo[v.Marca]++;       // ya existía la marca: sumamos 1
            else
                conteo[v.Marca] = 1;     // primera vez que vemos esta marca
        }

        return conteo;
    }

    public decimal ValorTotalInventario()
    {
        decimal total = 0;
        foreach (Vehiculo v in _inventario)
        {
            // De nuevo polimorfismo: PrecioFinal() usa internamente
            // el CalcularImpuesto() propio de cada tipo de vehículo.
            total += v.PrecioFinal();
        }
        return total;
    }
}
