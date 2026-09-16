namespace BibliotecaApp;

public class Revista : MaterialBiblioteca
{
    public int NumeroEdicion { get; set; }

    public Revista(string titulo, string autor, int anioPublicacion, string categoria, int numeroEdicion)
        : base(titulo, autor, anioPublicacion, categoria)
    {
        NumeroEdicion = numeroEdicion;
    }

    // Las revistas se prestan solo 3 días: son material de consulta rápida,
    // se espera que el usuario la devuelva pronto para que otros la usen.
    public override int DiasPrestamo()
    {
        return 3;
    }

    public override string MostrarInfo()
    {
        return base.MostrarInfo() + $" | Edición #{NumeroEdicion}";
    }
}
