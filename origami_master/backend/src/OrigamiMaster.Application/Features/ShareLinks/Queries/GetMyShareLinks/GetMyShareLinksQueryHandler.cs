using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.ShareLinks.Queries.GetMyShareLinks;

public class GetMyShareLinksQueryHandler : IRequestHandler<GetMyShareLinksQuery, List<ShareLinkDto>>
{
    private readonly IShareLinkRepository _shareLinkRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public GetMyShareLinksQueryHandler(
        IShareLinkRepository shareLinkRepository,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _shareLinkRepository = shareLinkRepository;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<List<ShareLinkDto>> Handle(GetMyShareLinksQuery request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();

        var links = await _shareLinkRepository.GetByUserIdAsync(currentUserId);
        return _mapper.Map<List<ShareLinkDto>>(links);
    }
}
