using System;

namespace OrigamiMaster.Domain.Entities;

public class LearningProgress
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public Guid OrigamiModelId { get; set; }
    public int CurrentStep { get; set; }
    public bool IsCompleted { get; set; }
    public DateTime StartedAt { get; set; }
    public DateTime? CompletedAt { get; set; }
}
