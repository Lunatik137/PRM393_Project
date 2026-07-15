using System;

namespace OrigamiMaster.Application.Features.ShareLinks.DTOs;

public class SharedCreationDto
{
    public string ImageUrl { get; set; } = string.Empty;
    public string OrigamiModelName { get; set; } = string.Empty;
    public string CreatorUsername { get; set; } = string.Empty;
    public DateTime CompletionDate { get; set; }
    public string Visibility { get; set; } = "ReadOnly";
    public string? Description { get; set; }
}
