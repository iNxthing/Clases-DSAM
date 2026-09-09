namespace ClasesAbstractas2;

class Program
{

    class Animal
    {
        public virtual void HacerSonido()
        {
            Console.WriteLine("HacerSonido");
        }
    }

    class Perro : Animal
    {
        public override void HacerSonido()
        {
            Console.WriteLine("El animal hace un sonido");
        }
    }
    
    
    
    static void Main(string[] args)
    {
        // List<Empleado> Empleados = new List<Empleado>();
        //
        // Gerente ge = new Gerente("Darwin", 670000, 1.67,"Gerente");
        // Desarrollador dev = new Desarrollador("Juan", 50000,1.3,"Desarrollador");
        // Diseñador dis = new Diseñador("Daniel", 1500, 1.5,"Diseñador");
        // Empleados.Add(dis);
        // Empleados.Add(dev);
        // Empleados.Add(ge);
        //
        // foreach (Empleado emp in Empleados)
        // {
        //     emp.MostrarInformacion();
        //     emp.CalcularSalario();
        // }
    }
    
    

    // public abstract class Empleado
    // {
    //     public String nombre { get; set; }
    //     public int salariobase { get; set; }
    //     
    //     public String rol { get; set; }
    //
    //     public Empleado(String nombre, int salariobase, String rol)
    //     {
    //         this.nombre = nombre;
    //         this.salariobase = salariobase;
    //         this.rol = rol;
    //     }
    //     
    //     public void MostrarInformacion()
    //     {
    //         Console.WriteLine($"Nombre: {nombre}, Salario: {salariobase} - rol {rol}");
    //     }
    //     
    //     public abstract void CalcularSalario();
    // }
    //
    // public class Desarrollador : Empleado
    //
    // {
    //     public double bonoTecnologico {get; set; }
    //     public Desarrollador(String nombre, int salariobase, double bonoTecnologico, string rol) : base(nombre, salariobase, rol)
    //     {
    //         this.salariobase = salariobase;
    //         this.nombre = nombre;
    //         this.bonoTecnologico = bonoTecnologico;
    //         this.rol = rol;
    //     }
    //     
    //     public override void CalcularSalario()
    //     {
    //         Console.WriteLine($"Salario Calculado: {salariobase * bonoTecnologico}");
    //     }
    //     
    // }
    //
    // public class Diseñador : Empleado
    //
    // {
    //     public double bonoDiseñador {get; set; }
    //     public Diseñador(String nombre, int salariobase, double bonoDiseñador , string rol) : base(nombre, salariobase, rol)
    //     {
    //         this.nombre = nombre;
    //         this.salariobase = salariobase;
    //         this.rol = rol;
    //         this.bonoDiseñador = bonoDiseñador;
    //     }
    //     
    //     public override void CalcularSalario()
    //     {
    //         Console.WriteLine($"Salario Calculado: {salariobase * bonoDiseñador}");
    //     }
    //     
    // }
    // public class Gerente : Empleado
    //
    // {
    //     public double bonoCreativo {get; set; }
    //     public Gerente(String nombre, int salariobase, double bonoCreativo, string rol) : base(nombre, salariobase,rol)
    //     {
    //         this.nombre = nombre;
    //         this.salariobase = salariobase;
    //         this.bonoCreativo = bonoCreativo;
    //         this.rol = rol;
    //     }
    //     
    //     public override void CalcularSalario()
    //     {
    //         Console.WriteLine($"Salario Calculado: {salariobase * bonoCreativo}");
    //     }
    //     
    // }
}
