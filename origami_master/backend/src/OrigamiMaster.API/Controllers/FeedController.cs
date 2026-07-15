using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Feed.Commands.DeletePost;
using OrigamiMaster.Application.Features.Feed.Commands.PublishPost;
using OrigamiMaster.Application.Features.Feed.DTOs;
using OrigamiMaster.Application.Features.Feed.Queries.GetFeedPost;
using OrigamiMaster.Application.Features.Feed.Queries.GetHomeFeed;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class FeedController : ControllerBase
{
    private readonly IMediator _mediator;

    public FeedController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [Authorize]
    [HttpPost("publish")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> PublishPost([FromBody] PublishFeedRequest request)
    {
        var command = new PublishPostCommand
        {
            ImageUrl = request.ImageUrl,
            Description = request.Description,
            Hashtags = request.Hashtags
        };

        try
        {
            var id = await _mediator.Send(command);
            return StatusCode(StatusCodes.Status201Created, new { Id = id });
        }
        catch (Exception ex)
        {
            return BadRequest(new { Message = ex.Message });
        }
    }

    [HttpGet]
    [ProducesResponseType(typeof(FeedPaginationDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetHomeFeed([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20)
    {
        var query = new GetHomeFeedQuery { PageNumber = pageNumber, PageSize = pageSize };
        var response = await _mediator.Send(query);
        return Ok(response);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(typeof(FeedPostDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetFeedPost(Guid id)
    {
        var query = new GetFeedPostQuery { Id = id };
        
        try
        {
            var response = await _mediator.Send(query);
            return Ok(response);
        }
        catch (Exception ex) when (ex.Message == "FEED_POST_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> DeletePost(Guid id)
    {
        var command = new DeletePostCommand { Id = id };
        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "FEED_POST_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "FORBIDDEN_ACTION")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> UpdatePost(Guid id, [FromBody] UpdatePostRequest request)
    {
        var command = new OrigamiMaster.Application.Features.Feed.Commands.UpdatePost.UpdatePostCommand 
        { 
            Id = id, 
            Description = request.Description,
            Hashtags = request.Hashtags
        };
        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "FEED_POST_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "FORBIDDEN_ACTION")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpPost("{id}/like")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> LikePost(Guid id)
    {
        var command = new OrigamiMaster.Application.Features.Feed.Commands.LikePost.LikePostCommand { PostId = id };
        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "FEED_POST_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpDelete("{id}/like")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> UnlikePost(Guid id)
    {
        var command = new OrigamiMaster.Application.Features.Feed.Commands.UnlikePost.UnlikePostCommand { PostId = id };
        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "FEED_POST_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

}
