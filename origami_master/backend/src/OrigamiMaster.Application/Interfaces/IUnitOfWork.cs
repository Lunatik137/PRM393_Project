using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Interfaces;

public interface IUnitOfWork
{
    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
