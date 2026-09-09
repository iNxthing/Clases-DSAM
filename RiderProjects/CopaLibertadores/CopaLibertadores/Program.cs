Queue<String> Fila = new  Queue<String>();


Fila.Enqueue("Daniel");
Fila.Enqueue("Jorley");
Fila.Enqueue("Luis");
Fila.Enqueue("Edgar");


int silla = 1;
while (Fila.Count > 0)
{
    String hincha = Fila.Dequeue();
    Console.Write($"Hincha: {hincha} - Silla Asignada = {silla}\n");
    silla++;
}
