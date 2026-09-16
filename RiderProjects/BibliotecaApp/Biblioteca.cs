namespace BibliotecaApp;

// El "gerente" del sistema: administra la COLECCIÓN completa de materiales
// y genera reportes sobre ella. No representa un material en particular.
public class Biblioteca
{
    // *** LA COLECCIÓN PRINCIPAL ***
    // Tipo "List<MaterialBiblioteca>", NO "List<LibroFisico>".
    // Esto permite guardar LibroFisico, LibroDigital y Revista TODOS juntos
    // en la misma lista, porque los tres "SON UN" MaterialBiblioteca.
    private readonly List<MaterialBiblioteca> _catalogo = new();

    // Segunda colección: una fila de espera de solicitudes de préstamo.
    // Usamos Queue<T> porque el orden de llegada importa: el primero
    // que pide un material en espera, es el primero que lo recibe
    // cuando se libera (FIFO: First In, First Out).
    private readonly Queue<string> _solicitudesEnEspera = new();

    public void AgregarMaterial(MaterialBiblioteca material)
    {
        _catalogo.Add(material);
    }

    public void SolicitarEnEspera(string nombrePersona)
    {
        // Enqueue: se une al FINAL de la fila.
        _solicitudesEnEspera.Enqueue(nombrePersona);
    }

    public void AtenderSiguienteSolicitud()
    {
        if (_solicitudesEnEspera.Count == 0)
        {
            Console.WriteLine("No hay solicitudes en espera.");
            return;
        }

        // Dequeue: saca y devuelve a la persona que lleva MÁS TIEMPO
        // esperando (la primera que hizo Enqueue), nunca la última.
        string siguiente = _solicitudesEnEspera.Dequeue();
        Console.WriteLine($"Atendiendo a: {siguiente}");
    }

    public void MostrarCatalogo()
    {
        Console.WriteLine("=== CATÁLOGO DE LA BIBLIOTECA ===\n");

        // *** AQUÍ OCURRE EL POLIMORFISMO ***
        // "m" está declarado como MaterialBiblioteca, pero en tiempo de
        // ejecución C# revisa el tipo REAL de cada objeto (¿LibroFisico?
        // ¿LibroDigital? ¿Revista?) y ejecuta el MostrarInfo() y
        // DiasPrestamo() correspondiente. Sin ningún "if (m is LibroFisico)".
        foreach (MaterialBiblioteca m in _catalogo)
        {
            Console.WriteLine(m.MostrarInfo());
            Console.WriteLine($"  Préstamo: {m.DiasPrestamo()} días | Fecha límite: {m.CalcularFechaLimite():d}\n");
        }
    }

    // Tercera colección: un Dictionary para agrupar y contar por categoría.
    // A diferencia de la List (orden de llegada), aquí buscamos y
    // actualizamos por una CLAVE (el nombre de la categoría).
    public Dictionary<string, int> ContarPorCategoria()
    {
        var conteo = new Dictionary<string, int>();

        foreach (MaterialBiblioteca m in _catalogo)
        {
            // Guardamos la categoría en su propia variable, para que
            // quede claro que es un string, no un número.
            string categoria = m.Categoria;

            if (conteo.ContainsKey(categoria))
            {
                // conteo[categoria] BUSCA la fila con esa etiqueta y
                // devuelve el INT que está guardado ahí — no el string.
                int valorActual = conteo[categoria];
                conteo[categoria] = valorActual + 1;
            }
            else
            {
                // Add() recibe clave y valor como dos parámetros separados,
                // igual que cualquier otro método con parámetros.
                conteo.Add(categoria, 1);
            }
        }

        return conteo;
    }
}
