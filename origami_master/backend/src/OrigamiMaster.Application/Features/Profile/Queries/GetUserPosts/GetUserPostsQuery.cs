using MediatR;
using OrigamiMaster.Application.Features.Profile.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Profile.Queries.GetUserPosts;

public class GetUserPostsQuery : IRequest<UserPostPaginationDto>
{
    public Guid UserId { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}
