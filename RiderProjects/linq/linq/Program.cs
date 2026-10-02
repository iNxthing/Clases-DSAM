using System.Globalization;

namespace linq;

class  Estudiante
{
    public String  nombre { get; set; }
    public int edad { get; set; }
    public int nota { get; set; }

    public Estudiante(string nombre, int edad, int nota)
    {
        this.nombre = nombre;
        this.edad = edad;
        this.nota = nota;
    }
    
    
}



class Program
{
    static void Main(string[] args)
    {
        List<Estudiante> estudiantes = new List<Estudiante>();
        
        estudiantes.Add(new Estudiante("darwin",17,5));
        estudiantes.Add(new Estudiante("daniel",32,5));
        estudiantes.Add(new Estudiante("jorley",18,1));
        //
        //
        // var resultado = estudiantes.Where(e => e.nota >= 3.0).OrderByDescending(e => e.nota).Select(e => e.nombre);
        // foreach (var i in resultado)
        // {
        //     Console.Write(i + " ");
        // }
        //
        List<double> notas = new List<double>{4.5,3.2,4.8,2.9,5.0};

        Console.WriteLine(notas.Count);
        Console.WriteLine(notas.Sum());
        Console.WriteLine(notas.Average());
        Console.WriteLine(notas.Min());
        Console.WriteLine(notas.Max());


        double promedioAprobados = estudiantes.Where(e => e.nota >= 3).Average(e => e.nota);
        var resultado = estudiantes.Where(e => e.nota >= 3.0).ToList();

        foreach (var est in resultado)
        {
            Console.WriteLine($"{est.nombre}");
        }
        
        
    }
}