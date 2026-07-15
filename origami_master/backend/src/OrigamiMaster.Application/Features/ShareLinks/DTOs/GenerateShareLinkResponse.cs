using System;

namespace OrigamiMaster.Application.Features.ShareLinks.DTOs;

public class GenerateShareLinkResponse
{
    public Guid ShareLinkId { get; set; }
    public string Url { get; set; } = string.Empty;
}
