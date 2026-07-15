using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class LearningProgressConfiguration : IEntityTypeConfiguration<LearningProgress>
{
    public void Configure(EntityTypeBuilder<LearningProgress> builder)
    {
        builder.HasKey(p => p.Id);

        builder.HasIndex(p => new { p.UserId, p.OrigamiModelId }).IsUnique();

        builder.HasOne<User>()
            .WithMany()
            .HasForeignKey(p => p.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasOne<OrigamiModel>()
            .WithMany()
            .HasForeignKey(p => p.OrigamiModelId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
