using System;

namespace OrigamiMaster.Domain.Entities;

public class OrigamiStep
{
    public Guid Id { get; set; }
    
    public Guid OrigamiModelId { get; set; }
    public OrigamiModel OrigamiModel { get; set; } = null!;

    public int StepNumber { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string? ImageUrl { get; set; }
}
