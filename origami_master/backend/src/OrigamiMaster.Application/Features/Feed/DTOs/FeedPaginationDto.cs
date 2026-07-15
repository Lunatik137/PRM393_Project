using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Feed.DTOs;

public class FeedPaginationDto
{
    public IEnumerable<FeedPostDto> Items { get; set; } = new List<FeedPostDto>();
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public bool HasMore { get; set; }
}
