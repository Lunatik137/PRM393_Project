using System;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Search.DTOs;

public class SearchResponseDto
{
    public List<SearchUserDto> Users { get; set; } = new();
    public List<SearchPostDto> Posts { get; set; } = new();
    public List<SearchHashtagDto> Hashtags { get; set; } = new();
}

public class SearchHashtagDto
{
    public string Name { get; set; } = string.Empty;
    public int PostCount { get; set; }
}

public class SearchUserDto
{
    public Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string? AvatarUrl { get; set; }
    public int FollowersCount { get; set; }
}

public class SearchPostDto
{
    public Guid Id { get; set; }
    public string Description { get; set; } = string.Empty;
    public string? ImageUrl { get; set; }
    public Guid CreatorId { get; set; }
    public string CreatorName { get; set; } = string.Empty;
    public int LikeCount { get; set; }
}
