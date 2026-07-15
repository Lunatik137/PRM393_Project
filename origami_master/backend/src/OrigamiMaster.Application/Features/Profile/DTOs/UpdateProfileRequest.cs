namespace OrigamiMaster.Application.Features.Profile.DTOs;

public class UpdateProfileRequest
{
    public string Username { get; set; } = string.Empty;
    public string? Bio { get; set; }
    public string? AvatarUrl { get; set; }
}
