using MediatR;
using OrigamiMaster.Application.Features.Search.DTOs;
using OrigamiMaster.Domain.Repositories;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Search.Queries.SearchGlobal;

public class SearchGlobalQueryHandler : IRequestHandler<SearchGlobalQuery, SearchResponseDto>
{
    private readonly ISearchRepository _searchRepository;

    public SearchGlobalQueryHandler(ISearchRepository searchRepository)
    {
        _searchRepository = searchRepository;
    }

    public async Task<SearchResponseDto> Handle(SearchGlobalQuery request, CancellationToken cancellationToken)
    {
        var response = new SearchResponseDto();
        
        if (string.IsNullOrWhiteSpace(request.Query))
        {
            return response;
        }

        var query = request.Query.Trim();
        var isHashtagSearch = query.StartsWith("#");

        if (isHashtagSearch)
        {
            // Hashtag search: return matching hashtags + posts with that hashtag
            var hashtagsResult = await _searchRepository.SearchHashtagsAsync(query);
            response.Hashtags = hashtagsResult.Select(h => new SearchHashtagDto { Name = h.Hashtag, PostCount = h.PostCount }).ToList();
            var hashtagPosts = await _searchRepository.SearchPostsByHashtagAsync(query);
            response.Posts = hashtagPosts.Select(p => new SearchPostDto
            {
                Id = p.Id,
                Description = p.Description,
                ImageUrl = p.ImageUrl,
                CreatorId = p.UserId,
                CreatorName = p.User?.Username ?? "Unknown User",
                LikeCount = p.LikeCount
            }).ToList();
        }
        else
        {
            // General search: users + posts by description + hashtags
            var users = await _searchRepository.SearchUsersAsync(query);
            response.Users = users.Select(u => new SearchUserDto
            {
                Id = u.Id,
                Username = u.Username,
                FullName = u.Username,
                AvatarUrl = u.AvatarUrl,
                FollowersCount = 0
            }).ToList();

            // Include posts from matching users
            var allPosts = new System.Collections.Generic.List<SearchPostDto>();
            
            var descriptionPosts = await _searchRepository.SearchPostsAsync(query);
            allPosts.AddRange(descriptionPosts.Select(p => new SearchPostDto
            {
                Id = p.Id,
                Description = p.Description,
                ImageUrl = p.ImageUrl,
                CreatorId = p.UserId,
                CreatorName = p.User?.Username ?? "Unknown User",
                LikeCount = p.LikeCount
            }));

            // For each matched user, load their posts
            foreach (var user in users)
            {
                var userPosts = await _searchRepository.SearchPostsByUserIdAsync(user.Id);
                foreach (var p in userPosts)
                {
                    if (!allPosts.Any(existing => existing.Id == p.Id))
                    {
                        allPosts.Add(new SearchPostDto
                        {
                            Id = p.Id,
                            Description = p.Description,
                            ImageUrl = p.ImageUrl,
                            CreatorId = p.UserId,
                            CreatorName = p.User?.Username ?? "Unknown User",
                            LikeCount = p.LikeCount
                        });
                    }
                }
            }

            response.Posts = allPosts;
            var hashtagsResult = await _searchRepository.SearchHashtagsAsync(query);
            response.Hashtags = hashtagsResult.Select(h => new SearchHashtagDto { Name = h.Hashtag, PostCount = h.PostCount }).ToList();
        }

        return response;
    }
}
