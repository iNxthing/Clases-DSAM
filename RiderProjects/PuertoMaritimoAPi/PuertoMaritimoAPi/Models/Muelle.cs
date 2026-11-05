namespace PuertoMaritimoAPi.Models;

public class Muelle
{
    public int Id { get; set; }
    public string Codigo { get; set; }
    public int CapacidadMaxima { get; set; }
    public string ubicacion { get; set; }
    public List<Contenedor> Contenedores { get; set; } = new List<Contenedor>();
}