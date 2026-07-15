using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;

namespace OrigamiMaster.Application.Features.Auth.Commands.Refresh;

public class RefreshTokenCommand : IRequest<AuthResponse>
{
    public string Token { get; set; } = string.Empty;
}
