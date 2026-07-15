using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Comments.Commands.CreateComment;
using OrigamiMaster.Application.Features.Comments.Commands.DeleteComment;
using OrigamiMaster.Application.Features.Comments.DTOs;
using OrigamiMaster.Application.Features.Comments.Queries.GetComments;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1")]
public class CommentsController : ControllerBase
{
    private readonly IMediator _mediator;

    public CommentsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("posts/{postId}/comments")]
    [ProducesResponseType(typeof(CommentPaginationDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetComments(Guid postId, [FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20)
    {
        var query = new GetCommentsQuery
        {
            PostId = postId,
            PageNumber = pageNumber,
            PageSize = pageSize
        };
        var response = await _mediator.Send(query);
        return Ok(response);
    }

    [Authorize]
    [HttpPost("posts/{postId}/comments")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> CreateComment(Guid postId, [FromBody] CreateCommentRequest request)
    {
        var command = new CreateCommentCommand
        {
            PostId = postId,
            Content = request.Content
        };

        try
        {
            var id = await _mediator.Send(command);
            return StatusCode(StatusCodes.Status201Created, new { CommentId = id });
        }
        catch (Exception ex) when (ex.Message == "FEED_POST_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpDelete("comments/{commentId}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> DeleteComment(Guid commentId)
    {
        var command = new DeleteCommentCommand { CommentId = commentId };
        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "COMMENT_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "FORBIDDEN_ACTION")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
    }
}
