using MediatR;
using System;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Feed.Commands.UpdatePost;

public class UpdatePostCommand : IRequest<Unit>
{
    public Guid Id { get; set; }
    public string Description { get; set; } = string.Empty;
    public List<string>? Hashtags { get; set; }
}
