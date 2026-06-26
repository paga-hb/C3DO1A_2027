using Flixtube.Data;
using Flixtube.Data.Repositories;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

// Make sure the necessary Flixtube settings are available in appsettings.json.

var flixtubeSection = builder.Configuration.GetSection("Flixtube");

if (string.IsNullOrEmpty(flixtubeSection["FLIXTUBE_GATEWAY_PORT"])) {
    throw new Exception("Please specify the port number for Flixtube.Gateway with the subkey FLIXTUBE_GATEWAY_PORT.");
}

if (string.IsNullOrEmpty(flixtubeSection["FLIXTUBE_STORAGE_FOLDER_NAME"])) {
    throw new Exception("Please specify the Filesystem folder name for Flixtube.Gateway with the subkey FLIXTUBE_STORAGE_FOLDER_NAME.");
}

if (string.IsNullOrEmpty(flixtubeSection["FLIXTUBE_DATABASE_PROVIDER"])) {
    throw new Exception("Please specify the database provider with the subkey FLIXTUBE_DATABASE_PROVIDER.");
}

if (string.IsNullOrEmpty(flixtubeSection["FLIXTUBE_CONNECTION_STRING_SQLSERVER"]) &&
    string.IsNullOrEmpty(flixtubeSection["FLIXTUBE_CONNECTION_STRING_SQLITE"])) {
    throw new Exception("Please specify the database conenction string with the subkey FLIXTUBE_CONNECTION_STRING_SQLSERVER or FLIXTUBE_CONNECTION_STRING_SQLITE.");
}

if (string.IsNullOrEmpty(flixtubeSection["FLIXTUBE_SEED_DATABASE"])) {
    throw new Exception("Please specify if the database should be seeded with the subkey FLIXTUBE_SEED_DATABASE.");
}

// Get necessary settings
// Note that we only need to get settings here if there are need before builder.Build()
// int GATEWAY_PORT = int.Parse(flixtubeSection["FLIXTUBE_GATEWAY_PORT"] ?? "80");
// string STORAGE_FOLDER_NAME = flixtubeSection["FLIXTUBE_STORAGE_FOLDER_NAME"] ?? string.Empty;
string DATABASE_PROVIDER = flixtubeSection["FLIXTUBE_DATABASE_PROVIDER"] ?? string.Empty;
string CONNECTION_STRING;
if(DATABASE_PROVIDER == "sqlite")
    CONNECTION_STRING = flixtubeSection["FLIXTUBE_CONNECTION_STRING_SQLITE"] ?? string.Empty;
else
    CONNECTION_STRING = flixtubeSection["FLIXTUBE_CONNECTION_STRING_SQLSERVER"] ?? string.Empty;
bool SEED_DATABASE = bool.Parse(flixtubeSection["FLIXTUBE_SEED_DATABASE"] ?? "false");

// Configure logging.
builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.AddDebug();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

if(DATABASE_PROVIDER == "sqlite")
    builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseSqlite(CONNECTION_STRING));
else
    builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(CONNECTION_STRING));
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    await SeedData.Initialize(services, SEED_DATABASE);
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapScalarApiReference(); // scalar/v1
    app.MapOpenApi();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

int GATEWAY_PORT = app.Configuration.GetValue<int>("Flixtube:FLIXTUBE_GATEWAY_PORT");
Console.WriteLine($"Gateway online and listening on port {GATEWAY_PORT}.");
app.Run($"http://0.0.0.0:{GATEWAY_PORT}");