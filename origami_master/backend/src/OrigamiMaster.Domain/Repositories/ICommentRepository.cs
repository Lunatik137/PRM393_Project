using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface ICommentRepository
{
    Task<Comment?> GetByIdAsync(Guid id);
    Task<IEnumerable<Comment>> GetByFeedPostIdAsync(Guid feedPostId);
    Task<List<Comment>> GetByPostIdAsync(Guid postId, int pageNumber, int pageSize);
    Task<int> CountAsync(Guid postId);
    Task AddAsync(Comment comment);
    Task UpdateAsync(Comment comment);
    Task DeleteAsync(Comment comment);
}
