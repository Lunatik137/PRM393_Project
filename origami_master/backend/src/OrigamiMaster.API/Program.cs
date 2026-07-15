using OrigamiMaster.API.Extensions;
using OrigamiMaster.Application;
using OrigamiMaster.Infrastructure;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add layers
builder.Services.AddApplication();
builder.Services.AddInfrastructure(builder.Configuration);

// Add API services
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHttpContextAccessor();

// Add Auth
builder.Services.AddJwtAuthentication(builder.Configuration);
builder.Services.AddAppAuthorization();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// app.UseHttpsRedirection(); // Disable HTTPS redirection to allow local HTTP testing from mobile devices

app.UseStaticFiles();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider
        .GetRequiredService<OrigamiMaster.Infrastructure.Persistence.ApplicationDbContext>();

    // Apply pending migrations automatically
    await context.Database.MigrateAsync();

    // Check if re-seed is needed
    if (await context.OrigamiModels.AnyAsync())
    {
        bool needReseed = false;

        // Check 1: Detect duplicate StepNumbers (old data with wrong step numbering)
        var duplicatesExist = await context.OrigamiSteps
            .GroupBy(s => s.OrigamiModelId)
            .AnyAsync(g => g.Count() != g.Max(s => s.StepNumber));

        if (duplicatesExist)
        {
            Console.WriteLine("[Seeder] Detected duplicate step numbers in existing data – forcing re-seed.");
            needReseed = true;
        }

        // Check 2: Detect external origami.me URLs still in DB (images not yet migrated to local storage)
        var hasExternalUrls = await context.OrigamiModels
            .AnyAsync(m => m.ThumbnailUrl != null && m.ThumbnailUrl.Contains("origami.me"));

        if (hasExternalUrls)
        {
            Console.WriteLine("[Seeder] Detected external origami.me image URLs – forcing re-seed to use local images.");
            needReseed = true;
        }

        if (needReseed)
        {
            // Clear dependent tables first to avoid FK conflicts
            await context.ShareLinks.ExecuteDeleteAsync();
            await context.Comments.ExecuteDeleteAsync();
            await context.Likes.ExecuteDeleteAsync();
            await context.FeedPosts.ExecuteDeleteAsync();
            await context.Creations.ExecuteDeleteAsync();
            await context.Favorites.ExecuteDeleteAsync();
            await context.CompletedModels.ExecuteDeleteAsync();
            await context.RecentViews.ExecuteDeleteAsync();
            await context.OrigamiTags.ExecuteDeleteAsync();
            await context.LearningProgresses.ExecuteDeleteAsync();
            await context.OrigamiSteps.ExecuteDeleteAsync();
            await context.OrigamiModels.ExecuteDeleteAsync();
        }
    }

    await OrigamiMaster.API.DatabaseSeeder.SeedOrigamiMeDataAsync(context);
}

if (app.Environment.IsDevelopment())
{
    try
    {
        Console.WriteLine("[Ngrok] Starting ngrok with static domain...");
        var processInfo = new System.Diagnostics.ProcessStartInfo("cmd", "/c taskkill /f /im ngrok.exe & start ngrok http --domain=unscrutinising-charlotte-deformative.ngrok-free.dev 5097")
        {
            CreateNoWindow = true,
            UseShellExecute = false
        };
        System.Diagnostics.Process.Start(processInfo);
    }
    catch (Exception ex)
    {
        Console.WriteLine($"[Ngrok] Failed to start ngrok automatically: {ex.Message}");
    }
}

app.Run();
