using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Comments.Commands.DeleteComment;

public class DeleteCommentCommand : IRequest
{
    public Guid CommentId { get; set; }
}
