using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Enums;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class OrigamiModelRepository : IOrigamiModelRepository
{
    private readonly ApplicationDbContext _context;

    public OrigamiModelRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<OrigamiModel?> GetByIdAsync(Guid id)
    {
        return await _context.OrigamiModels
            .Include(m => m.Category)
            .Include(m => m.Steps.OrderBy(s => s.StepNumber))
            .Include(m => m.OrigamiTags).ThenInclude(ot => ot.Tag)
            .AsNoTracking()
            .FirstOrDefaultAsync(m => m.Id == id);
    }

    public async Task<bool> ExistsAsync(Guid modelId)
    {
        return await _context.OrigamiModels.AnyAsync(m => m.Id == modelId);
    }

    public async Task<(IEnumerable<OrigamiModel> Items, int TotalCount)> GetPagedAsync(
        string? keyword, Guid? categoryId, DifficultyLevel? difficulty, int pageNumber, int pageSize)
    {
        var query = _context.OrigamiModels
            .Include(m => m.Category)
            .AsNoTracking()
            .AsQueryable();

        if (!string.IsNullOrWhiteSpace(keyword))
        {
            query = query.Where(m => m.Name.Contains(keyword) || m.Description.Contains(keyword));
        }

        if (categoryId.HasValue)
        {
            query = query.Where(m => m.CategoryId == categoryId.Value);
        }

        if (difficulty.HasValue)
        {
            query = query.Where(m => m.Difficulty == difficulty.Value);
        }

        var totalCount = await query.CountAsync();

        var items = await query
            .OrderByDescending(m => m.CreatedAt)
            .Skip((pageNumber - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();

        return (items, totalCount);
    }

    public async Task<IEnumerable<OrigamiModel>> GetPopularAsync(int limit)
    {
        return await _context.OrigamiModels
            .Include(m => m.Category)
            .OrderByDescending(m => m.Favorites.Count)
            .Take(limit)
            .AsNoTracking()
            .ToListAsync();
    }

    public async Task<IEnumerable<OrigamiModel>> GetLatestAsync(int limit)
    {
        return await _context.OrigamiModels
            .Include(m => m.Category)
            .OrderByDescending(m => m.CreatedAt)
            .Take(limit)
            .AsNoTracking()
            .ToListAsync();
    }

    public async Task AddAsync(OrigamiModel model)
    {
        await _context.OrigamiModels.AddAsync(model);
    }

    public Task UpdateAsync(OrigamiModel model)
    {
        _context.OrigamiModels.Update(model);
        return Task.CompletedTask;
    }

    public Task DeleteAsync(OrigamiModel model)
    {
        _context.OrigamiModels.Remove(model);
        return Task.CompletedTask;
    }
}
