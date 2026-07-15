using MediatR;
using System;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.Feed.Commands.PublishPost;

public class PublishPostCommand : IRequest<Guid>
{
    public string? ImageUrl { get; set; }
    public string Description { get; set; } = string.Empty;
    public List<string> Hashtags { get; set; } = new();
}
