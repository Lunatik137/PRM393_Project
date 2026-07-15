using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class CompletedModelConfiguration : IEntityTypeConfiguration<CompletedModel>
{
    public void Configure(EntityTypeBuilder<CompletedModel> builder)
    {
        builder.HasKey(c => new { c.UserId, c.OrigamiModelId });

        builder.HasOne(c => c.User)
            .WithMany(u => u.CompletedModels)
            .HasForeignKey(c => c.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasOne(c => c.OrigamiModel)
            .WithMany(m => m.CompletedModels)
            .HasForeignKey(c => c.OrigamiModelId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
