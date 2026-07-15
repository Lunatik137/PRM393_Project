using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Commands.DeleteCreation;

public class DeleteCreationCommandHandler : IRequestHandler<DeleteCreationCommand>
{
    private readonly ICreationRepository _creationRepository;
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly IShareLinkRepository _shareLinkRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public DeleteCreationCommandHandler(
        ICreationRepository creationRepository,
        IFeedPostRepository feedPostRepository,
        IShareLinkRepository shareLinkRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _creationRepository = creationRepository;
        _feedPostRepository = feedPostRepository;
        _shareLinkRepository = shareLinkRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(DeleteCreationCommand request, CancellationToken cancellationToken)
    {
        var creation = await _creationRepository.GetByIdAsync(request.CreationId);
        if (creation == null)
            throw new Exception("CREATION_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (creation.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        if (creation.IsPublished)
        {
            var feedPost = await _feedPostRepository.GetByCreationIdAsync(creation.Id);
            if (feedPost != null)
            {
                await _feedPostRepository.DeleteAsync(feedPost);
            }
        }

        var shareLinks = await _shareLinkRepository.GetByCreationIdAsync(creation.Id);
        foreach (var link in shareLinks)
        {
            await _shareLinkRepository.DeleteAsync(link);
        }

        await _creationRepository.DeleteAsync(creation);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
