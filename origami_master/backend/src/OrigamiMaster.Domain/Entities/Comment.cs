using System;
using OrigamiMaster.Domain.Exceptions;

namespace OrigamiMaster.Domain.Entities;

public class Comment
{
    public Guid Id { get; set; }
    public Guid FeedPostId { get; set; }
    public Guid UserId { get; set; }
    public string Content { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    public User? User { get; set; }

    public Comment() { }

    public Comment(Guid feedPostId, Guid userId, string content)
    {
        if (string.IsNullOrWhiteSpace(content))
        {
            throw new DomainException("Comment content is required.");
        }

        FeedPostId = feedPostId;
        UserId = userId;
        Content = content;
        CreatedAt = DateTime.UtcNow;
    }

    public void UpdateContent(string content)
    {
        if (string.IsNullOrWhiteSpace(content))
        {
            throw new DomainException("Comment content is required.");
        }

        Content = content;
        UpdatedAt = DateTime.UtcNow;
    }
}
