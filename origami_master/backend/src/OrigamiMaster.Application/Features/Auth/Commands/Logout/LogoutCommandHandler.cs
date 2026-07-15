using MediatR;
using OrigamiMaster.Application.Interfaces;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Auth.Commands.Logout;

public class LogoutCommandHandler : IRequestHandler<LogoutCommand>
{
    private readonly IRefreshTokenService _refreshTokenService;
    private readonly IUnitOfWork _unitOfWork;

    public LogoutCommandHandler(IRefreshTokenService refreshTokenService, IUnitOfWork unitOfWork)
    {
        _refreshTokenService = refreshTokenService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(LogoutCommand request, CancellationToken cancellationToken)
    {
        var token = await _refreshTokenService.GetByTokenAsync(request.RefreshToken);
        if (token != null && !token.IsRevoked)
        {
            await _refreshTokenService.RevokeTokenAsync(token);
            await _unitOfWork.SaveChangesAsync(cancellationToken);
        }
    }
}
