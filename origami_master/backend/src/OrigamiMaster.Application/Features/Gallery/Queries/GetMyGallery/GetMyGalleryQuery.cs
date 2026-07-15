using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetMyGallery;

public class GetMyGalleryQuery : IRequest<GalleryPaginationDto>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
    public string? Visibility { get; set; }
}
