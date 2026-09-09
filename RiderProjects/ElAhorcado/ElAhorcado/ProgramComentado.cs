// ============================================================
//  EL AHORCADO - versión alternativa (comentada)
//  Este archivo está FUERA del proyecto, así que no se compila.
//  Sirve solo como referencia para enviar al compañero.
// ============================================================

string palabraOculta = "PROGRAMAR";              // palabra que hay que adivinar
int vidasRestantes = 6;                          // número máximo de errores permitidos
bool jugadorGano = false;                        // bandera de victoria

HashSet<char> letrasAcertadas = new HashSet<char>(); // letras correctas ya descubiertas
HashSet<char> letrasFalladas = new HashSet<char>();  // letras que no estaban en la palabra

Console.WriteLine("=== JUEGO DEL AHORCADO ===");

// El bucle sigue mientras queden vidas y no se haya ganado
while (vidasRestantes > 0 && !jugadorGano)
{
    Console.WriteLine();

    // Dibujamos la palabra letra por letra con un bucle for indexado:
    // si la letra fue acertada se muestra, si no, un guion bajo
    for (int i = 0; i < palabraOculta.Length; i++)
    {
        char c = palabraOculta[i];
        Console.Write(letrasAcertadas.Contains(c) ? c + " " : "_ ");
    }

    Console.WriteLine($"\n\nVidas restantes: {vidasRestantes}");

    // Solo mostramos los fallos si el jugador ya ha fallado alguna letra
    if (letrasFalladas.Count > 0)
        Console.WriteLine("Fallos hasta ahora: " + string.Join(", ", letrasFalladas));

    // Pedimos una letra por teclado y la normalizamos (sin espacios, en mayúscula)
    Console.Write("\nIntroduce una letra: ");
    string teclado = Console.ReadLine()?.Trim().ToUpper() ?? "";

    // Validación: debe ser exactamente UNA letra
    if (teclado.Length != 1 || !char.IsLetter(teclado[0]))
    {
        Console.WriteLine("Entrada invalida: escribe UNA sola letra.");
        continue;   // vuelve al inicio del bucle sin gastar vidas
    }

    char intento = teclado[0];

    // Comprobamos si esa letra ya se probó antes (en cualquiera de los dos conjuntos)
    if (letrasAcertadas.Contains(intento) || letrasFalladas.Contains(intento))
    {
        Console.WriteLine($"La letra '{intento}' ya la habias probado antes.");
        continue;
    }

    if (palabraOculta.Contains(intento))
    {
        // Acierto: guardamos la letra y avisamos al jugador
        letrasAcertadas.Add(intento);
        Console.WriteLine($"Correcto! '{intento}' aparece en la palabra.");

        // Comprobamos si con esta letra ya están TODAS las de la palabra
        bool completa = true;
        foreach (char c in palabraOculta)
        {
            if (!letrasAcertadas.Contains(c))
                completa = false;
        }
        jugadorGano = completa;
    }
    else
    {
        // Fallo: registramos la letra y restamos una vida
        letrasFalladas.Add(intento);
        vidasRestantes--;

        // Mensaje distinto según le queden o no vidas al jugador
        Console.WriteLine(vidasRestantes > 0
            ? $"'{intento}' no esta. Te quedan {vidasRestantes} vidas."
            : "Ese fue tu ultimo error...");
    }
}

Console.WriteLine();

// Mensaje final según el resultado de la partida
if (jugadorGano)
    Console.WriteLine($"ENHORABUENA, GANASTE! La palabra era {palabraOculta}.");
else
    Console.WriteLine($"Lo siento, perdiste. La palabra oculta era {palabraOculta}.");
