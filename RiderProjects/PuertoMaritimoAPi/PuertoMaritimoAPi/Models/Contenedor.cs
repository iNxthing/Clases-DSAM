namespace PuertoMaritimoAPi.Models;

public class Contenedor
{
    public int id {get; set;}
    public string Codigo { get; set; }
    public string Tipo { get; set; }
    public double peso { get; set; }
    
    //Relacion con el buque
    public int BuqueID { get; set; }
    public Buque? Buque { get; set; }
    //Relacion con el muelle
    public int MuelleID { get; set; }
    public Muelle? Muelle { get; set; }
}