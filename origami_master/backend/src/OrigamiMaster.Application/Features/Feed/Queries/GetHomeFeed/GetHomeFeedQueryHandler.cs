using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.Feed.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Feed.Queries.GetHomeFeed;

public class GetHomeFeedQueryHandler : IRequestHandler<GetHomeFeedQuery, FeedPaginationDto>
{
    private readonly IFeedPostRepository _feedPostRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IMapper _mapper;
    private readonly ILikeRepository _likeRepository;
    private readonly IFollowRepository _followRepository;

    public GetHomeFeedQueryHandler(
        IFeedPostRepository feedPostRepository,
        ICurrentUserService currentUserService,
        IMapper mapper,
        ILikeRepository likeRepository,
        IFollowRepository followRepository)
    {
        _feedPostRepository = feedPostRepository;
        _currentUserService = currentUserService;
        _mapper = mapper;
        _likeRepository = likeRepository;
        _followRepository = followRepository;
    }

    public async Task<FeedPaginationDto> Handle(GetHomeFeedQuery request, CancellationToken cancellationToken)
    {
        var pageSize = request.PageSize > 50 ? 50 : request.PageSize;
        
        var currentUserId = _currentUserService.IsAuthenticated() ? _currentUserService.GetUserId() : (System.Guid?)null;

        var posts = await _feedPostRepository.GetHomeFeedAsync(currentUserId, request.PageNumber, pageSize);

        var dtos = _mapper.Map<List<FeedPostDto>>(posts);

        if (currentUserId.HasValue && posts.Any())
        {
            var postIds = posts.Select(p => p.Id).ToList();
            var likedPostIds = await _likeRepository.GetLikedPostIdsAsync(currentUserId.Value, postIds);
            var authorIds = posts.Select(p => p.UserId).Distinct().ToList();
            
            // FollowRepository might not have GetFollowedUserIdsAsync for a list, so we'll use GetFollowingIdsAsync
            var followedUserIds = await _followRepository.GetFollowingIdsAsync(currentUserId.Value);

            foreach (var dto in dtos)
            {
                var post = posts.First(p => p.Id == dto.Id);
                dto.IsLiked = likedPostIds.Contains(dto.Id);
                dto.IsFollowingAuthor = followedUserIds.Contains(post.UserId);
            }
        }

        return new FeedPaginationDto
        {
            Items = dtos,
            PageNumber = request.PageNumber,
            PageSize = pageSize,
            HasMore = posts.Count == pageSize
        };
    }
}
