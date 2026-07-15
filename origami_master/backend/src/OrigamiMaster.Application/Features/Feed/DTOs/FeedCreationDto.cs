using System;

namespace OrigamiMaster.Application.Features.Feed.DTOs;

public class FeedCreationDto
{
    public Guid Id { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public string OrigamiModelName { get; set; } = string.Empty;
    public string Difficulty { get; set; } = string.Empty;
}
