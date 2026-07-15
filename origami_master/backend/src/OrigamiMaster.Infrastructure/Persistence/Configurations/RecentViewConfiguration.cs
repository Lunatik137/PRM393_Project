using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class RecentViewConfiguration : IEntityTypeConfiguration<RecentView>
{
    public void Configure(EntityTypeBuilder<RecentView> builder)
    {
        builder.HasKey(r => new { r.UserId, r.OrigamiModelId });

        builder.HasOne(r => r.User)
            .WithMany(u => u.RecentViews)
            .HasForeignKey(r => r.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(r => r.OrigamiModel)
            .WithMany(m => m.RecentViews)
            .HasForeignKey(r => r.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
