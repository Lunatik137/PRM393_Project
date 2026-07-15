using System;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Follows.DTOs;

public class FollowUserListDto
{
    public string Id { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public string? AvatarUrl { get; set; }
    public string? Bio { get; set; }
    public int FollowersCount { get; set; }
    public int FollowingCount { get; set; }
    public bool IsFollowing { get; set; }
}

public class PagedFollowUserListDto
{
    public List<FollowUserListDto> Items { get; set; } = new();
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public bool HasMore { get; set; }
}
