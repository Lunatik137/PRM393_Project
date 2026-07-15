using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Comments.Commands.CreateComment;

public class CreateCommentCommandHandler : IRequestHandler<CreateCommentCommand, Guid>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly ICommentRepository _commentRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public CreateCommentCommandHandler(
        IFeedPostRepository feedPostRepository,
        ICommentRepository commentRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _feedPostRepository = feedPostRepository;
        _commentRepository = commentRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task<Guid> Handle(CreateCommentCommand request, CancellationToken cancellationToken)
    {
        var post = await _feedPostRepository.GetByIdAsync(request.PostId);
        if (post == null)
            throw new Exception("FEED_POST_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();

        var comment = new Comment(request.PostId, currentUserId, request.Content)
        {
            Id = Guid.NewGuid()
        };

        await _commentRepository.AddAsync(comment);

        post.IncreaseCommentCount();
        await _feedPostRepository.UpdateAsync(post);

        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return comment.Id;
    }
}
