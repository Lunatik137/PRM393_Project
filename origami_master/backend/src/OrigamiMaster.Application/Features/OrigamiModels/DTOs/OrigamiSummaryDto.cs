using System;
using OrigamiMaster.Domain.Enums;

namespace OrigamiMaster.Application.Features.OrigamiModels.DTOs;

public class OrigamiSummaryDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public DifficultyLevel Difficulty { get; set; }
    public string? ThumbnailUrl { get; set; }
    public int EstimatedMinutes { get; set; }
    public Guid CategoryId { get; set; }
    public OrigamiMaster.Application.Features.Categories.DTOs.CategoryDto? Category { get; set; }
}
