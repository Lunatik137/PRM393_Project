using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.DependencyInjection;
using OrigamiMaster.API.Authorization;

namespace OrigamiMaster.API.Extensions;

public static class AuthorizationExtensions
{
    public static IServiceCollection AddAppAuthorization(this IServiceCollection services)
    {
        services.AddAuthorization(options =>
        {
            options.AddPolicy(Policies.CreationOwner, policy =>
                policy.Requirements.Add(new CreationOwnerRequirement()));
                
            options.AddPolicy(Policies.FeedOwner, policy =>
                policy.Requirements.Add(new FeedOwnerRequirement()));

            options.AddPolicy(Policies.CommentOwner, policy =>
                policy.Requirements.Add(new CommentOwnerRequirement()));
        });

        services.AddScoped<IAuthorizationHandler, CreationOwnerHandler>();
        services.AddScoped<IAuthorizationHandler, FeedOwnerHandler>();
        services.AddScoped<IAuthorizationHandler, CommentOwnerHandler>();

        return services;
    }
}
