using System;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface ILearningProgressRepository
{
    Task<LearningProgress?> GetByIdAsync(Guid id);
    Task<LearningProgress?> GetByUserAndModelAsync(Guid userId, Guid origamiModelId);
    Task AddAsync(LearningProgress progress);
    Task UpdateAsync(LearningProgress progress);
    Task<int> GetCompletedCountAsync(Guid userId);
}
