namespace PracticaPOO;

public class Cerveza
{
    public String Nombre { get; set; }
    public int Amargor { get; set; }
    public decimal Alcohol { get; set; }
    public int TiempoFermentacion { get; set; }

    public Cerveza(String Nombre,int Amargor,decimal Alcohol,int TiempoFermentacion)
    {
        this.Nombre = Nombre;
        this.Amargor = Amargor;
        this.Alcohol = Alcohol;
        this.TiempoFermentacion = TiempoFermentacion;
    }
    
    public void fermentacion()
    {
        Console.WriteLine($"{Nombre} se fermento en " + $"{TiempoFermentacion}");
    }
    
}