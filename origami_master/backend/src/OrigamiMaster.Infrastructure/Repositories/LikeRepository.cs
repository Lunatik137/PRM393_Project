using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class LikeRepository : ILikeRepository
{
    private readonly ApplicationDbContext _context;

    public LikeRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Like?> GetByIdAsync(Guid id)
    {
        return await _context.Likes.AsNoTracking().FirstOrDefaultAsync(l => l.Id == id);
    }

    public async Task<Like?> GetByUserAndPostAsync(Guid userId, Guid feedPostId)
    {
        return await _context.Likes.AsNoTracking().FirstOrDefaultAsync(l => l.UserId == userId && l.FeedPostId == feedPostId);
    }

    public async Task<System.Collections.Generic.List<Guid>> GetLikedPostIdsAsync(Guid userId, System.Collections.Generic.List<Guid> feedPostIds)
    {
        return await _context.Likes.AsNoTracking()
            .Where(l => l.UserId == userId && feedPostIds.Contains(l.FeedPostId))
            .Select(l => l.FeedPostId)
            .ToListAsync();
    }

    public async Task AddAsync(Like like)
    {
        await _context.Likes.AddAsync(like);
    }

    public Task DeleteAsync(Like like)
    {
        _context.Likes.Remove(like);
        return Task.CompletedTask;
    }
}
