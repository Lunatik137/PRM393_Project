using System;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface ILikeRepository
{
    Task<Like?> GetByIdAsync(Guid id);
    Task<Like?> GetByUserAndPostAsync(Guid userId, Guid feedPostId);
    Task<List<Guid>> GetLikedPostIdsAsync(Guid userId, List<Guid> feedPostIds);
    Task AddAsync(Like like);
    Task DeleteAsync(Like like);
}
