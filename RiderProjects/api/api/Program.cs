using System.Net.Http;
using System.Text.Json;
namespace api;

public class Pokemon
{
    public string name { get; set; }
    public int id { get; set; }
    public int height { get; set; }
    public int weight { get; set; }
}



class Program
{
    // public class Usuario
    // {
    //     public int id { get; set; }
    //     public string nombre { get; set; }
    //     public int edad { get; set; }
    //
    //     public Usuario( int id, string nombre, int edad)
    //     {
    //         this.id = id;
    //         this.nombre = nombre;
    //         this.edad = edad;
    //     }
    // }
    
    
    
    
    
    
    static async Task Main(string[] args)
    {
        // Usuario usuario = new Usuario(1, "Darwin", 17);
        // Console.Write(usuario.nombre);
        // string json = JsonSerializer.Serialize(usuario);
        //
        // Usuario usuario2 = JsonSerializer.Deserialize<Usuario>(json);
        HttpClient client = new HttpClient();
        string url = "https://pokeapi.co/api/v2/pokemon/vaporeon";
        string response = await client.GetStringAsync(url);

        Pokemon pokemon = JsonSerializer.Deserialize<Pokemon>(response);

        Console.WriteLine($"Nombre: {pokemon.name}");
        Console.WriteLine($"ID: {pokemon.id}");
        Console.WriteLine($"Altura: {pokemon.height}");
        Console.WriteLine($"Peso: {pokemon.weight}");
    }
}