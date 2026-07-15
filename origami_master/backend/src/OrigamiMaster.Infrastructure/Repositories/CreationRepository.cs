using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class CreationRepository : ICreationRepository
{
    private readonly ApplicationDbContext _context;

    public CreationRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Creation?> GetByIdAsync(Guid id)
    {
        return await _context.Creations.Include(c => c.OrigamiModel).FirstOrDefaultAsync(c => c.Id == id);
    }

    public async Task<IEnumerable<Creation>> GetByUserIdAsync(Guid userId)
    {
        return await _context.Creations.AsNoTracking().Where(c => c.UserId == userId).ToListAsync();
    }

    public async Task AddAsync(Creation creation)
    {
        await _context.Creations.AddAsync(creation);
    }

    public Task UpdateAsync(Creation creation)
    {
        _context.Creations.Update(creation);
        return Task.CompletedTask;
    }

    public Task DeleteAsync(Creation creation)
    {
        _context.Creations.Remove(creation);
        return Task.CompletedTask;
    }

    public async Task<int> GetPublicCreationCountAsync(Guid userId)
    {
        return await _context.Creations.CountAsync(c => c.UserId == userId && c.Visibility == OrigamiMaster.Domain.Enums.CreationVisibility.Public);
    }

    public async Task<List<Creation>> GetByUserIdAsync(Guid userId, int pageNumber, int pageSize, OrigamiMaster.Domain.Enums.CreationVisibility? visibility)
    {
        var query = _context.Creations
            .Include(c => c.OrigamiModel)
            .Include(c => c.User)
            .Where(c => c.UserId == userId);

        if (visibility.HasValue)
        {
            query = query.Where(c => c.Visibility == visibility.Value);
        }

        return await query
            .OrderByDescending(c => c.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .AsNoTracking()
            .ToListAsync();
    }

    public async Task<int> CountByUserIdAsync(Guid userId)
    {
        return await _context.Creations.CountAsync(c => c.UserId == userId);
    }

    public async Task<int> CountPrivateAsync(Guid userId)
    {
        return await _context.Creations.CountAsync(c => c.UserId == userId && c.Visibility == OrigamiMaster.Domain.Enums.CreationVisibility.Private);
    }

    public async Task<List<Creation>> GetPublicAsync(Guid? origamiModelId, int pageNumber, int pageSize)
    {
        var query = _context.Creations
            .Include(c => c.OrigamiModel)
            .Include(c => c.User)
            .Where(c => c.Visibility == OrigamiMaster.Domain.Enums.CreationVisibility.Public);

        if (origamiModelId.HasValue)
            query = query.Where(c => c.OrigamiModelId == origamiModelId.Value);

        return await query
            .OrderByDescending(c => c.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .AsNoTracking()
            .ToListAsync();
    }

    public async Task<int> CountPublishedAsync(Guid userId)
    {
        return await _context.Creations.CountAsync(c => c.UserId == userId && c.IsPublished);
    }

    public async Task<Creation?> GetWithUserAndModelAsync(Guid creationId)
    {
        return await _context.Creations
            .Include(c => c.User)
            .Include(c => c.OrigamiModel)
            .FirstOrDefaultAsync(c => c.Id == creationId);
    }

    public async Task<int> GetCompletedFoldsCountAsync(Guid userId)
    {
        return await _context.Creations
            .Where(c => c.UserId == userId && c.OrigamiModelId != null)
            .Select(c => c.OrigamiModelId)
            .Distinct()
            .CountAsync();
    }
}
