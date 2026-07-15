using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Enums;

namespace OrigamiMaster.Domain.Repositories;

public interface IOrigamiModelRepository
{
    Task<OrigamiModel?> GetByIdAsync(Guid id);
    Task<bool> ExistsAsync(Guid modelId);
    Task<(IEnumerable<OrigamiModel> Items, int TotalCount)> GetPagedAsync(
        string? keyword, Guid? categoryId, DifficultyLevel? difficulty, int pageNumber, int pageSize);
    Task<IEnumerable<OrigamiModel>> GetPopularAsync(int limit);
    Task<IEnumerable<OrigamiModel>> GetLatestAsync(int limit);
    Task AddAsync(OrigamiModel model);
    Task UpdateAsync(OrigamiModel model);
    Task DeleteAsync(OrigamiModel model);
}
