using Microsoft.EntityFrameworkCore;
using PuertoMaritimoAPi.Data;
using PuertoMaritimoAPi.Services;
using Scalar.AspNetCore;

namespace PuertoMaritimoAPi;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services to the container.

        builder.Services.AddControllers();
        // Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
        builder.Services.AddOpenApi();
        var connectionString = builder.Configuration.GetConnectionString("ConexionMySQL");
        builder.Services.AddDbContext<PuertoContext>(option => option.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));
        builder.Services.AddScoped<BuqueService>();
        builder.Services.AddScoped<ContenedorService>();
        builder.Services.AddScoped<MuelleService>();
        var app = builder.Build();

        // Configure the HTTP request pipeline.
        if (app.Environment.IsDevelopment())
        {
            app.MapOpenApi();
            app.MapScalarApiReference();
        }

        app.UseHttpsRedirection();

        app.UseAuthorization();


        app.MapControllers();

        app.Run();
    }
}