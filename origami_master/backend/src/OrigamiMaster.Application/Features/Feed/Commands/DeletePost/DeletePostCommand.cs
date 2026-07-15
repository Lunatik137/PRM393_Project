using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Feed.Commands.DeletePost;

public class DeletePostCommand : IRequest
{
    public Guid Id { get; set; }
}
