using Microsoft.EntityFrameworkCore;
using PuertoMaritimoAPi.Data;
using PuertoMaritimoAPi.Models;

namespace PuertoMaritimoAPi.Services;

public class MuelleService
{
    private readonly PuertoContext _context;

    public MuelleService(PuertoContext context)
    {
        _context = context;
    }
    
    //Consultar todos
    public async Task<List<Muelle>> obtenerTodos()
    {
        return await _context.Muelles.ToListAsync();
    }
    //Consultar por id
    public async Task<Muelle?> obtenerPorID(int id)
    {
        return await _context.Muelles.FirstOrDefaultAsync(m => m.Id == id);
    }
    
    //Crear
    public async Task<Muelle> crear(Muelle muelle)
    {
        _context.Muelles.Add(muelle);
        await _context.SaveChangesAsync();
        return muelle;
    }
    
    //Actualizar
    public async Task<bool> actualizar(int id, Muelle datos)
    {
        var muelle = await obtenerPorID(id);
        
        if (muelle == null)
        {
            return false;
        }

        muelle.Codigo = datos.Codigo;
        muelle.ubicacion = datos.ubicacion;
        muelle.Contenedores = datos.Contenedores;
        muelle.CapacidadMaxima = datos.CapacidadMaxima;
        return true;
    }
    
    
    //Eliminar
    public async Task<bool> eliminar(int id)
    {
        var muelle = await obtenerPorID(id);
        if (muelle == null)
        {
            return false;
        }

        _context.Muelles.Remove(muelle);
        await _context.SaveChangesAsync();
        return true;
    }
}