using Microsoft.EntityFrameworkCore;
using Tienda.Data;
using Tienda.Models;

namespace Tienda.Services;

public class ProductoService
{
    private readonly TiendaContext _context;


    public ProductoService(TiendaContext context)
    {
        _context = context;
    }

    public async Task<List<Producto>> obtenerTodos()
    {
        return await _context.Productos.ToListAsync();
    }

    public async Task<Producto?> ObtenerporId(int id)
    {
        return await _context.Productos.FindAsync(id);
    }

    public async Task<Producto> CrearProducto(Producto producto)
    {
        _context.Productos.Add(producto);
        await _context.SaveChangesAsync();
        return producto;
    }

    public async Task<bool> actualizarProducto(int id , Producto producto)
    {
        var existe = await _context.Productos.FindAsync(id);

        if (existe == null)
        {
            return false;
        }

        existe.nombre = producto.nombre;
        existe.precio = producto.precio;
        existe.cantidad = producto.cantidad;

        await _context.SaveChangesAsync();
        return true;
    }
    public async Task<bool> Eliminar(int id )
    {
        var existe = await _context.Productos.FindAsync(id);

        if (existe == null)
        {
            return false;
        }

        _context.Productos.Remove(existe);
        await _context.SaveChangesAsync();
        return true;
    }
}