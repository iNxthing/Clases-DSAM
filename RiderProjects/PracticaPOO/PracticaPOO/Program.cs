namespace PracticaPOO;

class Program
{
    static void Main(string[] args)
    {
        Cerveza cerveza = new Cerveza("Aguila",10,5.2M,10); 
        cerveza.fermentacion();
    }
}