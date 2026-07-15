using System;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface IShareLinkRepository
{
    Task<ShareLink?> GetByIdAsync(Guid id);
    Task<ShareLink?> GetByIdForUpdateAsync(Guid id);
    Task<ShareLink?> GetByTokenAsync(string token);
    Task AddAsync(ShareLink shareLink);
    Task UpdateAsync(ShareLink shareLink);
    Task DeleteAsync(ShareLink shareLink);
    Task<System.Collections.Generic.List<ShareLink>> GetByUserIdAsync(Guid userId);
    Task<System.Collections.Generic.List<ShareLink>> GetByCreationIdAsync(Guid creationId);
    Task<bool> TokenExistsAsync(string token);
}
