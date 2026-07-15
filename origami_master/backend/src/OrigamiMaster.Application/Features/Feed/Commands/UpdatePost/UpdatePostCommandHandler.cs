using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Feed.Commands.UpdatePost;

public class UpdatePostCommandHandler : IRequestHandler<UpdatePostCommand, Unit>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public UpdatePostCommandHandler(
        IFeedPostRepository feedPostRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _feedPostRepository = feedPostRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task<Unit> Handle(UpdatePostCommand request, CancellationToken cancellationToken)
    {
        var post = await _feedPostRepository.GetByIdAsync(request.Id);
        
        if (post == null)
            throw new Exception("FEED_POST_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (post.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        post.Description = request.Description;
        if (request.Hashtags != null)
        {
            post.Hashtags = request.Hashtags;
        }

        await _feedPostRepository.UpdateAsync(post);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return Unit.Value;
    }
}
