using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using OrigamiMaster.Application.Features.ShareLinks.Queries.GetSharedCreation;
using System;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/shared")]
public class SharedCreationController : ControllerBase
{
    private readonly IMediator _mediator;

    public SharedCreationController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("{token}")]
    [ProducesResponseType(typeof(SharedCreationDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetSharedCreation(string token)
    {
        try
        {
            var response = await _mediator.Send(new GetSharedCreationQuery { Token = token });
            return Ok(response);
        }
        catch (Exception ex) when (ex.Message == "INVALID_SHARE_TOKEN" || ex.Message == "INACTIVE_SHARE_LINK" || ex.Message == "CREATION_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }
}
