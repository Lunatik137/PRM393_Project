using MediatR;
using OrigamiMaster.Application.Features.Follows.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Follows.Queries.GetFollowers;

public class GetFollowersQuery : IRequest<PagedFollowUserListDto>
{
    public Guid UserId { get; set; }
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}
