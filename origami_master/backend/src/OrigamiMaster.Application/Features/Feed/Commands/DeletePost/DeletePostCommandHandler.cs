using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Feed.Commands.DeletePost;

public class DeletePostCommandHandler : IRequestHandler<DeletePostCommand>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public DeletePostCommandHandler(
        IFeedPostRepository feedPostRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _feedPostRepository = feedPostRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(DeletePostCommand request, CancellationToken cancellationToken)
    {
        var post = await _feedPostRepository.GetByIdAsync(request.Id);
        if (post == null)
            throw new Exception("FEED_POST_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (post.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        await _feedPostRepository.DeleteAsync(post);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
