List<string> estudiantes= new List<string>();

  
estudiantes.Add("Daniel");
estudiantes.Add("Darwin");
estudiantes.Add("Jorley");
estudiantes.Add("Edgar");
estudiantes.Add("Luis");


Console.WriteLine("Mostramos la lista");

foreach (string i in estudiantes)

{
    Console.WriteLine(i);
}

Console.WriteLine("eliminamos un estudiante y agregamos otro ");
estudiantes.Add("Cesar");

estudiantes.Remove("Luis");

Console.WriteLine("Volvemos a mostrar la lista actualizada");
Console.WriteLine("---------------------------");

foreach (string j in estudiantes)
  
{
      
    Console.WriteLine(j); 
}

Console.WriteLine("Buscamos un estudiante");

if (estudiantes.Contains("Cesar"))
{
    Console.WriteLine("Cesar esta en la lista");
}
else
{
    Console.WriteLine("Cesar no esta en la lista");
}