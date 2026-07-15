using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Follows.Commands.UnfollowUser;

public class UnfollowUserCommandHandler : IRequestHandler<UnfollowUserCommand>
{
    private readonly IFollowRepository _followRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public UnfollowUserCommandHandler(
        IFollowRepository followRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _followRepository = followRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(UnfollowUserCommand request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();

        var follow = await _followRepository.GetFollowAsync(currentUserId, request.TargetUserId);
        if (follow == null)
        {
            throw new Exception("FOLLOW_RELATIONSHIP_NOT_FOUND");
        }

        await _followRepository.DeleteAsync(follow);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
