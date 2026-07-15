using MediatR;
using OrigamiMaster.Application.Features.Follows.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Follows.Queries.GetFollowers;

public class GetFollowersQueryHandler : IRequestHandler<GetFollowersQuery, PagedFollowUserListDto>
{
    private readonly IFollowRepository _followRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetFollowersQueryHandler(IFollowRepository followRepository, ICurrentUserService currentUserService)
    {
        _followRepository = followRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedFollowUserListDto> Handle(GetFollowersQuery request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();
        var followers = (await _followRepository.GetFollowersAsync(request.UserId)).ToList();

        var total = followers.Count;
        var paged = followers
            .Skip((request.Page - 1) * request.PageSize)
            .Take(request.PageSize)
            .ToList();

        // For each follower, check if current user is following them
        var followingIds = currentUserId != System.Guid.Empty
            ? await _followRepository.GetFollowingIdsAsync(currentUserId)
            : new System.Collections.Generic.List<System.Guid>();

        var items = paged.Select(f => new FollowUserListDto
        {
            Id = f.FollowerUserId.ToString(),
            Username = f.FollowerUser?.Username ?? string.Empty,
            AvatarUrl = f.FollowerUser?.AvatarUrl,
            Bio = null,
            FollowersCount = 0,
            FollowingCount = 0,
            IsFollowing = followingIds.Contains(f.FollowerUserId),
        }).ToList();

        return new PagedFollowUserListDto
        {
            Items = items,
            PageNumber = request.Page,
            PageSize = request.PageSize,
            HasMore = (request.Page * request.PageSize) < total,
        };
    }
}
