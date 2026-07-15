using System;

namespace OrigamiMaster.Domain.Entities;

public class Like
{
    public Guid Id { get; set; }
    public Guid FeedPostId { get; set; }
    public Guid UserId { get; set; }
    public DateTime CreatedAt { get; set; }
}
