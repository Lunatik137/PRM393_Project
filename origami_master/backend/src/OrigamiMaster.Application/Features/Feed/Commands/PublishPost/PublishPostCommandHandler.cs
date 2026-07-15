using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Feed.Commands.PublishPost;

public class PublishPostCommandHandler : IRequestHandler<PublishPostCommand, Guid>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public PublishPostCommandHandler(
        IFeedPostRepository feedPostRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _feedPostRepository = feedPostRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task<Guid> Handle(PublishPostCommand request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();

        var feedPost = new FeedPost
        {
            Id = Guid.NewGuid(),
            UserId = currentUserId,
            ImageUrl = request.ImageUrl,
            Description = request.Description,
            Hashtags = request.Hashtags,
            PublishedAt = DateTime.UtcNow,
            LikeCount = 0,
            CommentCount = 0
        };

        await _feedPostRepository.AddAsync(feedPost);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return feedPost.Id;
    }
}
