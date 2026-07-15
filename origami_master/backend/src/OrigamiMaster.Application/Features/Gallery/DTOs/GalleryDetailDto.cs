using System;

namespace OrigamiMaster.Application.Features.Gallery.DTOs;

public class GalleryDetailDto
{
    public Guid Id { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public string Visibility { get; set; } = string.Empty;
    public bool IsPublished { get; set; }
    public string? Caption { get; set; }
    public DateTime CreatedAt { get; set; }
    public OrigamiModelSummaryDto? OrigamiModel { get; set; }
    public Guid CreatorId { get; set; }
    public string CreatorName { get; set; } = string.Empty;
    public string? CreatorAvatar { get; set; }
    // Share link info (null if no link generated)
    public Guid? ShareLinkId { get; set; }
    public string? ShareToken { get; set; }
    public bool? ShareIsActive { get; set; }
}

public class OrigamiModelSummaryDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Difficulty { get; set; } = string.Empty;
}
