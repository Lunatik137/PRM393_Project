using MediatR;
using OrigamiMaster.Application.Features.Follows.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Follows.Queries.GetFollowStatus;

public class GetFollowStatusQueryHandler : IRequestHandler<GetFollowStatusQuery, FollowStatusDto>
{
    private readonly IFollowRepository _followRepository;
    private readonly IUserRepository _userRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetFollowStatusQueryHandler(
        IFollowRepository followRepository,
        IUserRepository userRepository,
        ICurrentUserService currentUserService)
    {
        _followRepository = followRepository;
        _userRepository = userRepository;
        _currentUserService = currentUserService;
    }

    public async Task<FollowStatusDto> Handle(GetFollowStatusQuery request, CancellationToken cancellationToken)
    {
        var exists = await _userRepository.ExistsAsync(request.TargetUserId);
        if (!exists)
            throw new System.Exception("USER_NOT_FOUND");

        var dto = new FollowStatusDto
        {
            UserId = request.TargetUserId,
            FollowersCount = await _followRepository.GetFollowersCountAsync(request.TargetUserId),
            FollowingCount = await _followRepository.GetFollowingCountAsync(request.TargetUserId)
        };

        if (_currentUserService.IsAuthenticated())
        {
            var currentUserId = _currentUserService.GetUserId();
            dto.IsFollowing = await _followRepository.IsFollowingAsync(currentUserId, request.TargetUserId);
        }

        return dto;
    }
}
