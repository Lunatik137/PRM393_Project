using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Auth.Commands.Login;
using OrigamiMaster.Application.Features.Auth.Commands.Logout;
using OrigamiMaster.Application.Features.Auth.Commands.Refresh;
using OrigamiMaster.Application.Features.Auth.Commands.Register;
using OrigamiMaster.Application.Features.Auth.Commands.GoogleLogin;
using OrigamiMaster.Application.Features.Auth.DTOs;
using OrigamiMaster.Application.Features.Auth.Queries.GetCurrentUser;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class AuthController : ControllerBase
{
    private readonly IMediator _mediator;

    public AuthController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("register")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public async Task<IActionResult> Register([FromBody] RegisterRequest request)
    {
        var command = new RegisterCommand
        {
            Email = request.Email,
            Username = request.Username,
            Password = request.Password
        };

        try
        {
            var userId = await _mediator.Send(command);
            return StatusCode(StatusCodes.Status201Created, new { UserId = userId });
        }
        catch (System.Exception ex) when (ex.Message.Contains("ALREADY_EXISTS"))
        {
            return Conflict(new { Message = ex.Message });
        }
    }

    [HttpPost("login")]
    [ProducesResponseType(typeof(AuthResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        var command = new LoginCommand { Email = request.Email, Password = request.Password };

        try
        {
            var response = await _mediator.Send(command);
            return Ok(response);
        }
        catch (System.Exception ex) when (ex.Message == "INVALID_CREDENTIALS")
        {
            return Unauthorized(new { Message = "Invalid credentials" });
        }
    }

    [HttpPost("google")]
    [ProducesResponseType(typeof(AuthResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<IActionResult> GoogleLogin([FromBody] GoogleAuthRequest request)
    {
        var command = new GoogleLoginCommand { IdToken = request.IdToken };

        try
        {
            var response = await _mediator.Send(command);
            return Ok(response);
        }
        catch (System.Exception ex) when (ex.Message == "INVALID_GOOGLE_TOKEN")
        {
            return Unauthorized(new { Message = "Invalid Google token" });
        }
    }

    [HttpPost("refresh")]
    [ProducesResponseType(typeof(AuthResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<IActionResult> Refresh([FromBody] RefreshTokenRequest request)
    {
        var command = new RefreshTokenCommand { Token = request.RefreshToken };

        try
        {
            var response = await _mediator.Send(command);
            return Ok(response);
        }
        catch (System.Exception ex) when (ex.Message.Contains("REFRESH_TOKEN"))
        {
            return Unauthorized(new { Message = ex.Message });
        }
    }

    [Authorize]
    [HttpPost("logout")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    public async Task<IActionResult> Logout([FromBody] RefreshTokenRequest request)
    {
        var command = new LogoutCommand { RefreshToken = request.RefreshToken };
        await _mediator.Send(command);
        return NoContent();
    }

    [Authorize]
    [HttpGet("me")]
    [ProducesResponseType(typeof(CurrentUserDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<IActionResult> GetCurrentUser()
    {
        var query = new GetCurrentUserQuery();
        var response = await _mediator.Send(query);
        return Ok(response);
    }
}
