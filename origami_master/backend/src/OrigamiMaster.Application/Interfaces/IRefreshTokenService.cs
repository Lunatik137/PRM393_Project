using OrigamiMaster.Domain.Entities;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Interfaces;

public interface IRefreshTokenService
{
    Task<RefreshToken> GenerateRefreshTokenAsync(Guid userId);
    Task<RefreshToken?> GetByTokenAsync(string token);
    Task RevokeTokenAsync(RefreshToken token);
    Task RemoveOldTokensAsync(Guid userId);
}
