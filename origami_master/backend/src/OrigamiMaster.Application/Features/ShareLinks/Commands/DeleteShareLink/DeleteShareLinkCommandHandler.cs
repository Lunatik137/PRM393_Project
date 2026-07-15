using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.ShareLinks.Commands.DeleteShareLink;

public class DeleteShareLinkCommandHandler : IRequestHandler<DeleteShareLinkCommand>
{
    private readonly IShareLinkRepository _shareLinkRepository;
    private readonly ICreationRepository _creationRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public DeleteShareLinkCommandHandler(
        IShareLinkRepository shareLinkRepository,
        ICreationRepository creationRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _shareLinkRepository = shareLinkRepository;
        _creationRepository = creationRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(DeleteShareLinkCommand request, CancellationToken cancellationToken)
    {
        var shareLink = await _shareLinkRepository.GetByIdAsync(request.ShareLinkId);
        if (shareLink == null)
            throw new Exception("SHARE_LINK_NOT_FOUND");

        var creation = await _creationRepository.GetByIdAsync(shareLink.CreationId);
        if (creation == null)
            throw new Exception("CREATION_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (creation.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        shareLink.Disable();

        await _shareLinkRepository.UpdateAsync(shareLink);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
