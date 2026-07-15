using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetGalleryStatistics;

public class GetGalleryStatisticsQuery : IRequest<GalleryStatisticsDto>
{
}
