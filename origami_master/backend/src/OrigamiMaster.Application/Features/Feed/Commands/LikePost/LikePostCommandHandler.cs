using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Feed.Commands.LikePost;

public class LikePostCommandHandler : IRequestHandler<LikePostCommand, Unit>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly ILikeRepository _likeRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public LikePostCommandHandler(
        IFeedPostRepository feedPostRepository,
        ILikeRepository likeRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _feedPostRepository = feedPostRepository;
        _likeRepository = likeRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task<Unit> Handle(LikePostCommand request, CancellationToken cancellationToken)
    {
        var post = await _feedPostRepository.GetByIdAsync(request.PostId);
        if (post == null)
            throw new Exception("FEED_POST_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        var existingLike = await _likeRepository.GetByUserAndPostAsync(currentUserId, request.PostId);

        if (existingLike == null)
        {
            var like = new Like
            {
                Id = Guid.NewGuid(),
                FeedPostId = request.PostId,
                UserId = currentUserId,
                CreatedAt = DateTime.UtcNow
            };

            await _likeRepository.AddAsync(like);

            post.IncreaseLikeCount();
            await _feedPostRepository.UpdateAsync(post);

            await _unitOfWork.SaveChangesAsync(cancellationToken);
        }

        return Unit.Value;
    }
}
