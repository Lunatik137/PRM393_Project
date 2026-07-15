using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class LikeConfiguration : IEntityTypeConfiguration<Like>
{
    public void Configure(EntityTypeBuilder<Like> builder)
    {
        builder.HasKey(l => l.Id);

        builder.HasIndex(l => new { l.FeedPostId, l.UserId }).IsUnique();

        builder.HasIndex(l => l.FeedPostId);
        builder.HasIndex(l => l.UserId);

        builder.HasOne<FeedPost>()
            .WithMany()
            .HasForeignKey(l => l.FeedPostId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
