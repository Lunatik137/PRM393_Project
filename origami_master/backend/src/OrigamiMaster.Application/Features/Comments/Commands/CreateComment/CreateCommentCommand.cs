using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Comments.Commands.CreateComment;

public class CreateCommentCommand : IRequest<Guid>
{
    public Guid PostId { get; set; }
    public string Content { get; set; } = string.Empty;
}
