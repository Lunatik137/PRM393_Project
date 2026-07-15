using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Follows.Commands.FollowUser;
using OrigamiMaster.Application.Features.Follows.Commands.UnfollowUser;
using OrigamiMaster.Application.Features.Follows.DTOs;
using OrigamiMaster.Application.Features.Follows.Queries.GetFollowers;
using OrigamiMaster.Application.Features.Follows.Queries.GetFollowing;
using OrigamiMaster.Application.Features.Follows.Queries.GetFollowStatus;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/users")]
public class FollowController : ControllerBase
{
    private readonly IMediator _mediator;

    public FollowController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [Authorize]
    [HttpPost("{userId}/follow")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public async Task<IActionResult> FollowUser(Guid userId)
    {
        var command = new FollowUserCommand { TargetUserId = userId };
        try
        {
            await _mediator.Send(command);
            return Ok(new { success = true });
        }
        catch (Exception ex) when (ex.Message == "CANNOT_FOLLOW_SELF")
        {
            return BadRequest(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "USER_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "ALREADY_FOLLOWING")
        {
            return Conflict(new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpDelete("{userId}/follow")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> UnfollowUser(Guid userId)
    {
        var command = new UnfollowUserCommand { TargetUserId = userId };
        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "FOLLOW_RELATIONSHIP_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [HttpGet("{userId}/follow-status")]
    [ProducesResponseType(typeof(FollowStatusDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetFollowStatus(Guid userId)
    {
        var query = new GetFollowStatusQuery { TargetUserId = userId };
        try
        {
            var response = await _mediator.Send(query);
            return Ok(response);
        }
        catch (Exception ex) when (ex.Message == "USER_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [HttpGet("{userId}/followers")]
    [ProducesResponseType(typeof(PagedFollowUserListDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetFollowers(
        Guid userId,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 20)
    {
        var query = new GetFollowersQuery { UserId = userId, Page = page, PageSize = pageSize };
        var result = await _mediator.Send(query);
        return Ok(result);
    }

    [HttpGet("{userId}/following")]
    [ProducesResponseType(typeof(PagedFollowUserListDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetFollowing(
        Guid userId,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 20)
    {
        var query = new GetFollowingQuery { UserId = userId, Page = page, PageSize = pageSize };
        var result = await _mediator.Send(query);
        return Ok(result);
    }
}
