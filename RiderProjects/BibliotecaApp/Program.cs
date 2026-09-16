// Punto de entrada del programa (top-level statements, sin necesidad de
// escribir "class Program { static void Main() { ... } }").

var biblioteca = new Biblioteca();

// Creamos objetos de las clases CONCRETAS (LibroFisico, LibroDigital, Revista).
// Nunca "new MaterialBiblioteca(...)" porque es abstracta: no se puede.
biblioteca.AgregarMaterial(new LibroFisico("Cien Años de Soledad", "Gabriel García Márquez", 1967, "Novela", 471));
biblioteca.AgregarMaterial(new LibroFisico("El Principito", "Antoine de Saint-Exupéry", 1943, "Novela", 96));
biblioteca.AgregarMaterial(new LibroDigital("Clean Code", "Robert C. Martin", 2008, "Tecnología", 12.4));
biblioteca.AgregarMaterial(new Revista("National Geographic", "Varios Autores", 2024, "Ciencia", 305));
biblioteca.AgregarMaterial(new LibroFisico("1984", "George Orwell", 1949, "Novela", 328));

// Mostramos el catálogo completo: aquí se ve el polimorfismo en acción,
// cada material se describe y calcula sus días de préstamo a su manera.
biblioteca.MostrarCatalogo();

// Usamos el Dictionary para mostrar estadísticas agrupadas por categoría.
Console.WriteLine("=== MATERIALES POR CATEGORÍA ===");
foreach (var par in biblioteca.ContarPorCategoria())
{
    Console.WriteLine($"{par.Key}: {par.Value} material(es)");
}

// Probamos la fila de espera (Queue) con un par de solicitudes.
Console.WriteLine("\n=== FILA DE ESPERA ===");
biblioteca.SolicitarEnEspera("Ana");
biblioteca.SolicitarEnEspera("Carlos");
biblioteca.AtenderSiguienteSolicitud(); // debe atender a Ana primero (llegó primero)
biblioteca.AtenderSiguienteSolicitud(); // ahora atiende a Carlos
biblioteca.AtenderSiguienteSolicitud(); // ya no hay nadie en espera
