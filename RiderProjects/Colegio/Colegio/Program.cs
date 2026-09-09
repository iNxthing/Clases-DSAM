List<String> estudiantes = new List<String>();


while (true)
{
    Console.Write("<---Seleccione una opcion---> ");
    Console.WriteLine("\n1. Ingresar un Estudiante");
    Console.WriteLine("2. Remover un Estudiante");
    Console.WriteLine("3. Buscar un Estudiante");
    Console.WriteLine("4. Mostrar Estudiantes");
    Console.WriteLine("5. Salir");
    
     int seleccion = int.Parse(Console.ReadLine());
     
     switch (seleccion)
     {
         case 1:
             Boolean enCurso = true;
             while (enCurso)
             {
                 Console.WriteLine("Nombre del Estudiante a ingresar: ");
                 String nombre = Console.ReadLine();
                 if (nombre == "Salir")
                 {
                     enCurso = false;
                 }
                 else{
                     estudiantes.Add(nombre);
                     Console.WriteLine("Estudiante Ingresado Con exito");
                 }
             }
             
             break;
         case 2:
             Console.WriteLine("Nombre del Estudiante a Remover: ");
             estudiantes.Remove(Console.ReadLine());
             Console.WriteLine("Estudiante Removido Con exito");
             break;
         case 3:
             Console.WriteLine("Nombre del Estudiante a Buscar: ");
             String Busqueda = Console.ReadLine();
             if (estudiantes.Contains(Busqueda))
             {
                 Console.WriteLine($"{Busqueda} se encuentra en la lista");
             }
             else
             {
                 Console.WriteLine($"{Busqueda} no existe en la lista");
             }
             break;
         case 4:
             Console.WriteLine("<---Estudiantes En Lista--->");
             foreach (String i in estudiantes)
             {
                 Console.WriteLine(i);
             }
             break;
         case 5:
             Console.WriteLine("Saliendo Del programa...");
             break;
         
         
     }
}

