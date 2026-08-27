**Listas**

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


​         

     }

}

**FIFO**

Queue<String> Fila = new  Queue<String>();

Fila.Enqueue("Darwin");

Fila.Enqueue("Daniel");
Fila.Enqueue("Jorley");
Fila.Enqueue("Luis");
Fila.Enqueue("Edgar");

int silla = 1;

Console.WriteLine("Entran los hinchas y se les asigna un asiento/silla");

while (Fila.Count > 0)
{
    String hincha = Fila.Dequeue();
    Console.WriteLine($"Hincha: {hincha} - Silla Asignada = {silla}\n");
    silla++;
}



**LIFO**

Stack<String> Fila = new Stack<String>();

Fila.Push("Darwin");
Fila.Push("Daniel");
Fila.Push("Jorley");
Fila.Push("Edgar");
Fila.Push("Luis");

Console.WriteLine("Entran los hinchas");

foreach (String i in Fila)
{
    Console.WriteLine(i);
}

Console.WriteLine("Salen los hinchas luego de perder 9-1");

int silla = Fila.Count;
while (Fila.Count > 0)
{
    String hincha = Fila.Pop();
    Console.WriteLine($"{hincha} Ocupaba la silla {silla}\n");
    silla--;
}

**Ejercicio 4**

string palabraSecreta = "PROGRAMAR";
int maxIntentos = 6;
int fallos = 0;
bool gano = false;

List<char> letrasUsadas = new List<char>();

while (fallos < maxIntentos && !gano)
{
    Console.WriteLine();
    Console.WriteLine("Palabra: ");
    foreach (char c in palabraSecreta)
    {
        if (letrasUsadas.Contains(c))
            Console.WriteLine(c + " ");
        else
            Console.WriteLine("_ ");
    }

    Console.WriteLine($"\nFallos: {fallos} de {maxIntentos}");
    Console.WriteLine("Letras usadas: " + string.Join(" ", letrasUsadas));
    
    Console.WriteLine("\nEscribe una letra: ");
    string entrada = Console.ReadLine()?.Trim().ToUpper() ?? "";
    
    if (entrada.Length != 1 || !char.IsLetter(entrada[0]))
    {
        Console.WriteLine("Debes escribir UNA sola letra.");
        continue;
    }
    
    char letra = entrada[0];
    
    if (letrasUsadas.Contains(letra))
    {
        Console.WriteLine($"La letra '{letra}' YA fue usada. Prueba con otra.");
        continue;
    }
    
    letrasUsadas.Add(letra);
    
    if (palabraSecreta.Contains(letra))
    {
        Console.WriteLine($"Bien, la letra '{letra}' está en la palabra.");
    
        gano = true;
        foreach (char c in palabraSecreta)
        {
            if (!letrasUsadas.Contains(c))
                gano = false;
        }
    }
    else
    {
        fallos++;
        Console.WriteLine($"La letra '{letra}' NO está. Te quedan {maxIntentos - fallos} intentos.");
    }
}

Console.WriteLine();

if (gano)
    Console.WriteLine($"¡GANASTE! La palabra era: {palabraSecreta}");
else
    Console.WriteLine($"PERDISTE. La palabra secreta era: {palabraSecreta}");

