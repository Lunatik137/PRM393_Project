using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class CommentConfiguration : IEntityTypeConfiguration<Comment>
{
    public void Configure(EntityTypeBuilder<Comment> builder)
    {
        builder.HasKey(c => c.Id);

        builder.Property(c => c.Content).HasMaxLength(1000);

        builder.HasIndex(c => c.FeedPostId);
        builder.HasIndex(c => c.UserId);

        builder.HasOne<FeedPost>()
            .WithMany()
            .HasForeignKey(c => c.FeedPostId)
            .OnDelete(DeleteBehavior.Restrict);

        // User relationship is handled by UserConfiguration.HasMany(u => u.Comments)
    }
}

