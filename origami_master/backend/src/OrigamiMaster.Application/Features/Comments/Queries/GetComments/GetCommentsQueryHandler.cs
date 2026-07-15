using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Comments.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Comments.Queries.GetComments;

public class GetCommentsQueryHandler : IRequestHandler<GetCommentsQuery, CommentPaginationDto>
{
    private readonly ICommentRepository _commentRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;

    public GetCommentsQueryHandler(
        ICommentRepository commentRepository,
        ICurrentUserService currentUserService,
        IMapper mapper)
    {
        _commentRepository = commentRepository;
        _currentUserService = currentUserService;
        _mapper = mapper;
    }

    public async Task<CommentPaginationDto> Handle(GetCommentsQuery request, CancellationToken cancellationToken)
    {
        var pageSize = request.PageSize > 50 ? 50 : request.PageSize;

        var comments = await _commentRepository.GetByPostIdAsync(request.PostId, request.PageNumber, pageSize);
        var dtos = _mapper.Map<List<CommentDto>>(comments);

        var isAuthenticated = _currentUserService.IsAuthenticated();
        var currentUserId = isAuthenticated ? _currentUserService.GetUserId() : (System.Guid?)null;

        foreach (var dto in dtos)
        {
            var comment = comments.First(c => c.Id == dto.Id);
            dto.IsOwner = isAuthenticated && currentUserId == comment.UserId;
        }

        return new CommentPaginationDto
        {
            Items = dtos,
            PageNumber = request.PageNumber,
            PageSize = pageSize,
            HasMore = comments.Count == pageSize
        };
    }
}
