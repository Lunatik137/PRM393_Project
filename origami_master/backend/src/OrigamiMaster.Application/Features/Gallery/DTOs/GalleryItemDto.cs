using System;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Gallery.DTOs;

public class GalleryItemDto
{
    public Guid Id { get; set; }
    public Guid? OrigamiModelId { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public string OrigamiModelName { get; set; } = string.Empty;
    public string Difficulty { get; set; } = string.Empty;
    public string Visibility { get; set; } = string.Empty;
    public bool IsPublished { get; set; }
    public string? Caption { get; set; }
    public List<string>? Hashtags { get; set; }
    public DateTime CreatedAt { get; set; }
    public Guid CreatorId { get; set; }
    public string CreatorName { get; set; } = string.Empty;
    public string? CreatorAvatar { get; set; }
}
