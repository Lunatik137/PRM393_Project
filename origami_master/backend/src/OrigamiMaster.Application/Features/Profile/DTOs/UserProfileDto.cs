using System;

namespace OrigamiMaster.Application.Features.Profile.DTOs;

public class UserProfileDto
{
    public Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? AvatarUrl { get; set; }
    public string? Bio { get; set; }
    public ProfileStatisticsDto Statistics { get; set; } = new();
    public bool? IsFollowing { get; set; }
}
