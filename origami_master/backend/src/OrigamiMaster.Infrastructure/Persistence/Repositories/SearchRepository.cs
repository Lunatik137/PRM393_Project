using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OrigamiMaster.Infrastructure.Persistence.Repositories;

public class SearchRepository : ISearchRepository
{
    private readonly ApplicationDbContext _context;

    public SearchRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<User>> SearchUsersAsync(string query, int limit = 10)
    {
        return await _context.Users
            .Where(u => u.Username.Contains(query))
            .Take(limit)
            .ToListAsync();
    }

    public async Task<List<FeedPost>> SearchPostsAsync(string query, int limit = 10)
    {
        return await _context.FeedPosts
            .Include(p => p.User)
            .Where(p => p.Description.Contains(query))
            .OrderByDescending(p => p.PublishedAt)
            .Take(limit)
            .ToListAsync();
    }

    public async Task<List<FeedPost>> SearchPostsByHashtagAsync(string hashtag, int limit = 20)
    {
        // Normalize: ensure the hashtag has # prefix
        var normalizedTag = hashtag.StartsWith("#") ? hashtag : "#" + hashtag;
        
        // EF Core can't translate List.Contains on a JSON column directly to SQL.
        // Load with description filter then do client-side hashtag filtering.
        var posts = await _context.FeedPosts
            .Include(p => p.User)
            .OrderByDescending(p => p.PublishedAt)
            .ToListAsync();

        return posts
            .Where(p => p.Hashtags.Any(h => h.Equals(normalizedTag, System.StringComparison.OrdinalIgnoreCase)))
            .Take(limit)
            .ToList();
    }

    public async Task<List<FeedPost>> SearchPostsByUserIdAsync(System.Guid userId, int limit = 20)
    {
        return await _context.FeedPosts
            .Include(p => p.User)
            .Where(p => p.UserId == userId)
            .OrderByDescending(p => p.PublishedAt)
            .Take(limit)
            .ToListAsync();
    }

    public async Task<List<(string Hashtag, int PostCount)>> SearchHashtagsAsync(string query, int limit = 10)
    {
        var allHashtags = await _context.FeedPosts
            .Select(p => p.Hashtags)
            .ToListAsync();
            
        return allHashtags
            .SelectMany(h => h)
            .Where(h => h.Contains(query, System.StringComparison.OrdinalIgnoreCase))
            .GroupBy(h => h.ToLowerInvariant())
            .Select(g => (Hashtag: g.First(), PostCount: g.Count()))
            .OrderByDescending(x => x.PostCount)
            .Take(limit)
            .ToList();
    }
}
