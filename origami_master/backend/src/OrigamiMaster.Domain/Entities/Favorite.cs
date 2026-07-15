using System;

namespace OrigamiMaster.Domain.Entities;

public class Favorite
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    public Guid OrigamiModelId { get; set; }
    public OrigamiModel OrigamiModel { get; set; } = null!;
}
