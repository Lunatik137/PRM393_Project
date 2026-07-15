using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Enums;

namespace OrigamiMaster.Infrastructure.Persistence.Seed;

public static class OrigamiSeeder
{
    public static void Seed(ModelBuilder builder)
    {
        var categories = new List<Category>();
        var models = new List<OrigamiModel>();
        var steps = new List<OrigamiStep>();
        var tags = new List<Tag>();
        var origamiTags = new List<OrigamiTag>();

        var categoryNames = new[] { "Animals", "Birds", "Flowers", "Insects", "Dinosaurs", "Modular", "Boxes", "Airplanes", "Boats", "Holidays" };
        var adjectives = new[] { "Classic", "Simple", "Complex", "Modern", "Traditional", "Elegant", "Geometric", "Minimalist", "Advanced", "Origami" };

        // Generate Tags
        for (int i = 0; i < 50; i++)
        {
            tags.Add(new Tag
            {
                Id = CreateDeterministicGuid("tag", i),
                Name = $"Tag {i + 1}"
            });
        }

        // Generate Categories
        for (int i = 0; i < categoryNames.Length; i++)
        {
            var category = new Category
            {
                Id = CreateDeterministicGuid("cat", i),
                Name = categoryNames[i],
                Slug = categoryNames[i].ToLower(),
                Description = $"Beautiful origami models in the {categoryNames[i]} category.",
                Icon = "category_icon_" + categoryNames[i].ToLower()
            };
            categories.Add(category);

            // Generate 10 Models per Category
            for (int j = 0; j < 10; j++)
            {
                var modelIndex = (i * 10) + j;
                var modelName = $"{adjectives[modelIndex % adjectives.Length]} {categoryNames[i]} {j + 1}";
                
                var model = new OrigamiModel
                {
                    Id = CreateDeterministicGuid("mod", modelIndex),
                    CategoryId = category.Id,
                    Name = modelName,
                    Slug = modelName.ToLower().Replace(" ", "-"),
                    Description = $"Learn how to fold a {modelName}. This tutorial is perfect for everyone.",
                    Difficulty = (DifficultyLevel)(modelIndex % 4), // 0 to 3
                    EstimatedMinutes = (modelIndex % 5 + 1) * 10,
                    ThumbnailUrl = "https://example.com/thumb.jpg",
                    CoverImageUrl = "https://example.com/cover.jpg",
                    Materials = "[\"1x Square Paper 15x15cm\"]",
                    CreatedAt = new DateTime(2025, 1, 1, 0, 0, 0, DateTimeKind.Utc),
                    UpdatedAt = new DateTime(2025, 1, 1, 0, 0, 0, DateTimeKind.Utc)
                };
                models.Add(model);

                // Generate 6 Steps per Model
                for (int s = 0; s < 6; s++)
                {
                    var stepIndex = (modelIndex * 6) + s;
                    steps.Add(new OrigamiStep
                    {
                        Id = CreateDeterministicGuid("step", stepIndex),
                        OrigamiModelId = model.Id,
                        StepNumber = s + 1,
                        Title = $"Step {s + 1}",
                        Description = $"Fold along the crease as shown in the diagram for step {s + 1}.",
                        ImageUrl = "https://example.com/step.jpg"
                    });
                }

                // Map 2 Tags per Model
                origamiTags.Add(new OrigamiTag
                {
                    OrigamiModelId = model.Id,
                    TagId = tags[modelIndex % tags.Count].Id
                });
                origamiTags.Add(new OrigamiTag
                {
                    OrigamiModelId = model.Id,
                    TagId = tags[(modelIndex + 1) % tags.Count].Id
                });
            }
        }

        builder.Entity<Category>().HasData(categories);
        builder.Entity<Tag>().HasData(tags);
        builder.Entity<OrigamiModel>().HasData(models);
        builder.Entity<OrigamiStep>().HasData(steps);
        builder.Entity<OrigamiTag>().HasData(origamiTags);
    }

    private static Guid CreateDeterministicGuid(string prefix, int index)
    {
        var bytes = new byte[16];
        var prefixBytes = System.Text.Encoding.UTF8.GetBytes(prefix);
        for (int i = 0; i < Math.Min(prefixBytes.Length, 12); i++)
        {
            bytes[i] = prefixBytes[i];
        }
        var indexBytes = BitConverter.GetBytes(index);
        for (int i = 0; i < 4; i++)
        {
            bytes[12 + i] = indexBytes[i];
        }
        return new Guid(bytes);
    }
}
