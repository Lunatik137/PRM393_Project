using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Infrastructure.Persistence.Configurations;

public class OrigamiStepConfiguration : IEntityTypeConfiguration<OrigamiStep>
{
    public void Configure(EntityTypeBuilder<OrigamiStep> builder)
    {
        builder.HasKey(s => s.Id);

        builder.Property(s => s.Title).IsRequired().HasMaxLength(200);
        builder.Property(s => s.Description).IsRequired();
        builder.Property(s => s.ImageUrl).HasMaxLength(500);
    }
}
