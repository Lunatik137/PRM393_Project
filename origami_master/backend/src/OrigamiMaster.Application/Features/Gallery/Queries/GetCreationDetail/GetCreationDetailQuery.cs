using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetCreationDetail;

public class GetCreationDetailQuery : IRequest<GalleryDetailDto>
{
    public Guid CreationId { get; set; }
}
