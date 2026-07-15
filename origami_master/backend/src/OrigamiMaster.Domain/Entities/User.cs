using System;
using System.Collections.Generic;

namespace OrigamiMaster.Domain.Entities;

public class User
{
    public Guid Id { get; set; }
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public string? GoogleId { get; set; }
    public string? AvatarUrl { get; set; }
    public string? Bio { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    public ICollection<Creation> Creations { get; set; } = new List<Creation>();
    public ICollection<FeedPost> FeedPosts { get; set; } = new List<FeedPost>();
    public ICollection<Comment> Comments { get; set; } = new List<Comment>();
    public ICollection<Like> Likes { get; set; } = new List<Like>();
    public ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();
    public ICollection<CompletedModel> CompletedModels { get; set; } = new List<CompletedModel>();
    public ICollection<RecentView> RecentViews { get; set; } = new List<RecentView>();
}
