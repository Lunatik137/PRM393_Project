using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Feed.DTOs;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Application.Interfaces;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Feed.Queries.GetFeedPost;

public class GetFeedPostQueryHandler : IRequestHandler<GetFeedPostQuery, FeedPostDto>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly IMapper _mapper;
    private readonly ICurrentUserService _currentUserService;
    private readonly ILikeRepository _likeRepository;
    private readonly IFollowRepository _followRepository;

    public GetFeedPostQueryHandler(
        IFeedPostRepository feedPostRepository, 
        IMapper mapper,
        ICurrentUserService currentUserService,
        ILikeRepository likeRepository,
        IFollowRepository followRepository)
    {
        _feedPostRepository = feedPostRepository;
        _mapper = mapper;
        _currentUserService = currentUserService;
        _likeRepository = likeRepository;
        _followRepository = followRepository;
    }

    public async Task<FeedPostDto> Handle(GetFeedPostQuery request, CancellationToken cancellationToken)
    {
        var post = await _feedPostRepository.GetByIdAsync(request.Id);
        if (post == null)
            throw new Exception("FEED_POST_NOT_FOUND");

        var dto = _mapper.Map<FeedPostDto>(post);

        var currentUserId = _currentUserService.IsAuthenticated() ? _currentUserService.GetUserId() : (Guid?)null;
        if (currentUserId.HasValue)
        {
            var like = await _likeRepository.GetByUserAndPostAsync(currentUserId.Value, post.Id);
            dto.IsLiked = like != null;
            dto.IsFollowingAuthor = await _followRepository.IsFollowingAsync(currentUserId.Value, post.UserId);
        }

        return dto;
    }
}
