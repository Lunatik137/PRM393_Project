using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class FeedPostRepository : IFeedPostRepository
{
    private readonly ApplicationDbContext _context;

    public FeedPostRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<FeedPost?> GetByIdAsync(Guid id)
    {
        return await _context.FeedPosts
            .Include(f => f.User)
            .AsNoTracking()
            .FirstOrDefaultAsync(f => f.Id == id);
    }

    public async Task<IEnumerable<FeedPost>> GetFeedAsync()
    {
        return await _context.FeedPosts.AsNoTracking().ToListAsync();
    }

    public async Task<List<FeedPost>> GetHomeFeedAsync(Guid? currentUserId, int pageNumber, int pageSize)
    {
        var query = _context.FeedPosts
            .Include(f => f.User)
            .AsNoTracking();

        if (currentUserId.HasValue)
        {
            var followedUserIds = await _context.Follows
                .Where(f => f.FollowerUserId == currentUserId.Value)
                .Select(f => f.FollowingUserId)
                .ToListAsync();

            int followingCount = (int)Math.Ceiling(pageSize * 0.7);
            int recommendedCount = pageSize - followingCount;

            var followingPosts = await query
                .Where(f => followedUserIds.Contains(f.UserId))
                .OrderByDescending(f => f.PublishedAt)
                .Skip((pageNumber - 1) * followingCount)
                .Take(followingCount)
                .ToListAsync();

            var followingPostIds = followingPosts.Select(f => f.Id).ToList();

            var recommendedPosts = await query
                .Where(f => !followingPostIds.Contains(f.Id))
                .OrderByDescending(f => f.LikeCount).ThenByDescending(f => f.PublishedAt)
                .Skip((pageNumber - 1) * recommendedCount)
                .Take(recommendedCount)
                .ToListAsync();

            return followingPosts.Concat(recommendedPosts)
                .OrderByDescending(f => f.PublishedAt)
                .ToList();
        }
        else
        {
            return await query
                .OrderByDescending(f => f.LikeCount).ThenByDescending(f => f.PublishedAt)
                .Skip((pageNumber - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
        }
    }

    // Legacy method - kept for interface compatibility, now returns false since there's no CreationId
    public Task<bool> ExistsByCreationIdAsync(Guid creationId)
    {
        return Task.FromResult(false);
    }

    // Legacy method - kept for interface compatibility
    public Task<FeedPost?> GetByCreationIdAsync(Guid creationId)
    {
        return Task.FromResult<FeedPost?>(null);
    }

    public async Task AddAsync(FeedPost post)
    {
        await _context.FeedPosts.AddAsync(post);
    }

    public Task UpdateAsync(FeedPost post)
    {
        _context.FeedPosts.Update(post);
        return Task.CompletedTask;
    }

    public Task DeleteAsync(FeedPost post)
    {
        _context.FeedPosts.Remove(post);
        return Task.CompletedTask;
    }

    public async Task<List<FeedPost>> GetUserPostsAsync(Guid userId, int pageNumber, int pageSize)
    {
        return await _context.FeedPosts
            .Include(f => f.User)
            .Where(f => f.UserId == userId)
            .OrderByDescending(f => f.PublishedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .AsNoTracking()
            .ToListAsync();
    }

    public async Task<int> CountByUserIdAsync(Guid userId)
    {
        return await _context.FeedPosts.CountAsync(f => f.UserId == userId);
    }
}
