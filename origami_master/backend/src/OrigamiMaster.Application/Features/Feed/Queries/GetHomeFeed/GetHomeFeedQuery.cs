using MediatR;
using OrigamiMaster.Application.Features.Feed.DTOs;

namespace OrigamiMaster.Application.Features.Feed.Queries.GetHomeFeed;

public class GetHomeFeedQuery : IRequest<FeedPaginationDto>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}
