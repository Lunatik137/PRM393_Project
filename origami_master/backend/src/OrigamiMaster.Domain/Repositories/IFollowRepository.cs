using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface IFollowRepository
{
    Task<Follow?> GetByIdAsync(Guid id);
    Task<Follow?> GetFollowAsync(Guid followerId, Guid followingId);
    Task<IEnumerable<Follow>> GetFollowersAsync(Guid userId);
    Task<IEnumerable<Follow>> GetFollowingAsync(Guid userId);
    Task<bool> IsFollowingAsync(Guid followerId, Guid followingId);
    Task<int> GetFollowersCountAsync(Guid userId);
    Task<int> GetFollowingCountAsync(Guid userId);
    Task<List<Guid>> GetFollowingIdsAsync(Guid userId);
    Task AddAsync(Follow follow);
    Task DeleteAsync(Follow follow);
}
