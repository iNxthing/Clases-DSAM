namespace PuertoMaritimoAPi.Models;

public class Buque
{
    public int Id { get; set; }
    public string Nombre { get; set; }
    public string Bandera { get; set; }
    public int capacidadCOntenedores { get; set; }
    public string Estado { get; set; } = "En espera";
    public List<Contenedor> Contenedores { get; set; } = new List<Contenedor>();
}