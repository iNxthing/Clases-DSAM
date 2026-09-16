namespace BibliotecaApp;

// CLASE BASE ABSTRACTA — igual que "Vehiculo" en el ejercicio del concesionario.
// Ningún material de biblioteca existe "genérico": siempre es un LibroFisico,
// un LibroDigital o una Revista. Por eso "abstract".
public abstract class MaterialBiblioteca
{
    public string Titulo { get; set; }
    public string Autor { get; set; }
    public int AnioPublicacion { get; set; }
    public string Categoria { get; set; }

    // Constructor "protected": solo las clases hijas pueden llamarlo con "base(...)".
    // Es la ventanilla única por la que TODO material entra al sistema.
    protected MaterialBiblioteca(string titulo, string autor, int anioPublicacion, string categoria)
    {
        Titulo = titulo;
        Autor = autor;
        AnioPublicacion = anioPublicacion;
        Categoria = categoria;
    }

    // ABSTRACTO: cada tipo de material tiene su propia regla de cuántos días
    // se presta. No existe un valor "por defecto" razonable para todos,
    // así que obligamos a cada hija a definir el suyo.
    public abstract int DiasPrestamo();

    // VIRTUAL: tiene una implementación por defecto que las hijas pueden
    // reemplazar (override) si necesitan mostrar un dato extra.
    public virtual string MostrarInfo()
    {
        return $"\"{Titulo}\" de {Autor} ({AnioPublicacion}) - Categoría: {Categoria}";
    }

    // Método normal: la regla (fecha límite = hoy + días de préstamo) es
    // igual para todos, pero DEPENDE del resultado de DiasPrestamo(),
    // que varía según el tipo real del objeto. Aquí ya actúa el polimorfismo,
    // aunque este método en sí no sea "override-able".
    public DateTime CalcularFechaLimite()
    {
        return DateTime.Today.AddDays(DiasPrestamo());
    }
}
