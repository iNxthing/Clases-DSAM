string palabraSecreta = "PROGRAMAR";
int maxIntentos = 6;
int fallos = 0;
bool gano = false;

List<char> letrasUsadas = new List<char>();

while (fallos < maxIntentos && !gano)
{
    Console.WriteLine();
    Console.Write("Palabra: ");
    foreach (char c in palabraSecreta)
    {
        if (letrasUsadas.Contains(c))
            Console.Write(c + " ");
        else
            Console.Write("_ ");
    }

    Console.WriteLine($"\nFallos: {fallos} de {maxIntentos}");
    Console.WriteLine("Letras usadas: " + string.Join(" ", letrasUsadas));

    Console.Write("\nEscribe una letra: ");
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
