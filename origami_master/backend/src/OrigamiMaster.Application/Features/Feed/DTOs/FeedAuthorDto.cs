using System;

namespace OrigamiMaster.Application.Features.Feed.DTOs;

public class FeedAuthorDto
{
    public Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string? AvatarUrl { get; set; }
}
