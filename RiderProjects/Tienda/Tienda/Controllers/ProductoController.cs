using Microsoft.AspNetCore.Mvc;
using Tienda.Models;
using Tienda.Services;

namespace Tienda.Controllers;

[ApiController]
[Route("api/[controller]")]

public class ProductoController : Controller
{
    // GET
    private readonly ProductoService _service;

    public ProductoController(ProductoService service)
    {
        _service = service;
    }

    [HttpGet]
    public async Task<ActionResult<List<Producto>>> ObtenerTodos()
    {
        var productos = await _service.obtenerTodos();
        return Ok(productos);
    }

    [HttpPost]
    public async Task<ActionResult<Producto>> Crear(Producto producto)
    {
        var creado = await _service.CrearProducto(producto);
        return Ok(creado);
    }
}