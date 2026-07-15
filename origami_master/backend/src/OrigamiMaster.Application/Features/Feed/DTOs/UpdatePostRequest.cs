using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Feed.DTOs;

public class UpdatePostRequest
{
    public string Description { get; set; } = string.Empty;
    public List<string>? Hashtags { get; set; }
}
