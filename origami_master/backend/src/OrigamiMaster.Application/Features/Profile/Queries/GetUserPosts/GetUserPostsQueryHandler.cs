using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Profile.DTOs;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Profile.Queries.GetUserPosts;

public class GetUserPostsQueryHandler : IRequestHandler<GetUserPostsQuery, UserPostPaginationDto>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly IUserRepository _userRepository;
    private readonly IMapper _mapper;

    public GetUserPostsQueryHandler(
        IFeedPostRepository feedPostRepository,
        IUserRepository userRepository,
        IMapper mapper)
    {
        _feedPostRepository = feedPostRepository;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<UserPostPaginationDto> Handle(GetUserPostsQuery request, CancellationToken cancellationToken)
    {
        var exists = await _userRepository.ExistsAsync(request.UserId);
        if (!exists)
            throw new System.Exception("USER_NOT_FOUND");

        var pageSize = request.PageSize > 50 ? 50 : request.PageSize;

        var posts = await _feedPostRepository.GetUserPostsAsync(request.UserId, request.PageNumber, pageSize);
        var dtos = _mapper.Map<List<UserPostDto>>(posts);

        return new UserPostPaginationDto
        {
            Items = dtos,
            PageNumber = request.PageNumber,
            PageSize = pageSize,
            HasMore = posts.Count == pageSize
        };
    }
}
