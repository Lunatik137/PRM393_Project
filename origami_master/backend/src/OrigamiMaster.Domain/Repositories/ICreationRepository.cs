using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface ICreationRepository
{
    Task<Creation?> GetByIdAsync(Guid id);
    Task<IEnumerable<Creation>> GetByUserIdAsync(Guid userId);
    Task AddAsync(Creation creation);
    Task UpdateAsync(Creation creation);
    Task DeleteAsync(Creation creation);
    Task<int> GetPublicCreationCountAsync(Guid userId);
    Task<List<Creation>> GetByUserIdAsync(Guid userId, int pageNumber, int pageSize, OrigamiMaster.Domain.Enums.CreationVisibility? visibility);
    Task<int> CountByUserIdAsync(Guid userId);
    Task<int> CountPrivateAsync(Guid userId);
    Task<int> CountPublishedAsync(Guid userId);
    Task<Creation?> GetWithUserAndModelAsync(Guid creationId);
    Task<List<Creation>> GetPublicAsync(Guid? origamiModelId, int pageNumber, int pageSize);
    Task<int> GetCompletedFoldsCountAsync(Guid userId);
}
