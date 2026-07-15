using System;

namespace OrigamiMaster.Application.Features.Gallery.DTOs;

public class CreateCreationRequest
{
    public Guid? OrigamiModelId { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public string Visibility { get; set; } = "Private";
}
