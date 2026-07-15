using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Repositories;

public class LearningProgressRepository : ILearningProgressRepository
{
    private readonly ApplicationDbContext _context;

    public LearningProgressRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<LearningProgress?> GetByIdAsync(Guid id)
    {
        return await _context.LearningProgresses.AsNoTracking().FirstOrDefaultAsync(lp => lp.Id == id);
    }

    public async Task<LearningProgress?> GetByUserAndModelAsync(Guid userId, Guid origamiModelId)
    {
        return await _context.LearningProgresses.AsNoTracking()
            .FirstOrDefaultAsync(lp => lp.UserId == userId && lp.OrigamiModelId == origamiModelId);
    }

    public async Task AddAsync(LearningProgress progress)
    {
        await _context.LearningProgresses.AddAsync(progress);
    }

    public Task UpdateAsync(LearningProgress progress)
    {
        _context.LearningProgresses.Update(progress);
        return Task.CompletedTask;
    }

    public async Task<int> GetCompletedCountAsync(Guid userId)
    {
        return await _context.LearningProgresses.CountAsync(lp => lp.UserId == userId && lp.IsCompleted);
    }
}
