using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class CommentRepository : ICommentRepository
{
    private readonly ApplicationDbContext _context;

    public CommentRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Comment?> GetByIdAsync(Guid id)
    {
        return await _context.Comments.AsNoTracking().FirstOrDefaultAsync(c => c.Id == id);
    }

    public async Task<IEnumerable<Comment>> GetByFeedPostIdAsync(Guid feedPostId)
    {
        return await _context.Comments.AsNoTracking().Where(c => c.FeedPostId == feedPostId).ToListAsync();
    }

    public async Task<List<Comment>> GetByPostIdAsync(Guid postId, int pageNumber, int pageSize)
    {
        return await _context.Comments
            .Include(c => c.User)
            .AsNoTracking()
            .Where(c => c.FeedPostId == postId)
            .OrderBy(c => c.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();
    }

    public async Task<int> CountAsync(Guid postId)
    {
        return await _context.Comments.CountAsync(c => c.FeedPostId == postId);
    }

    public async Task AddAsync(Comment comment)
    {
        await _context.Comments.AddAsync(comment);
    }

    public Task UpdateAsync(Comment comment)
    {
        _context.Comments.Update(comment);
        return Task.CompletedTask;
    }

    public Task DeleteAsync(Comment comment)
    {
        _context.Comments.Remove(comment);
        return Task.CompletedTask;
    }
}
