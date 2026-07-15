using MediatR;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using OrigamiMaster.Domain.Repositories;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Queries.GetMyPostsGallery;

public class GetMyPostsGalleryQueryHandler : IRequestHandler<GetMyPostsGalleryQuery, GalleryPaginationDto>
{
    private readonly IFeedPostRepository _feedPostRepository;

    public GetMyPostsGalleryQueryHandler(IFeedPostRepository feedPostRepository)
    {
        _feedPostRepository = feedPostRepository;
    }

    public async Task<GalleryPaginationDto> Handle(GetMyPostsGalleryQuery request, CancellationToken cancellationToken)
    {
        var posts = await _feedPostRepository.GetUserPostsAsync(request.UserId, request.PageNumber, request.PageSize);
        var totalCount = await _feedPostRepository.CountByUserIdAsync(request.UserId);

        var dtos = posts.Select(p => new GalleryItemDto
        {
            Id = p.Id,
            OrigamiModelId = null,
            ImageUrl = p.ImageUrl ?? string.Empty,
            OrigamiModelName = string.Empty,
            Difficulty = string.Empty,
            Visibility = "Public",
            IsPublished = true,
            Caption = p.Description,
            Hashtags = p.Hashtags,
            CreatedAt = p.PublishedAt,
            CreatorId = p.UserId,
            CreatorName = p.User?.Username ?? string.Empty,
            CreatorAvatar = p.User?.AvatarUrl
        }).ToList();

        return new GalleryPaginationDto
        {
            Items = dtos,
            PageNumber = request.PageNumber,
            PageSize = request.PageSize,
            HasMore = (request.PageNumber * request.PageSize) < totalCount
        };
    }
}
