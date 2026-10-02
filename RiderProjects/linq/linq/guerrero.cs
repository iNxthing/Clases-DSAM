namespace linq;

public class guerrero
{
    public String Nombre { get; set; }
    public String Raza {get;set;}
    public int NivelPoder {get;set;}
    public int Transformacines{get;set;}
    public String Universo {get;set;}


    public guerrero(string nombre, string raza, int nivelPoder, int transformacines, string universo)
    {
        Nombre = nombre;
        Raza = raza;
        NivelPoder = nivelPoder;
        Transformacines = transformacines;
        Universo = universo;
    }
    
    
    
}