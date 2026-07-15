using System;
using System.Collections.Generic;

namespace OrigamiMaster.Domain.Entities;

public class FeedPost
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string? ImageUrl { get; set; }
    public string Description { get; set; } = string.Empty;
    public int LikeCount { get; set; }
    public int CommentCount { get; set; }
    public DateTime PublishedAt { get; set; }
    public List<string> Hashtags { get; set; } = new();

    public User? User { get; set; }

    public void IncreaseLikeCount()
    {
        LikeCount++;
    }

    public void DecreaseLikeCount()
    {
        if (LikeCount > 0)
        {
            LikeCount--;
        }
    }

    public void IncreaseCommentCount()
    {
        CommentCount++;
    }

    public void DecreaseCommentCount()
    {
        if (CommentCount > 0)
        {
            CommentCount--;
        }
    }
}
