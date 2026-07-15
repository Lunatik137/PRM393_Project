using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Auth.Queries.GetCurrentUser;

public class GetCurrentUserQueryHandler : IRequestHandler<GetCurrentUserQuery, CurrentUserDto>
{
    private readonly ICurrentUserService _currentUserService;
    private readonly IUserRepository _userRepository;
    private readonly IFollowRepository _followRepository;

    public GetCurrentUserQueryHandler(
        ICurrentUserService currentUserService,
        IUserRepository userRepository,
        IFollowRepository followRepository)
    {
        _currentUserService = currentUserService;
        _userRepository = userRepository;
        _followRepository = followRepository;
    }

    public async Task<CurrentUserDto> Handle(GetCurrentUserQuery request, CancellationToken cancellationToken)
    {
        var userId = _currentUserService.GetUserId();
        var user = await _userRepository.GetByIdAsync(userId);
        
        if (user == null)
            throw new Exception("USER_NOT_FOUND");
            
        var followers = await _followRepository.GetFollowersAsync(userId);
        var following = await _followRepository.GetFollowingAsync(userId);

        return new CurrentUserDto
        {
            Id = user.Id,
            Email = user.Email,
            Username = user.Username,
            AvatarUrl = user.AvatarUrl,
            FollowersCount = followers.Count(),
            FollowingCount = following.Count()
        };
    }
}
