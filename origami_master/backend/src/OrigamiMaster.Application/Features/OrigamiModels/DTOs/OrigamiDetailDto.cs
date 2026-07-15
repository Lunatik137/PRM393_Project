using System;
using System.Collections.Generic;
using OrigamiMaster.Domain.Enums;
using OrigamiMaster.Application.Features.Categories.DTOs;

namespace OrigamiMaster.Application.Features.OrigamiModels.DTOs;

public class OrigamiDetailDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public DifficultyLevel Difficulty { get; set; }
    public string? ThumbnailUrl { get; set; }
    public string? CoverImageUrl { get; set; }
    public int EstimatedMinutes { get; set; }
    public string Materials { get; set; } = string.Empty;
    
    public CategoryDto Category { get; set; } = null!;
    public List<OrigamiStepDto> Steps { get; set; } = new List<OrigamiStepDto>();
    public List<TagDto> Tags { get; set; } = new List<TagDto>();
}
