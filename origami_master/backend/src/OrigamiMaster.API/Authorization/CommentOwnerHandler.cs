using Microsoft.AspNetCore.Authorization;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Authorization;

public class CommentOwnerRequirement : IAuthorizationRequirement
{
}

public class CommentOwnerHandler : AuthorizationHandler<CommentOwnerRequirement, Comment>
{
    private readonly ICurrentUserService _currentUserService;

    public CommentOwnerHandler(ICurrentUserService currentUserService)
    {
        _currentUserService = currentUserService;
    }

    protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, CommentOwnerRequirement requirement, Comment resource)
    {
        var currentUserId = _currentUserService.GetUserId();

        if (resource.UserId == currentUserId)
        {
            context.Succeed(requirement);
        }

        return Task.CompletedTask;
    }
}
