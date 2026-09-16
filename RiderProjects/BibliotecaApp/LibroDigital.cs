namespace BibliotecaApp;

public class LibroDigital : MaterialBiblioteca
{
    public double TamanioMB { get; set; }

    public LibroDigital(string titulo, string autor, int anioPublicacion, string categoria, double tamanioMB)
        : base(titulo, autor, anioPublicacion, categoria)
    {
        TamanioMB = tamanioMB;
    }

    // Los libros digitales se prestan solo 7 días: la licencia "vence sola",
    // no hay que esperar a que alguien lo devuelva físicamente.
    // Compara este número con el de LibroFisico.cs (15) y Revista.cs (3):
    // cada clase decide su propia regla de negocio.
    public override int DiasPrestamo()
    {
        return 7;
    }

    public override string MostrarInfo()
    {
        return base.MostrarInfo() + $" | {TamanioMB} MB";
    }
}
