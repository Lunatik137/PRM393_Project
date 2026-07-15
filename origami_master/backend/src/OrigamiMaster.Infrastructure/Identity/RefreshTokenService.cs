using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Infrastructure.Persistence;
using System;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Identity;

public class RefreshTokenService : IRefreshTokenService
{
    private readonly ApplicationDbContext _context;
    private readonly IConfiguration _configuration;

    public RefreshTokenService(ApplicationDbContext context, IConfiguration configuration)
    {
        _context = context;
        _configuration = configuration;
    }

    public async Task<RefreshToken> GenerateRefreshTokenAsync(Guid userId)
    {
        var token = new RefreshToken
        {
            Id = Guid.NewGuid(),
            UserId = userId,
            Token = Convert.ToBase64String(RandomNumberGenerator.GetBytes(64)),
            ExpiresAt = DateTime.UtcNow.AddDays(_configuration.GetValue<int>("Jwt:RefreshTokenDays", 30)),
            CreatedAt = DateTime.UtcNow,
            IsRevoked = false
        };

        await _context.RefreshTokens.AddAsync(token);
        return token;
    }

    public async Task<RefreshToken?> GetByTokenAsync(string token)
    {
        return await _context.RefreshTokens.FirstOrDefaultAsync(r => r.Token == token);
    }

    public Task RevokeTokenAsync(RefreshToken token)
    {
        token.IsRevoked = true;
        _context.RefreshTokens.Update(token);
        return Task.CompletedTask;
    }

    public async Task RemoveOldTokensAsync(Guid userId)
    {
        var expiredOrRevoked = await _context.RefreshTokens
            .Where(r => r.UserId == userId && (r.IsRevoked || r.ExpiresAt < DateTime.UtcNow))
            .ToListAsync();

        if (expiredOrRevoked.Any())
        {
            _context.RefreshTokens.RemoveRange(expiredOrRevoked);
        }
    }
}
