using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Auth.Commands.Login;

public class LoginCommandHandler : IRequestHandler<LoginCommand, AuthResponse>
{
    private readonly IUserRepository _userRepository;
    private readonly IPasswordHashService _passwordHashService;
    private readonly IJwtTokenService _jwtTokenService;
    private readonly IRefreshTokenService _refreshTokenService;
    private readonly IUnitOfWork _unitOfWork;

    public LoginCommandHandler(
        IUserRepository userRepository,
        IPasswordHashService passwordHashService,
        IJwtTokenService jwtTokenService,
        IRefreshTokenService refreshTokenService,
        IUnitOfWork unitOfWork)
    {
        _userRepository = userRepository;
        _passwordHashService = passwordHashService;
        _jwtTokenService = jwtTokenService;
        _refreshTokenService = refreshTokenService;
        _unitOfWork = unitOfWork;
    }

    public async Task<AuthResponse> Handle(LoginCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetByEmailAsync(request.Email);
        if (user == null)
        {
            throw new Exception("INVALID_CREDENTIALS");
        }

        var isPasswordValid = _passwordHashService.VerifyPassword(user.PasswordHash, request.Password);
        if (!isPasswordValid)
        {
            throw new Exception("INVALID_CREDENTIALS");
        }

        var accessToken = _jwtTokenService.GenerateAccessToken(user);
        var refreshToken = await _refreshTokenService.GenerateRefreshTokenAsync(user.Id);
        
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return new AuthResponse
        {
            AccessToken = accessToken,
            RefreshToken = refreshToken.Token,
            ExpiresIn = _jwtTokenService.GetAccessTokenExpiresIn(),
            User = new UserSnippetDto
            {
                Id = user.Id.ToString(),
                Username = user.Username
            }
        };
    }
}
