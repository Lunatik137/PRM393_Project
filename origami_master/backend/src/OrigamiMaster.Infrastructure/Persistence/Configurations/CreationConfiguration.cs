using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class CreationConfiguration : IEntityTypeConfiguration<Creation>
{
    public void Configure(EntityTypeBuilder<Creation> builder)
    {
        builder.HasKey(c => c.Id);

        builder.Property(c => c.ImageUrl).HasMaxLength(2048);
        builder.Property(c => c.Notes).HasMaxLength(1000);

        builder.HasIndex(c => c.UserId);
        builder.HasIndex(c => c.Visibility);
        builder.HasIndex(c => c.IsPublished);

        builder.HasOne<OrigamiModel>(c => c.OrigamiModel)
            .WithMany()
            .HasForeignKey(c => c.OrigamiModelId)
            .IsRequired(false)
            .OnDelete(DeleteBehavior.SetNull);

        // User relationship is handled by UserConfiguration.HasMany(u => u.Creations)
    }
}

