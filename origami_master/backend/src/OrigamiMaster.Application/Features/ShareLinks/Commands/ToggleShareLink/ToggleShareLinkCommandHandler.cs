using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.ShareLinks.Commands.ToggleShareLink;

public class ToggleShareLinkCommandHandler : IRequestHandler<ToggleShareLinkCommand>
{
    private readonly IShareLinkRepository _shareLinkRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public ToggleShareLinkCommandHandler(
        IShareLinkRepository shareLinkRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _shareLinkRepository = shareLinkRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(ToggleShareLinkCommand request, CancellationToken cancellationToken)
    {
        var shareLink = await _shareLinkRepository.GetByIdForUpdateAsync(request.ShareLinkId);
        if (shareLink == null)
            throw new Exception("SHARE_LINK_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (shareLink.Creation?.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        shareLink.Toggle();
        await _shareLinkRepository.UpdateAsync(shareLink);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
