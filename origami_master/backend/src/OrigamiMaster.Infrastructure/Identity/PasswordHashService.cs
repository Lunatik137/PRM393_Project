using Microsoft.AspNetCore.Identity;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Identity;

public class PasswordHashService : IPasswordHashService
{
    private readonly IPasswordHasher<User> _passwordHasher;
    private readonly User _dummyUser = new User();

    public PasswordHashService(IPasswordHasher<User> passwordHasher)
    {
        _passwordHasher = passwordHasher;
    }

    public string HashPassword(string password)
    {
        return _passwordHasher.HashPassword(_dummyUser, password);
    }

    public bool VerifyPassword(string hash, string password)
    {
        var result = _passwordHasher.VerifyHashedPassword(_dummyUser, hash, password);
        return result == PasswordVerificationResult.Success;
    }
}
