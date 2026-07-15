using System;

namespace OrigamiMaster.Application.Features.Comments.DTOs;

public class CommentDto
{
    public Guid Id { get; set; }
    public string Content { get; set; } = string.Empty;
    public CommentAuthorDto Author { get; set; } = new();
    public DateTime CreatedAt { get; set; }
    public bool IsOwner { get; set; }
}
