using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Feed.Commands.UnlikePost;

public class UnlikePostCommand : IRequest<Unit>
{
    public Guid PostId { get; set; }
}
