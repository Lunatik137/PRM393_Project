using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class OrigamiTagConfiguration : IEntityTypeConfiguration<OrigamiTag>
{
    public void Configure(EntityTypeBuilder<OrigamiTag> builder)
    {
        builder.HasKey(ot => new { ot.OrigamiModelId, ot.TagId });

        builder.HasOne(ot => ot.OrigamiModel)
            .WithMany(m => m.OrigamiTags)
            .HasForeignKey(ot => ot.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(ot => ot.Tag)
            .WithMany(t => t.OrigamiTags)
            .HasForeignKey(ot => ot.TagId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
