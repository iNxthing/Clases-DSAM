using Microsoft.EntityFrameworkCore;
using Tienda.Models;
namespace Tienda.Data;

public class TiendaContext : DbContext
{
    public TiendaContext(DbContextOptions<TiendaContext> options) :base(options)
    {
        
    }
    public DbSet<Producto> Productos { get; set; }
}