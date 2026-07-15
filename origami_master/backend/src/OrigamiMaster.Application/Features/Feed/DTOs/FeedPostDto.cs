using System;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Feed.DTOs;

public class FeedPostDto
{
    public Guid Id { get; set; }
    public string Description { get; set; } = string.Empty;
    public string? ImageUrl { get; set; }
    public DateTime PublishedAt { get; set; }
    public FeedAuthorDto Author { get; set; } = new();
    public int LikeCount { get; set; }
    public int CommentCount { get; set; }
    public bool IsLiked { get; set; }
    public bool IsFollowingAuthor { get; set; }
    public List<string> Hashtags { get; set; } = new();
}
