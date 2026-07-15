using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using Google.Apis.Auth;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Auth.Commands.GoogleLogin;

public class GoogleLoginCommandHandler : IRequestHandler<GoogleLoginCommand, AuthResponse>
{
    private readonly IUserRepository _userRepository;
    private readonly IJwtTokenService _jwtTokenService;
    private readonly IRefreshTokenService _refreshTokenService;
    private readonly IUnitOfWork _unitOfWork;

    public GoogleLoginCommandHandler(
        IUserRepository userRepository,
        IJwtTokenService jwtTokenService,
        IRefreshTokenService refreshTokenService,
        IUnitOfWork unitOfWork)
    {
        _userRepository = userRepository;
        _jwtTokenService = jwtTokenService;
        _refreshTokenService = refreshTokenService;
        _unitOfWork = unitOfWork;
    }

    public async Task<AuthResponse> Handle(GoogleLoginCommand request, CancellationToken cancellationToken)
    {
        GoogleJsonWebSignature.Payload payload;
        try
        {
            var settings = new GoogleJsonWebSignature.ValidationSettings
            {
                Audience = new[] { "698858502953-msvek08mbvneb6dd3nhd01q3m6k1hjg1.apps.googleusercontent.com" },
                IssuedAtClockTolerance = TimeSpan.FromMinutes(5)
            };
            payload = await GoogleJsonWebSignature.ValidateAsync(request.IdToken, settings);
        }
        catch (InvalidJwtException ex)
        {
            Console.WriteLine($"[GoogleLogin] Invalid JWT Exception: {ex.Message}");
            throw new Exception($"INVALID_GOOGLE_TOKEN: {ex.Message}");
        }

        var email = payload.Email;
        var user = await _userRepository.GetByEmailAsync(email);

        if (user == null)
        {
            // Create a new user implicitly
            user = new User
            {
                Email = email,
                Username = payload.Name ?? email.Split('@')[0],
                AvatarUrl = payload.Picture,
                GoogleId = payload.Subject,
                PasswordHash = "", // OAuth users don't have a local password
                IsActive = true,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow
            };
            
            await _userRepository.AddAsync(user);
        }
        else if (user.GoogleId == null)
        {
            // Link account if it was created locally but the email matches
            user.GoogleId = payload.Subject;
            if (string.IsNullOrEmpty(user.AvatarUrl))
            {
                user.AvatarUrl = payload.Picture;
            }
            await _userRepository.UpdateAsync(user);
        }

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        var accessToken = _jwtTokenService.GenerateAccessToken(user);
        var refreshToken = await _refreshTokenService.GenerateRefreshTokenAsync(user.Id);

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
