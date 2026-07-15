using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;
using System.Collections.Generic;
using System.Text.Json;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class FeedPostConfiguration : IEntityTypeConfiguration<FeedPost>
{
    public void Configure(EntityTypeBuilder<FeedPost> builder)
    {
        builder.HasKey(f => f.Id);

        builder.HasIndex(f => f.PublishedAt);
        builder.HasIndex(f => f.UserId);

        builder.Property(f => f.Description).HasMaxLength(1000);
        builder.Property(f => f.ImageUrl).HasMaxLength(2048);

        builder.Property(f => f.Hashtags)
            .HasConversion(
                v => JsonSerializer.Serialize(v ?? new List<string>(), (JsonSerializerOptions?)null),
                v => string.IsNullOrWhiteSpace(v) ? new List<string>() : JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions?)null) ?? new List<string>()
            )
            .HasColumnType("nvarchar(max)");

        // User relationship is handled by UserConfiguration.HasMany(u => u.FeedPosts)
    }
}


