using WAPIEstatus.Models.Context;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

//CONNECTION --------------------------------------------------------------------------------

builder.Services.AddDbContext<DemosContext>(x => x.UseSqlServer(builder.Configuration.GetConnectionString("Conexion")));

//-------------------------------------------------------------------------------------------
var MyAllowSpecificOrigins = "_MyAllowSpecificOrigins";
builder.Services.AddCors(opt => opt.AddPolicy(name: MyAllowSpecificOrigins, builder =>
{
    builder.WithOrigins("RUTA").AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
}));


builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseCors(MyAllowSpecificOrigins);

app.UseAuthorization();

app.MapControllers();

app.Run();
