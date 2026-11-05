using Microsoft.EntityFrameworkCore;
using PuertoMaritimoAPi.Data;
using PuertoMaritimoAPi.Models;

namespace PuertoMaritimoAPi.Services;

public class BuqueService
{
    private readonly PuertoContext _context;
    public BuqueService(PuertoContext context)
    {
        _context = context;
    }
    //Consultar todos

    public async Task<List<Buque>> obtenerTodos()
    {
        return await _context.Buques.ToListAsync();
    }
    //Consultar Por id
    
    public async Task<Buque?> obtenerPorID(int id)
    {
        return await _context.Buques.FirstOrDefaultAsync(b => b.Id == id);
    }
    //Crear 
    public async Task<Buque> crear(Buque buque)
    {
        _context.Buques.Add(buque);
        await _context.SaveChangesAsync();
        return buque;
    }
    //Actualizar
    public async Task<bool> actualizar(int id,Buque datos)
    {
        var buque = await obtenerPorID(id);

        if (buque == null)
        {
            return false;
        }

        buque.Nombre = datos.Nombre;
        buque.Bandera = datos.Bandera;
        buque.capacidadCOntenedores = datos.capacidadCOntenedores;
        buque.Estado = datos.Estado;
        await _context.SaveChangesAsync();
        return true;
    }
    
    //Eliminar
    public async Task<bool> eliminar(int id)
    {
        var buque = await obtenerPorID(id);

        if (buque == null)
        {
            return false;
        }

        _context.Buques.Remove(buque);
        
        await _context.SaveChangesAsync();
        return true;
    }
}