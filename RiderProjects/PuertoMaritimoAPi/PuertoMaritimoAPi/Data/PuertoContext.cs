using Microsoft.EntityFrameworkCore;
using PuertoMaritimoAPi.Models;

namespace PuertoMaritimoAPi.Data;

public class PuertoContext : DbContext
{
    public PuertoContext(DbContextOptions<PuertoContext> options) : base(options)
    {
        
    }
    
    public DbSet<Buque> Buques { get; set; }
    public DbSet<Muelle> Muelles { get; set; }
    public DbSet<Contenedor> Contenedores { get; set; }
}