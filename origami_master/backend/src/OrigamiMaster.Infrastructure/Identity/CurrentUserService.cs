using Microsoft.AspNetCore.Http;
using OrigamiMaster.Application.Interfaces;
using System;
using System.Security.Claims;

namespace OrigamiMaster.Infrastructure.Identity;

public class CurrentUserService : ICurrentUserService
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public CurrentUserService(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public Guid GetUserId()
    {
        var idStr = _httpContextAccessor.HttpContext?.User?.FindFirstValue(ClaimTypes.NameIdentifier);
        if (string.IsNullOrEmpty(idStr)) return Guid.Empty;
        return Guid.TryParse(idStr, out var id) ? id : Guid.Empty;
    }

    public string GetEmail()
    {
        return _httpContextAccessor.HttpContext?.User?.FindFirstValue(ClaimTypes.Email) ?? string.Empty;
    }

    public string GetUsername()
    {
        return _httpContextAccessor.HttpContext?.User?.FindFirstValue("username") ?? string.Empty;
    }

    public bool IsAuthenticated()
    {
        return _httpContextAccessor.HttpContext?.User?.Identity?.IsAuthenticated ?? false;
    }
}
