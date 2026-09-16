// Punto de entrada del programa (estilo "top-level statements" de C# moderno,
// sin necesidad de escribir "class Program { static void Main() { ... } }").

using ConcesionarioApp;

var concesionario = new Concesionario();

// Creamos objetos de las clases CONCRETAS (Auto, Motocicleta, Camion).
// Nunca escribimos "new Vehiculo(...)" porque es abstracta: no se puede.
concesionario.AgregarVehiculo(new Auto("Toyota", "Corolla", 2023, 22000m, 4));
concesionario.AgregarVehiculo(new Auto("Mazda", "3", 2022, 21000m, 4));
concesionario.AgregarVehiculo(new Motocicleta("Yamaha", "MT-07", 2024, 8500m, 700));
concesionario.AgregarVehiculo(new Camion("Volvo", "FH16", 2021, 95000m, 12.5));
concesionario.AgregarVehiculo(new Auto("Toyota", "Hilux", 2023, 35000m, 4));

// Mostramos el inventario completo: aquí se ve el polimorfismo en acción,
// cada vehículo se describe y calcula su impuesto a su propia manera.
concesionario.MostrarInventario();

// Usamos el Dictionary para mostrar estadísticas agrupadas por marca.
Console.WriteLine("=== VEHÍCULOS POR MARCA ===");
foreach (var par in concesionario.ContarVehiculosPorMarca())
{
    Console.WriteLine($"{par.Key}: {par.Value} vehículo(s)");
}

Console.WriteLine($"\nValor total del inventario: {concesionario.ValorTotalInventario():C}");
