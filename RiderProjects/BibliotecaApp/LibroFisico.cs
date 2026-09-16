namespace BibliotecaApp;

// ": MaterialBiblioteca" es la herencia. Un LibroFisico "ES UN" MaterialBiblioteca,
// con todo lo que ya trae la clase base, más lo suyo (NumeroPaginas).
public class LibroFisico : MaterialBiblioteca
{
    public int NumeroPaginas { get; set; }

    // "base(titulo, autor, anioPublicacion, categoria)" manda esos 4 datos
    // al constructor del padre. Aquí solo nos encargamos de NumeroPaginas,
    // que es exclusivo de LibroFisico.
    public LibroFisico(string titulo, string autor, int anioPublicacion, string categoria, int numeroPaginas)
        : base(titulo, autor, anioPublicacion, categoria)
    {
        NumeroPaginas = numeroPaginas;
    }

    // "override" obligatorio porque el padre lo declaró "abstract".
    // Regla de negocio: los libros físicos se prestan 15 días.
    public override int DiasPrestamo()
    {
        return 15;
    }

    // "override" opcional (el padre lo declaró "virtual"), lo usamos
    // para agregar el número de páginas al texto.
    public override string MostrarInfo()
    {
        // "base.MostrarInfo()" reutiliza el texto del padre y le
        // concatenamos algo extra, en vez de reescribir todo.
        return base.MostrarInfo() + $" | {NumeroPaginas} páginas";
    }
}
