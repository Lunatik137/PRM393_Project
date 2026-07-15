using System;

namespace OrigamiMaster.Application.Features.Comments.DTOs;

public class CommentAuthorDto
{
    public Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string? AvatarUrl { get; set; }
}
