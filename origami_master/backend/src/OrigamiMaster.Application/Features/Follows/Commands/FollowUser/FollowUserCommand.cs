using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Follows.Commands.FollowUser;

public class FollowUserCommand : IRequest
{
    public Guid TargetUserId { get; set; }
}
