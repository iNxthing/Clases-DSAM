using Microsoft.AspNetCore.Mvc;
using PuertoMaritimoAPi.Models;
using PuertoMaritimoAPi.Services;

namespace PuertoMaritimoAPi.Controllers;
[ApiController]
[Route("api/[controller]")]
public class ContenedorController : Controller
{
    // GET
    private readonly ContenedorService _contenedorService;

    public ContenedorController(ContenedorService contenedorService)
    {
        _contenedorService = contenedorService;
    }

    [HttpGet]
    public async Task<IActionResult> obtenerTodos()
    {
        var contenedores = await _contenedorService.obtenerTodos();
        return Ok(contenedores);
    }

    [HttpGet]
    public async Task<IActionResult> obtenerPorID(int id)
    {
        var contenedor = await _contenedorService.obtenerPorID(id);
        if (contenedor == null)
        {
            return NotFound("Contenedor no encontrado");
        }

        return Ok(contenedor);
    }

    [HttpPost]
    public async Task<IActionResult> crear( Contenedor contenedor)
    {
        var nuevo = await _contenedorService.crear(contenedor);
        return Ok(nuevo);
    }

    [HttpPut]
    public async Task<IActionResult> actualizar(int id, Contenedor contenedor)
    {
        var actualizado = await _contenedorService.actualizar(id, contenedor);
        if (!actualizado)
        {
            return NotFound("Contenedor no encontrado");
        }

        return Ok();
    }
    
    [HttpDelete]
    public async Task<IActionResult> eliminar(int id)
    {
        var eliminado = await _contenedorService.eliminar(id);
        if (!eliminado)
        {
            return NotFound("Contenedor no encontrado");
        }

        return Ok();
    }
    
    
    
    
    
    
    
    
    
}