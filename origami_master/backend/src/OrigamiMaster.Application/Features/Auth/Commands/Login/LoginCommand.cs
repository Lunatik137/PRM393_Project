using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;

namespace OrigamiMaster.Application.Features.Auth.Commands.Login;

public class LoginCommand : IRequest<AuthResponse>
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}
