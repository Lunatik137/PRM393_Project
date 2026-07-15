using System.Collections.Generic;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface ISearchRepository
{
    Task<List<User>> SearchUsersAsync(string query, int limit = 10);
    Task<List<FeedPost>> SearchPostsAsync(string query, int limit = 10);
    Task<List<FeedPost>> SearchPostsByHashtagAsync(string hashtag, int limit = 20);
    Task<List<FeedPost>> SearchPostsByUserIdAsync(System.Guid userId, int limit = 20);
    Task<List<(string Hashtag, int PostCount)>> SearchHashtagsAsync(string query, int limit = 10);
}
