using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace Flixtube.Data;

public class ApplicationDbContextFactory : IDesignTimeDbContextFactory<ApplicationDbContext>
{
    public ApplicationDbContextFactory() { }

    public ApplicationDbContext CreateDbContext(string[] args)
    {
        var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();
        var provider = builder.GetSection("Flixtube")["FLIXTUBE_DATABASE_PROVIDER"];
        
        string connectionString;
        if(provider == "sqlite")
            connectionString = builder.GetSection("Flixtube")["FLIXTUBE_CONNECTION_STRING_SQLITE"]!;
        else
           connectionString = builder.GetSection("Flixtube")["FLIXTUBE_CONNECTION_STRING_SQLSERVER"]!;

        if (string.IsNullOrEmpty(connectionString))
            throw new InvalidOperationException("The connection string was not set.");

        DbContextOptions<ApplicationDbContext> options;
        if(provider == "sqlite")
            options = new DbContextOptionsBuilder<ApplicationDbContext>().UseSqlite(connectionString).Options;
        else
            options = new DbContextOptionsBuilder<ApplicationDbContext>().UseSqlServer(connectionString).Options;

        return new ApplicationDbContext(options);
    }
}