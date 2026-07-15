using System;

namespace OrigamiMaster.Application.Features.Follows.DTOs;

public class FollowStatusDto
{
    public Guid UserId { get; set; }
    public bool IsFollowing { get; set; }
    public int FollowersCount { get; set; }
    public int FollowingCount { get; set; }
}
