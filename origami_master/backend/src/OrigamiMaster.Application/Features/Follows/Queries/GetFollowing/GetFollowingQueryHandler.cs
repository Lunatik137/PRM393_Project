using MediatR;
using OrigamiMaster.Application.Features.Follows.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Follows.Queries.GetFollowing;

public class GetFollowingQueryHandler : IRequestHandler<GetFollowingQuery, PagedFollowUserListDto>
{
    private readonly IFollowRepository _followRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetFollowingQueryHandler(IFollowRepository followRepository, ICurrentUserService currentUserService)
    {
        _followRepository = followRepository;
        _currentUserService = currentUserService;
    }

    public async Task<PagedFollowUserListDto> Handle(GetFollowingQuery request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();
        var following = (await _followRepository.GetFollowingAsync(request.UserId)).ToList();

        var total = following.Count;
        var paged = following
            .Skip((request.Page - 1) * request.PageSize)
            .Take(request.PageSize)
            .ToList();

        // For each followed user, check if current user is following them
        var followingIds = currentUserId != System.Guid.Empty
            ? await _followRepository.GetFollowingIdsAsync(currentUserId)
            : new System.Collections.Generic.List<System.Guid>();

        var items = paged.Select(f => new FollowUserListDto
        {
            Id = f.FollowingUserId.ToString(),
            Username = f.FollowingUser?.Username ?? string.Empty,
            AvatarUrl = f.FollowingUser?.AvatarUrl,
            Bio = null,
            FollowersCount = 0,
            FollowingCount = 0,
            IsFollowing = followingIds.Contains(f.FollowingUserId),
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
