using System;
using OrigamiMaster.Domain.Enums;

namespace OrigamiMaster.Domain.Entities;

public class Creation
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public Guid? OrigamiModelId { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public CreationVisibility Visibility { get; set; }
    public bool IsPublished { get; set; }
    public DateTime? PublishedAt { get; set; }
    public DateTime CreatedAt { get; set; }

    public OrigamiModel? OrigamiModel { get; set; }
    public User? User { get; set; }

    public void Publish()
    {
        IsPublished = true;
        PublishedAt = DateTime.UtcNow;
        Visibility = CreationVisibility.Public;
    }

    public void MakePublic()
    {
        Visibility = CreationVisibility.Public;
    }

    public void MakePrivate()
    {
        Visibility = CreationVisibility.Private;
    }
}
