namespace Guerrero;




public class Guerrero
{
    public String Nombre { get; set; }
    public String Raza {get;set;}
    public int NivelPoder {get;set;}
    public int Transformacines{get;set;}
    public String Universo {get;set;}

    public Guerrero(string nombre, string raza, int nivelPoder, int transformacines, string universo)
    {
        Nombre = nombre;
        Raza = raza;
        NivelPoder = nivelPoder;
        Transformacines = transformacines;
        Universo = universo;
    }
    
    
    
}
class Program
{
    static void Main(string[] args)
    {
        List<Guerrero> guerreros = new List<Guerrero>();
        
        guerreros.Add(new Guerrero("Goku","Saiyajin",15000,100,"7"));
        guerreros.Add(new Guerrero("Vegueta","Saiyajin",8000,5,"7"));
        guerreros.Add(new Guerrero("Krillin","Saiyajin",2500,1,"7"));
        guerreros.Add(new Guerrero("Bulma","Humana",10,0,"7"));
        guerreros.Add(new Guerrero("Jiren","Alien",12000,1,"11"));
        guerreros.Add(new Guerrero("Gohan","Saiyajin",6000,4,"7"));
        guerreros.Add(new Guerrero("Bardock","Saiyajin",1500,1,"7"));
        guerreros.Add(new Guerrero("Majin Boo","Androide",4000,1,"7"));
        guerreros.Add(new Guerrero("Androide 18","Androide",6000,1,"7"));
        guerreros.Add(new Guerrero("Cell","Perfecto",6700,2,"7"));
        guerreros.Add(new Guerrero("Whis","Angel",20000,1,"7"));
        guerreros.Add(new Guerrero("Bills","God",30000,1,"7"));
        var mayor8000 = guerreros.Where(g => g.NivelPoder >= 8000).ToList();
        
        Console.WriteLine(" ");
        Console.WriteLine("Nivel de poder mayor a 8000");
        foreach (var g in mayor8000)
        {
            Console.WriteLine("==================================");
            Console.WriteLine($"{g.Nombre} Nivel de poder: {g.NivelPoder}");
            Console.WriteLine("==================================");
        }
        
        var razaSaiyajin = guerreros.Where(g => g.Raza == "Saiyajin").ToList();
        Console.WriteLine(" ");
        Console.WriteLine("Raza Saiyajin");
        foreach (var g in razaSaiyajin)
        {
            Console.WriteLine("==================================");
            Console.WriteLine($"Nombre: {g.Nombre} Raza: {g.Raza}");
            Console.WriteLine("==================================");
            
        }

        var dosTransformaciones = guerreros.Where(g => g.Transformacines >= 2).ToList();

        Console.WriteLine(" ");
        Console.WriteLine("Guerreros con mas de 2 transformaciones");
        foreach (var g in dosTransformaciones)
        {
            Console.WriteLine("==================================");
            Console.WriteLine($"Nombre: {g.Nombre} Numero Transformaciones: {g.Transformacines}");
            Console.WriteLine("==================================");
            
        }

        var ordenarPoder = guerreros.OrderByDescending(g => g.NivelPoder).ToList();
        Console.WriteLine(" ");
        Console.WriteLine("Nivel de poder de mayor a menor");
        foreach (var g in ordenarPoder)
        {
            Console.WriteLine("==================================");
            Console.WriteLine($"Nombre: {g.Nombre} Nivel de poder: {g.NivelPoder}");
            Console.WriteLine("==================================");
            
        }

        var ordenarNombre = guerreros.OrderBy(g => g.Nombre ).ToList();
        Console.WriteLine(" ");
        Console.WriteLine("Nombres ordenados ");

        foreach (var g in ordenarNombre)
        {
            Console.WriteLine("==================================");
            Console.WriteLine($"Nombre : {g.Nombre}");
            Console.WriteLine("==================================");
            
        }

        var NombreyRaza = guerreros.Select(g => new{g.Nombre,g.Raza}).ToList();
        Console.WriteLine(" ");
        Console.WriteLine("Nombres y Raza ");
        foreach (var g in NombreyRaza)
        {
            Console.WriteLine("==================================");
            Console.WriteLine($"Nombre: {g.Nombre} Raza: {g.Raza}");
            Console.WriteLine("==================================");
            
        }

        var TodosLosGuerreros = guerreros.Select(g => new{g.Nombre,g.NivelPoder,g.Universo}).ToList();
        Console.WriteLine(" ");
        Console.WriteLine("Todos los guerreros ");
        foreach (var g in TodosLosGuerreros)
        {
            Console.WriteLine("==================================");
            Console.WriteLine($"Nombre: {g.Nombre} Nivel de poder: {g.NivelPoder} Unverso {g.Universo}");
            Console.WriteLine($"Nivel de batalla {g.NivelPoder}");
            Console.WriteLine("==================================");
            
        }
    }

    
}