using System;
using OrigamiMaster.Domain.Exceptions;

namespace OrigamiMaster.Domain.Entities;

public class Follow
{
    public Guid Id { get; set; }
    public Guid FollowerUserId { get; set; }
    public Guid FollowingUserId { get; set; }
    public DateTime CreatedAt { get; set; }

    // Navigation properties
    public User? FollowerUser { get; set; }
    public User? FollowingUser { get; set; }

    public Follow() { }

    public Follow(Guid followerUserId, Guid followingUserId)
    {
        if (followerUserId == followingUserId)
        {
            throw new DomainException("Users cannot follow themselves.");
        }

        FollowerUserId = followerUserId;
        FollowingUserId = followingUserId;
        CreatedAt = DateTime.UtcNow;
    }
}
