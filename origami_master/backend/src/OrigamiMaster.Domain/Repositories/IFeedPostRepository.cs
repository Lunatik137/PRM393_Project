using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface IFeedPostRepository
{
    Task<FeedPost?> GetByIdAsync(Guid id);
    Task<IEnumerable<FeedPost>> GetFeedAsync();
    Task<List<FeedPost>> GetHomeFeedAsync(Guid? currentUserId, int pageNumber, int pageSize);
    Task<bool> ExistsByCreationIdAsync(Guid creationId);
    Task<FeedPost?> GetByCreationIdAsync(Guid creationId);
    Task AddAsync(FeedPost post);
    Task UpdateAsync(FeedPost post);
    Task DeleteAsync(FeedPost post);
    Task<List<FeedPost>> GetUserPostsAsync(Guid userId, int pageNumber, int pageSize);
    Task<int> CountByUserIdAsync(Guid userId);
}
