using MediatR;
using OrigamiMaster.Application.Features.Comments.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Comments.Queries.GetComments;

public class GetCommentsQuery : IRequest<CommentPaginationDto>
{
    public Guid PostId { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}
