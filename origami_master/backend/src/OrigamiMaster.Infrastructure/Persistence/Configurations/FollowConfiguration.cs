using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class FollowConfiguration : IEntityTypeConfiguration<Follow>
{
    public void Configure(EntityTypeBuilder<Follow> builder)
    {
        builder.HasKey(f => f.Id);

        builder.HasIndex(f => new { f.FollowerUserId, f.FollowingUserId }).IsUnique();

        builder.HasIndex(f => f.FollowerUserId);
        builder.HasIndex(f => f.FollowingUserId);

        builder.HasOne(f => f.FollowerUser)
            .WithMany()
            .HasForeignKey(f => f.FollowerUserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne(f => f.FollowingUser)
            .WithMany()
            .HasForeignKey(f => f.FollowingUserId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
