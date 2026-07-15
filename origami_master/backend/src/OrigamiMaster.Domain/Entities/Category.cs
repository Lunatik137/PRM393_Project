using System;
using System.Collections.Generic;

namespace OrigamiMaster.Domain.Entities;

public class Category
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Icon { get; set; } = string.Empty;

    public ICollection<OrigamiModel> OrigamiModels { get; set; } = new List<OrigamiModel>();
}
