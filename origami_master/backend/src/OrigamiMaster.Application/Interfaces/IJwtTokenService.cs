using OrigamiMaster.Domain.Entities;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Interfaces;

public interface IJwtTokenService
{
    string GenerateAccessToken(User user);
    int GetAccessTokenExpiresIn();
}
