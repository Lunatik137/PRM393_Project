using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Comments.DTOs;

public class CommentPaginationDto
{
    public IEnumerable<CommentDto> Items { get; set; } = new List<CommentDto>();
    public int PageNumber { get; set; }
    public int PageSize { get; set; }
    public bool HasMore { get; set; }
}
