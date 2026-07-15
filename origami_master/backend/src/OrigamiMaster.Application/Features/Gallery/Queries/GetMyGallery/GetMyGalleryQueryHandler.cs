using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Enums;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetMyGallery;

public class GetMyGalleryQueryHandler : IRequestHandler<GetMyGalleryQuery, GalleryPaginationDto>
{
    private readonly ICreationRepository _creationRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public GetMyGalleryQueryHandler(
        ICreationRepository creationRepository,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _creationRepository = creationRepository;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<GalleryPaginationDto> Handle(GetMyGalleryQuery request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();

        CreationVisibility? visibilityFilter = null;
        if (!string.IsNullOrEmpty(request.Visibility))
        {
            if (Enum.TryParse<CreationVisibility>(request.Visibility, out var parsed))
            {
                visibilityFilter = parsed;
            }
        }

        var pageSize = request.PageSize > 50 ? 50 : request.PageSize;

        var creations = await _creationRepository.GetByUserIdAsync(currentUserId, request.PageNumber, pageSize, visibilityFilter);

        var dtos = _mapper.Map<List<GalleryItemDto>>(creations);

        return new GalleryPaginationDto
        {
            Items = dtos,
            PageNumber = request.PageNumber,
            PageSize = pageSize,
            HasMore = creations.Count == pageSize
        };
    }
}
