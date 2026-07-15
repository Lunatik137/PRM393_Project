using System;
using System.Collections.Generic;
using OrigamiMaster.Domain.Enums;

namespace OrigamiMaster.Domain.Entities;

public class OrigamiModel
{
    public Guid Id { get; set; }
    public Guid CategoryId { get; set; }
    public Category Category { get; set; } = null!;
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public DifficultyLevel Difficulty { get; set; }
    public string? ThumbnailUrl { get; set; }
    public string? CoverImageUrl { get; set; }
    public int EstimatedMinutes { get; set; }
    public string Materials { get; set; } = string.Empty; // Storing as JSON or comma-separated
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

    public ICollection<OrigamiStep> Steps { get; set; } = new List<OrigamiStep>();
    public ICollection<OrigamiTag> OrigamiTags { get; set; } = new List<OrigamiTag>();
    public ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();
    public ICollection<CompletedModel> CompletedModels { get; set; } = new List<CompletedModel>();
    public ICollection<RecentView> RecentViews { get; set; } = new List<RecentView>();
}
