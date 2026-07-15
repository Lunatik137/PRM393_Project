using System;
using System.Collections.Generic;

namespace OrigamiMaster.Domain.Entities;

public class Tag
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;

    public ICollection<OrigamiTag> OrigamiTags { get; set; } = new List<OrigamiTag>();
}
