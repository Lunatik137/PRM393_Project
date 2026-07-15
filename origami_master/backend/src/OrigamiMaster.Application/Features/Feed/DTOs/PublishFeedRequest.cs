using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Feed.DTOs;

public class PublishFeedRequest
{
    public string? ImageUrl { get; set; }
    public string Description { get; set; } = string.Empty;
    public List<string> Hashtags { get; set; } = new();
}
