using MediatR;
using OrigamiMaster.Application.Features.Follows.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Follows.Queries.GetFollowStatus;

public class GetFollowStatusQuery : IRequest<FollowStatusDto>
{
    public Guid TargetUserId { get; set; }
}
