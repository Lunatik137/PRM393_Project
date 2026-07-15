using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class ShareLinkRepository : IShareLinkRepository
{
    private readonly ApplicationDbContext _context;

    public ShareLinkRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<ShareLink?> GetByIdAsync(Guid id)
    {
        return await _context.ShareLinks.AsNoTracking().FirstOrDefaultAsync(s => s.Id == id);
    }

    public async Task<ShareLink?> GetByIdForUpdateAsync(Guid id)
    {
        return await _context.ShareLinks
            .Include(s => s.Creation)
            .FirstOrDefaultAsync(s => s.Id == id);
    }

    public async Task<ShareLink?> GetByTokenAsync(string token)
    {
        return await _context.ShareLinks.AsNoTracking().FirstOrDefaultAsync(s => s.Token == token);
    }

    public async Task AddAsync(ShareLink shareLink)
    {
        await _context.ShareLinks.AddAsync(shareLink);
    }

    public Task UpdateAsync(ShareLink shareLink)
    {
        _context.ShareLinks.Update(shareLink);
        return Task.CompletedTask;
    }

    public Task DeleteAsync(ShareLink shareLink)
    {
        _context.ShareLinks.Remove(shareLink);
        return Task.CompletedTask;
    }

    public async Task<System.Collections.Generic.List<ShareLink>> GetByUserIdAsync(Guid userId)
    {
        return await _context.ShareLinks
            .Include(s => s.Creation)
            .ThenInclude(c => c!.OrigamiModel)
            .Where(s => s.Creation!.UserId == userId)
            .OrderByDescending(s => s.CreatedAt)
            .AsNoTracking()
            .ToListAsync();
    }

    public async Task<bool> TokenExistsAsync(string token)
    {
        return await _context.ShareLinks.AnyAsync(s => s.Token == token);
    }

    public async Task<System.Collections.Generic.List<ShareLink>> GetByCreationIdAsync(Guid creationId)
    {
        return await _context.ShareLinks
            .Where(s => s.CreationId == creationId)
            .ToListAsync();
    }
}
