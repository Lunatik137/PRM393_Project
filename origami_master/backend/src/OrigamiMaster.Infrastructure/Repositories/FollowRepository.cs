using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class FollowRepository : IFollowRepository
{
    private readonly ApplicationDbContext _context;

    public FollowRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Follow?> GetByIdAsync(Guid id)
    {
        return await _context.Follows.AsNoTracking().FirstOrDefaultAsync(f => f.Id == id);
    }

    public async Task<Follow?> GetFollowAsync(Guid followerId, Guid followingId)
    {
        return await _context.Follows.AsNoTracking()
            .FirstOrDefaultAsync(f => f.FollowerUserId == followerId && f.FollowingUserId == followingId);
    }

    public async Task<IEnumerable<Follow>> GetFollowersAsync(Guid userId)
    {
        return await _context.Follows.AsNoTracking()
            .Include(f => f.FollowerUser)
            .Where(f => f.FollowingUserId == userId)
            .OrderByDescending(f => f.CreatedAt)
            .ToListAsync();
    }

    public async Task<IEnumerable<Follow>> GetFollowingAsync(Guid userId)
    {
        return await _context.Follows.AsNoTracking()
            .Include(f => f.FollowingUser)
            .Where(f => f.FollowerUserId == userId)
            .OrderByDescending(f => f.CreatedAt)
            .ToListAsync();
    }

    public async Task<bool> IsFollowingAsync(Guid followerId, Guid followingId)
    {
        return await _context.Follows.AnyAsync(f => f.FollowerUserId == followerId && f.FollowingUserId == followingId);
    }

    public async Task<int> GetFollowersCountAsync(Guid userId)
    {
        return await _context.Follows.CountAsync(f => f.FollowingUserId == userId);
    }

    public async Task<int> GetFollowingCountAsync(Guid userId)
    {
        return await _context.Follows.CountAsync(f => f.FollowerUserId == userId);
    }

    public async Task<List<Guid>> GetFollowingIdsAsync(Guid userId)
    {
        return await _context.Follows
            .Where(f => f.FollowerUserId == userId)
            .Select(f => f.FollowingUserId)
            .ToListAsync();
    }

    public async Task AddAsync(Follow follow)
    {
        await _context.Follows.AddAsync(follow);
    }

    public Task DeleteAsync(Follow follow)
    {
        _context.Follows.Remove(follow);
        return Task.CompletedTask;
    }
}
