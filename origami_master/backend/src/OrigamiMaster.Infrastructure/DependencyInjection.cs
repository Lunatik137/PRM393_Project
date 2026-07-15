using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Infrastructure.Persistence;
using OrigamiMaster.Infrastructure.Repositories;

namespace OrigamiMaster.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddScoped<OrigamiMaster.Application.Interfaces.IUnitOfWork, UnitOfWork>();
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IOrigamiModelRepository, OrigamiModelRepository>();
        services.AddScoped<ICategoryRepository, CategoryRepository>();
        services.AddScoped<ILearningProgressRepository, LearningProgressRepository>();
        services.AddScoped<ICreationRepository, CreationRepository>();
        services.AddScoped<IFeedPostRepository, FeedPostRepository>();
        services.AddScoped<ICommentRepository, CommentRepository>();
        services.AddScoped<ILikeRepository, LikeRepository>();
        services.AddScoped<IFollowRepository, FollowRepository>();
        services.AddScoped<IShareLinkRepository, ShareLinkRepository>();
        services.AddScoped<INotificationRepository, NotificationRepository>();
        services.AddScoped<ISearchRepository, OrigamiMaster.Infrastructure.Persistence.Repositories.SearchRepository>();

        // Identity Services
        services.AddSingleton<Microsoft.AspNetCore.Identity.IPasswordHasher<Domain.Entities.User>, Microsoft.AspNetCore.Identity.PasswordHasher<Domain.Entities.User>>();
        services.AddScoped<OrigamiMaster.Application.Interfaces.IJwtTokenService, Identity.JwtTokenService>();
        services.AddScoped<OrigamiMaster.Application.Interfaces.IPasswordHashService, Identity.PasswordHashService>();
        services.AddScoped<OrigamiMaster.Application.Interfaces.IRefreshTokenService, Identity.RefreshTokenService>();
        services.AddScoped<OrigamiMaster.Application.Interfaces.ICurrentUserService, Identity.CurrentUserService>();

        return services;
    }
}
