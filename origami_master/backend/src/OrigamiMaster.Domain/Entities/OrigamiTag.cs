using System;

namespace OrigamiMaster.Domain.Entities;

public class OrigamiTag
{
    public Guid OrigamiModelId { get; set; }
    public OrigamiModel OrigamiModel { get; set; } = null!;

    public Guid TagId { get; set; }
    public Tag Tag { get; set; } = null!;
}
