using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class ShareLinkConfiguration : IEntityTypeConfiguration<ShareLink>
{
    public void Configure(EntityTypeBuilder<ShareLink> builder)
    {
        builder.HasKey(s => s.Id);

        builder.HasIndex(s => s.Token).IsUnique();

        builder.Property(s => s.Token).HasMaxLength(255);

        builder.HasIndex(s => s.CreationId);

        // Use navigation property to avoid EF creating a duplicate shadow FK (CreationId1)
        builder.HasOne<Creation>(s => s.Creation)
            .WithMany()
            .HasForeignKey(s => s.CreationId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}

