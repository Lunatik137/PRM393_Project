using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Follows.Commands.UnfollowUser;

public class UnfollowUserCommand : IRequest
{
    public Guid TargetUserId { get; set; }
}
