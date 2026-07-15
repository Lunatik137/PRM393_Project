using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.ShareLinks.Queries.GetSharedCreation;

public class GetSharedCreationQueryHandler : IRequestHandler<GetSharedCreationQuery, SharedCreationDto>
{
    private readonly IShareLinkRepository _shareLinkRepository;
    private readonly ICreationRepository _creationRepository;
    private readonly IMapper _mapper;

    public GetSharedCreationQueryHandler(
        IShareLinkRepository shareLinkRepository,
        ICreationRepository creationRepository,
        IMapper mapper)
    {
        _shareLinkRepository = shareLinkRepository;
        _creationRepository = creationRepository;
        _mapper = mapper;
    }

    public async Task<SharedCreationDto> Handle(GetSharedCreationQuery request, CancellationToken cancellationToken)
    {
        var shareLink = await _shareLinkRepository.GetByTokenAsync(request.Token);
        if (shareLink == null)
            throw new Exception("INVALID_SHARE_TOKEN");

        if (!shareLink.IsActive)
            throw new Exception("INACTIVE_SHARE_LINK");

        var creation = await _creationRepository.GetWithUserAndModelAsync(shareLink.CreationId);
        if (creation == null)
            throw new Exception("CREATION_NOT_FOUND");

        return _mapper.Map<SharedCreationDto>(creation);
    }
}
