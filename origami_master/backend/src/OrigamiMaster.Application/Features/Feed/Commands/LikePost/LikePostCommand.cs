using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Feed.Commands.LikePost;

public class LikePostCommand : IRequest<Unit>
{
    public Guid PostId { get; set; }
}
