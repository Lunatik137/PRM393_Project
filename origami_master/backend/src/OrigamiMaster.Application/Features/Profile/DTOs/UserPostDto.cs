using System;

namespace OrigamiMaster.Application.Features.Profile.DTOs;

public class UserPostDto
{
    public Guid Id { get; set; }
    public string Description { get; set; } = string.Empty;
    public string ImageUrl { get; set; } = string.Empty;
    public DateTime? PublishedAt { get; set; }
    public int LikeCount { get; set; }
    public int CommentCount { get; set; }
}
