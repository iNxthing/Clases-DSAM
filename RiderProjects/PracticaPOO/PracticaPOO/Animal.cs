namespace PracticaPOO;

public class Animal
{
    public String Nombre { get; set; }
    public String Sonido { get; set; }

    public Animal(String Nombre,String Sonido)
    {
        this.Nombre = Nombre;
        this.Sonido = Sonido;

    }

    public void hacerSonido()
    {
        Console.WriteLine($"{Sonido}");
    }
    

}