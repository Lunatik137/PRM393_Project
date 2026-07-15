using Microsoft.AspNetCore.Authorization;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Authorization;

public class FeedOwnerRequirement : IAuthorizationRequirement
{
}

public class FeedOwnerHandler : AuthorizationHandler<FeedOwnerRequirement, FeedPost>
{
    private readonly ICurrentUserService _currentUserService;

    public FeedOwnerHandler(ICurrentUserService currentUserService)
    {
        _currentUserService = currentUserService;
    }

    protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, FeedOwnerRequirement requirement, FeedPost resource)
    {
        var currentUserId = _currentUserService.GetUserId();

        if (resource.UserId == currentUserId)
        {
            context.Succeed(requirement);
        }

        return Task.CompletedTask;
    }
}
