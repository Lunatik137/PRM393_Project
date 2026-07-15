using MediatR;

namespace OrigamiMaster.Application.Features.Profile.Commands.UpdateProfile;

public class UpdateProfileCommand : IRequest
{
    public string Username { get; set; } = string.Empty;
    public string? Bio { get; set; }
    public string? AvatarUrl { get; set; }
}
