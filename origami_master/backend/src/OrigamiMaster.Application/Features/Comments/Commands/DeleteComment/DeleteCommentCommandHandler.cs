using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Comments.Commands.DeleteComment;

public class DeleteCommentCommandHandler : IRequestHandler<DeleteCommentCommand>
{
    private readonly ICommentRepository _commentRepository;
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public DeleteCommentCommandHandler(
        ICommentRepository commentRepository,
        IFeedPostRepository feedPostRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _commentRepository = commentRepository;
        _feedPostRepository = feedPostRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(DeleteCommentCommand request, CancellationToken cancellationToken)
    {
        var comment = await _commentRepository.GetByIdAsync(request.CommentId);
        if (comment == null)
            throw new Exception("COMMENT_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (comment.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        await _commentRepository.DeleteAsync(comment);

        var post = await _feedPostRepository.GetByIdAsync(comment.FeedPostId);
        if (post != null)
        {
            post.DecreaseCommentCount();
            await _feedPostRepository.UpdateAsync(post);
        }

        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
