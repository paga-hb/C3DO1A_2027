using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;
using Todo.Api.Profiles;
using Todo.Data;
using Todo.Data.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

// Add DbContext, UnitOfWork, and AutoMapper to the Service container <-------- here we are adding our services
builder.Services.AddDbContext<ApplicationDbContext>(
    options => options.UseSqlite(builder.Configuration.GetConnectionString("Todo"))
);
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
builder.Services.AddAutoMapper(config => config.AddProfile<TodoItemProfile>()); 

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{    
    // Serve OpenAPI JSON at /openapi/v1.json
    app.MapOpenApi();

    // Serve Scalar UI at /scalar
    // Scalar UI automatically points to the built-in OpenAPI endpoint above (/openapi/v1.json)
    app.MapScalarApiReference();

    // Serve Swagger UI at /swagger
    // Swagger UI needs to be pointed to the built-in OpenAPI endpoint (/openapi/v1.json)
    app.UseSwaggerUI(options => options.SwaggerEndpoint("/openapi/v1.json", "API v1"));
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();