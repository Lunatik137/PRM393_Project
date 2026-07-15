using Microsoft.EntityFrameworkCore;
using OrigamiMaster.Domain.Entities;
using System.Reflection;

namespace OrigamiMaster.Infrastructure.Persistence;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users => Set<User>();
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<OrigamiModel> OrigamiModels => Set<OrigamiModel>();
    public DbSet<OrigamiStep> OrigamiSteps => Set<OrigamiStep>();
    public DbSet<Tag> Tags => Set<Tag>();
    public DbSet<OrigamiTag> OrigamiTags => Set<OrigamiTag>();
    public DbSet<LearningProgress> LearningProgresses => Set<LearningProgress>();
    public DbSet<Creation> Creations => Set<Creation>();
    public DbSet<FeedPost> FeedPosts => Set<FeedPost>();
    public DbSet<Comment> Comments => Set<Comment>();
    public DbSet<Like> Likes => Set<Like>();
    public DbSet<Follow> Follows => Set<Follow>();
    public DbSet<ShareLink> ShareLinks => Set<ShareLink>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();
    
    public DbSet<Favorite> Favorites => Set<Favorite>();
    public DbSet<CompletedModel> CompletedModels => Set<CompletedModel>();
    public DbSet<RecentView> RecentViews => Set<RecentView>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        
        // Apply all configurations defined in the assembly
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

        // Apply seed data
        OrigamiMaster.Infrastructure.Persistence.Seed.OrigamiSeeder.Seed(modelBuilder);
    }
}
