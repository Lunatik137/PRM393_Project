using Microsoft.AspNetCore.Authorization;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Application.Interfaces;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Authorization;

public class CreationOwnerHandler : AuthorizationHandler<CreationOwnerRequirement, Creation>
{
    private readonly ICurrentUserService _currentUserService;

    public CreationOwnerHandler(ICurrentUserService currentUserService)
    {
        _currentUserService = currentUserService;
    }

    protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, CreationOwnerRequirement requirement, Creation resource)
    {
        var currentUserId = _currentUserService.GetUserId();

        if (resource.UserId == currentUserId)
        {
            context.Succeed(requirement);
        }

        return Task.CompletedTask;
    }
}
