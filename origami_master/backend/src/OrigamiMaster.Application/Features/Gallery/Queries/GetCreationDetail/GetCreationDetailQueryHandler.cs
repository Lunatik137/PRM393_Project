using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetCreationDetail;

public class GetCreationDetailQueryHandler : IRequestHandler<GetCreationDetailQuery, GalleryDetailDto>
{
    private readonly ICreationRepository _creationRepository;
    private readonly IShareLinkRepository _shareLinkRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public GetCreationDetailQueryHandler(
        ICreationRepository creationRepository,
        IShareLinkRepository shareLinkRepository,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _creationRepository = creationRepository;
        _shareLinkRepository = shareLinkRepository;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<GalleryDetailDto> Handle(GetCreationDetailQuery request, CancellationToken cancellationToken)
    {
        var creation = await _creationRepository.GetWithUserAndModelAsync(request.CreationId);

        if (creation == null)
            throw new Exception("CREATION_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (creation.UserId != currentUserId)
            throw new Exception("GALLERY_ACCESS_DENIED");

        var dto = _mapper.Map<GalleryDetailDto>(creation);

        // Fetch existing share link for this creation (1 per creation)
        var shareLinks = await _shareLinkRepository.GetByCreationIdAsync(request.CreationId);
        var shareLink = shareLinks.FirstOrDefault();
        if (shareLink != null)
        {
            dto.ShareLinkId = shareLink.Id;
            dto.ShareToken = shareLink.Token;
            dto.ShareIsActive = shareLink.IsActive;
        }

        return dto;
    }
}
