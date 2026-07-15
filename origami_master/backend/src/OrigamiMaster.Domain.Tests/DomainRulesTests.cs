using System;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Exceptions;
using OrigamiMaster.Domain.Enums;
using Xunit;

namespace OrigamiMaster.Domain.Tests;

public class DomainRulesTests
{
    [Fact]
    public void Follow_CannotFollowSelf_ThrowsDomainException()
    {
        var userId = Guid.NewGuid();
        
        Assert.Throws<DomainException>(() => new Follow(userId, userId));
    }

    [Fact]
    public void Comment_EmptyContent_ThrowsDomainException()
    {
        var feedPostId = Guid.NewGuid();
        var userId = Guid.NewGuid();
        
        Assert.Throws<DomainException>(() => new Comment(feedPostId, userId, "   "));
        Assert.Throws<DomainException>(() => new Comment(feedPostId, userId, ""));
        Assert.Throws<DomainException>(() => new Comment(feedPostId, userId, null!));
    }

    [Fact]
    public void Comment_UpdateEmptyContent_ThrowsDomainException()
    {
        var comment = new Comment(Guid.NewGuid(), Guid.NewGuid(), "Valid comment");
        
        Assert.Throws<DomainException>(() => comment.UpdateContent("   "));
    }

    [Fact]
    public void Creation_Publish_UpdatesStateAndVisibility()
    {
        var creation = new Creation();
        
        creation.Publish();
        
        Assert.True(creation.IsPublished);
        Assert.NotNull(creation.PublishedAt);
        Assert.Equal(CreationVisibility.Public, creation.Visibility);
    }

    [Fact]
    public void FeedPost_IncreaseAndDecreaseLikeCount_UpdatesCountCorrectly()
    {
        var post = new FeedPost();
        
        post.IncreaseLikeCount();
        Assert.Equal(1, post.LikeCount);
        
        post.DecreaseLikeCount();
        Assert.Equal(0, post.LikeCount);
        
        post.DecreaseLikeCount(); // Should not go below 0
        Assert.Equal(0, post.LikeCount);
    }
}
