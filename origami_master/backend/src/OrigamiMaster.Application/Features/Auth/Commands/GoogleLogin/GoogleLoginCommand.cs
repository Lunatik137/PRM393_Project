using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;

namespace OrigamiMaster.Application.Features.Auth.Commands.GoogleLogin;

public class GoogleLoginCommand : IRequest<AuthResponse>
{
    public string IdToken { get; set; } = string.Empty;
}
