using System;

namespace OrigamiMaster.Domain.Entities;

public class ShareLink
{
    public Guid Id { get; set; }
    public Guid CreationId { get; set; }
    public string Token { get; set; } = string.Empty;
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? DisabledAt { get; set; }

    public Creation? Creation { get; set; }

    public void Disable()
    {
        IsActive = false;
        DisabledAt = DateTime.UtcNow;
    }

    public void Toggle()
    {
        IsActive = !IsActive;
        DisabledAt = IsActive ? null : DateTime.UtcNow;
    }
}
