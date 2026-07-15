using System;

namespace OrigamiMaster.Application.Features.ShareLinks.DTOs;

public class ShareLinkDto
{
    public Guid Id { get; set; }
    public string Token { get; set; } = string.Empty;
    public Guid CreationId { get; set; }
    public string CreationName { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public bool IsActive { get; set; }
}
