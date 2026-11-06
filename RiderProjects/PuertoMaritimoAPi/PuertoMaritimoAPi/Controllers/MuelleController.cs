using Microsoft.AspNetCore.Mvc;
using PuertoMaritimoAPi.Models;
using PuertoMaritimoAPi.Services;

namespace PuertoMaritimoAPi.Controllers;
[ApiController]
[Route("api/[controller]")]
public class MuelleController : Controller
{
    // GET
    private readonly MuelleService _muelleService;

    public MuelleController(MuelleService muelleService)
    {
        _muelleService = muelleService;
    }

    [HttpGet]
    public async Task<IActionResult> obtenerTodos()
    {
        var muelles = await _muelleService.obtenerTodos();

        return Ok(muelles);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> obtenerPorID(int id)
    {
        var muelle = await _muelleService.obtenerPorID(id);

        if (muelle == null)
        {
            return NotFound("Muelle no encontrado");
        }

        return Ok(muelle);
    }
    [HttpPost]
    public async Task<IActionResult> crear(Muelle muelle)
    {
        var nuevo = await _muelleService.crear(muelle);
        return Ok(nuevo);
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> actualizar(int id , Muelle muelle)
    {
        var actualizado = await _muelleService.actualizar(id, muelle);

        if (!actualizado)
        {
            return NotFound("Buque no encontrado");
        }

        return Ok();
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> eliminar(int id)
    {
        var eliminado = await _muelleService.eliminar(id);

        if (!eliminado)
        {
            return NotFound("Buque no encontrado");
        }

        return Ok();
    }
    
}