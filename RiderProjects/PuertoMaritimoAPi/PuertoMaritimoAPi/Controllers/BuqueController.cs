using Microsoft.AspNetCore.Mvc;
using PuertoMaritimoAPi.Models;
using PuertoMaritimoAPi.Services;

namespace PuertoMaritimoAPi.Controllers;
[ApiController]
[Route("api/[controller]")]
public class BuqueController : Controller
{
    // GET
    private readonly BuqueService _buqueService;

    public BuqueController(BuqueService buqueService)
    {
        _buqueService = buqueService;
    }

    [HttpGet]
    public async Task<IActionResult> obtenerTodos()
    {
        var buques = await _buqueService.obtenerTodos();
        return Ok(buques);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> obtenerPorID(int id)
    {
        var buque = await _buqueService.obtenerPorID(id);
        if (buque == null)
        {
            return NotFound("Buque no encontrado");
        }
        
        return Ok(buque);
    }

    [HttpPost]
    public async Task<IActionResult> crear(Buque buque)
    {
        var nuevo = await _buqueService.crear(buque);
        return Ok(nuevo);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> actualizar(int id , Buque buque)
    {
        var actualizado = await _buqueService.actualizar(id, buque);

        if (!actualizado)
        {
            return NotFound("Buque no encontrado");
        }

        return Ok();
    }
    [HttpDelete]
    public async Task<IActionResult> eliminar(int id)
    {
        var eliminado = await _buqueService.eliminar(id);

        if (!eliminado)
        {
            return NotFound("Buque no encontrado");
        }

        return Ok();
    }
}