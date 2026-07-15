using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Auth.Commands.Refresh;

public class RefreshTokenCommandHandler : IRequestHandler<RefreshTokenCommand, AuthResponse>
{
    private readonly IRefreshTokenService _refreshTokenService;
    private readonly IUserRepository _userRepository;
    private readonly IJwtTokenService _jwtTokenService;
    private readonly IUnitOfWork _unitOfWork;

    public RefreshTokenCommandHandler(
        IRefreshTokenService refreshTokenService,
        IUserRepository userRepository,
        IJwtTokenService jwtTokenService,
        IUnitOfWork unitOfWork)
    {
        _refreshTokenService = refreshTokenService;
        _userRepository = userRepository;
        _jwtTokenService = jwtTokenService;
        _unitOfWork = unitOfWork;
    }

    public async Task<AuthResponse> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
    {
        var oldToken = await _refreshTokenService.GetByTokenAsync(request.Token);
        if (oldToken == null || oldToken.IsRevoked)
        {
            throw new Exception("REFRESH_TOKEN_INVALID");
        }

        if (oldToken.ExpiresAt < DateTime.UtcNow)
        {
            throw new Exception("REFRESH_TOKEN_EXPIRED");
        }

        var user = await _userRepository.GetByIdAsync(oldToken.UserId);
        if (user == null)
        {
            throw new Exception("REFRESH_TOKEN_INVALID");
        }

        await _refreshTokenService.RevokeTokenAsync(oldToken);
        
        var accessToken = _jwtTokenService.GenerateAccessToken(user);
        var newRefreshToken = await _refreshTokenService.GenerateRefreshTokenAsync(user.Id);

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return new AuthResponse
        {
            AccessToken = accessToken,
            RefreshToken = newRefreshToken.Token,
            ExpiresIn = _jwtTokenService.GetAccessTokenExpiresIn()
        };
    }
}
