namespace OrigamiMaster.Application.Features.Auth.DTOs;

public class AuthResponse
{
    public string AccessToken { get; set; } = string.Empty;
    public string RefreshToken { get; set; } = string.Empty;
    public int ExpiresIn { get; set; }
    public UserSnippetDto? User { get; set; }
}

public class UserSnippetDto
{
    public string Id { get; set; } = string.Empty;
    public string Username { get; set; } = string.Empty;
}
