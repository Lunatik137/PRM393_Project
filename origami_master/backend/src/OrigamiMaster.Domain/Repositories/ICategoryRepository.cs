using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Domain.Repositories;

public interface ICategoryRepository
{
    Task<IEnumerable<Category>> GetAllAsync();
    Task<Category?> GetByIdAsync(Guid id);
    Task<Category?> GetBySlugAsync(string slug);
}
