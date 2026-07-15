using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Auth.Commands.Register;

public class RegisterCommand : IRequest<Guid>
{
    public string Email { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}
