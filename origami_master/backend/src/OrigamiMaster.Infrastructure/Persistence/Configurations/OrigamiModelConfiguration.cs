using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class OrigamiModelConfiguration : IEntityTypeConfiguration<OrigamiModel>
{
    public void Configure(EntityTypeBuilder<OrigamiModel> builder)
    {
        builder.HasKey(m => m.Id);

        builder.HasIndex(m => m.Slug).IsUnique();
        builder.HasIndex(m => m.Name);

        builder.Property(m => m.Name).IsRequired().HasMaxLength(200);
        builder.Property(m => m.Slug).IsRequired().HasMaxLength(200);
        builder.Property(m => m.Description).IsRequired();
        builder.Property(m => m.Difficulty).IsRequired();
        builder.Property(m => m.ThumbnailUrl).HasMaxLength(500);
        builder.Property(m => m.CoverImageUrl).HasMaxLength(500);

        builder.HasMany(m => m.Steps)
            .WithOne(s => s.OrigamiModel)
            .HasForeignKey(s => s.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);
            
        builder.HasMany(m => m.OrigamiTags)
            .WithOne(ot => ot.OrigamiModel)
            .HasForeignKey(ot => ot.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);
            
        builder.HasMany(m => m.Favorites)
            .WithOne(f => f.OrigamiModel)
            .HasForeignKey(f => f.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);
            
        builder.HasMany(m => m.CompletedModels)
            .WithOne(c => c.OrigamiModel)
            .HasForeignKey(c => c.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);
            
        builder.HasMany(m => m.RecentViews)
            .WithOne(r => r.OrigamiModel)
            .HasForeignKey(r => r.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
