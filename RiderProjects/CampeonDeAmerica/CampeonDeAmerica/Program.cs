Stack<String> Fila = new Stack<String>();

Fila.Push("Darwin");
Fila.Push("Daniel");
Fila.Push("Jorley");
Fila.Push("Edgar");
Fila.Push("Luis");


Console.WriteLine("Entran los hinchas");
foreach (String hincha in Fila)
{
    Console.WriteLine(hincha);
}


Console.WriteLine("Salen los hinchas luego de perder 9-1 ");
int silla = Fila.Count;
while (Fila.Count > 0)
{
    String hincha = Fila.Pop();
    Console.Write($"{hincha} Ocupaba la silla {silla}\n");
    silla--;
}