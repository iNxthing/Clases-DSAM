using Microsoft.EntityFrameworkCore;
using PuertoMaritimoAPi.Data;
using PuertoMaritimoAPi.Models;

namespace PuertoMaritimoAPi.Services;

public class ContenedorService
{
    private readonly PuertoContext _context;

    public ContenedorService(PuertoContext context)
    {
        _context = context;
    }
    //Consultar todos
    public async Task<List<Contenedor>> obtenerTodos()
    {
        return await _context.Contenedores.ToListAsync();
    }
    //Consultar por id

    public async Task<Contenedor?> obtenerPorID(int id)
    {
        return await _context.Contenedores.FirstOrDefaultAsync(c => c.id == id);
    }
    
    //Crear 
    public async Task<Contenedor> crear(Contenedor contenedor)
    {
        _context.Contenedores.Add(contenedor);
        await _context.SaveChangesAsync();
        return contenedor;
    }
    
    //Actualizar
    public async Task<bool> actualizar(int id, Contenedor datos)
    {
        var contenedor = await obtenerPorID(id);

        if (contenedor == null)
        {
            return false;
        }

        contenedor.Codigo = datos.Codigo;
        // contenedor.Buque = datos.Buque;
        contenedor.BuqueID = datos.BuqueID;
        // contenedor.Muelle = datos.Muelle;
        contenedor.MuelleID = datos.MuelleID;
        contenedor.peso = datos.peso;
        contenedor.Tipo = datos.Tipo;
        await _context.SaveChangesAsync();
        
        return true;
    }
    
    //Eliminar
    public async Task<bool> eliminar(int id)
    {
        var contenedor = await obtenerPorID(id);

        if (contenedor == null)
        {
            return false;
        }

        _context.Contenedores.Remove(contenedor);
        await _context.SaveChangesAsync();
        return true;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}