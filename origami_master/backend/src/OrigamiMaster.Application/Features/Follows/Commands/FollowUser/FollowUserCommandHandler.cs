using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Follows.Commands.FollowUser;

public class FollowUserCommandHandler : IRequestHandler<FollowUserCommand>
{
    private readonly IUserRepository _userRepository;
    private readonly IFollowRepository _followRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public FollowUserCommandHandler(
        IUserRepository userRepository,
        IFollowRepository followRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _userRepository = userRepository;
        _followRepository = followRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(FollowUserCommand request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();

        if (currentUserId == request.TargetUserId)
        {
            throw new Exception("CANNOT_FOLLOW_SELF");
        }

        var exists = await _userRepository.ExistsAsync(request.TargetUserId);
        if (!exists)
        {
            throw new Exception("USER_NOT_FOUND");
        }

        var isFollowing = await _followRepository.IsFollowingAsync(currentUserId, request.TargetUserId);
        if (isFollowing)
        {
            throw new Exception("ALREADY_FOLLOWING");
        }

        var follow = new Follow(currentUserId, request.TargetUserId)
        {
            Id = Guid.NewGuid()
        };

        await _followRepository.AddAsync(follow);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
