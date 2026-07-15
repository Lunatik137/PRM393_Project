using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Profile.Commands.UpdateProfile;
using OrigamiMaster.Application.Features.Profile.DTOs;
using OrigamiMaster.Application.Features.Profile.Queries.GetCurrentProfile;
using OrigamiMaster.Application.Features.Profile.Queries.GetUserPosts;
using OrigamiMaster.Application.Features.Profile.Queries.GetUserProfile;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1")]
public class ProfileController : ControllerBase
{
    private readonly IMediator _mediator;

    public ProfileController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [Authorize]
    [HttpGet("profile/me")]
    [ProducesResponseType(typeof(UserProfileDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetCurrentProfile()
    {
        try
        {
            var response = await _mediator.Send(new GetCurrentProfileQuery());
            return Ok(response);
        }
        catch (Exception ex) when (ex.Message == "USER_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpPut("profile")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public async Task<IActionResult> UpdateProfile([FromBody] UpdateProfileRequest request)
    {
        var command = new UpdateProfileCommand
        {
            Username = request.Username,
            Bio = request.Bio,
            AvatarUrl = request.AvatarUrl
        };

        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "USER_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "USERNAME_ALREADY_EXISTS")
        {
            return Conflict(new { Message = ex.Message });
        }
    }

    [HttpGet("users/{userId}")]
    [ProducesResponseType(typeof(UserProfileDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetUserProfile(Guid userId)
    {
        try
        {
            var response = await _mediator.Send(new GetUserProfileQuery { UserId = userId });
            return Ok(response);
        }
        catch (Exception ex) when (ex.Message == "USER_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [HttpGet("users/{userId}/posts")]
    [ProducesResponseType(typeof(UserPostPaginationDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetUserPosts(Guid userId, [FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20)
    {
        try
        {
            var query = new GetUserPostsQuery
            {
                UserId = userId,
                PageNumber = pageNumber,
                PageSize = pageSize
            };
            var response = await _mediator.Send(query);
            return Ok(response);
        }
        catch (Exception ex) when (ex.Message == "USER_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }
}
