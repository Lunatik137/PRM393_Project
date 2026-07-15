using HtmlAgilityPack;
using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Enums;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace OrigamiMaster.API;

public static class DatabaseSeeder
{
    public static async Task SeedOrigamiMeDataAsync(ApplicationDbContext context)
    {
        // Guard: only seed if there is no data yet (run once)
        if (await context.OrigamiModels.AnyAsync())
        {
            Console.WriteLine("[Seeder] Data already exists – skipping seed.");
            return;
        }

        Console.WriteLine("[Seeder] No data found – seeding origami data...");

        var dataPath = Path.Combine(AppContext.BaseDirectory, "Data", "origami_data.json");
        if (!File.Exists(dataPath))
        {
            Console.WriteLine("[Seeder] origami_data.json not found.");
            return;
        }

        var json = await File.ReadAllTextAsync(dataPath);
        var options = new System.Text.Json.JsonSerializerOptions { PropertyNameCaseInsensitive = true };
        var seedData = System.Text.Json.JsonSerializer.Deserialize<SeedData>(json, options);

        if (seedData == null) return;

        var categoryMap = new Dictionary<Guid, Guid>();
        foreach (var category in seedData.Categories)
        {
            var existing = await context.Categories.FirstOrDefaultAsync(c => c.Slug == category.Slug);
            if (existing != null)
            {
                categoryMap[category.Id] = existing.Id;
            }
            else
            {
                context.Categories.Add(category);
                categoryMap[category.Id] = category.Id;
            }
        }
        await context.SaveChangesAsync();

        var seenSlugs = new HashSet<string>();
        var insertedModelIds = new HashSet<Guid>();
        foreach (var model in seedData.OrigamiModels)
        {
            if (seenSlugs.Contains(model.Slug)) continue;
            seenSlugs.Add(model.Slug);
            insertedModelIds.Add(model.Id);

            if (categoryMap.TryGetValue(model.CategoryId, out var realCategoryId))
            {
                model.CategoryId = realCategoryId;
            }
            model.CreatedAt = DateTime.UtcNow;
            model.UpdatedAt = DateTime.UtcNow;
            context.OrigamiModels.Add(model);
        }

        foreach (var step in seedData.OrigamiSteps)
        {
            if (insertedModelIds.Contains(step.OrigamiModelId))
            {
                context.OrigamiSteps.Add(step);
            }
        }

        await context.SaveChangesAsync();
        Console.WriteLine("[Seeder] Seed completed successfully.");
    }
}

public class SeedData
{
    public List<Category> Categories { get; set; } = new();
    public List<OrigamiModel> OrigamiModels { get; set; } = new();
    public List<OrigamiStep> OrigamiSteps { get; set; } = new();
}
