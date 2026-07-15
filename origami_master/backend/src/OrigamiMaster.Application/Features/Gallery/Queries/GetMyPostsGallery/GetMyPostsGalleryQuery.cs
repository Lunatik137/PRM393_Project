using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetMyPostsGallery;

public class GetMyPostsGalleryQuery : IRequest<GalleryPaginationDto>
{
    public Guid UserId { get; set; }
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
}
