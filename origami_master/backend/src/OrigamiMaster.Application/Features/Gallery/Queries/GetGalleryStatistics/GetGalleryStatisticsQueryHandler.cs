using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetGalleryStatistics;

public class GetGalleryStatisticsQueryHandler : IRequestHandler<GetGalleryStatisticsQuery, GalleryStatisticsDto>
{
    private readonly ICreationRepository _creationRepository;
    private readonly ICurrentUserService _currentUserService;

    public GetGalleryStatisticsQueryHandler(
        ICreationRepository creationRepository,
        ICurrentUserService currentUserService)
    {
        _creationRepository = creationRepository;
        _currentUserService = currentUserService;
    }

    public async Task<GalleryStatisticsDto> Handle(GetGalleryStatisticsQuery request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();

        return new GalleryStatisticsDto
        {
            TotalCreations = await _creationRepository.CountByUserIdAsync(currentUserId),
            PublicCreations = await _creationRepository.GetPublicCreationCountAsync(currentUserId),
            PrivateCreations = await _creationRepository.CountPrivateAsync(currentUserId),
            PublishedCreations = await _creationRepository.CountPublishedAsync(currentUserId)
        };
    }
}
