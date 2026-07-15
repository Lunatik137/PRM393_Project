using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.ShareLinks.Commands.DeleteShareLink;
using OrigamiMaster.Application.Features.ShareLinks.Commands.GenerateShareLink;
using OrigamiMaster.Application.Features.ShareLinks.Commands.ToggleShareLink;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using OrigamiMaster.Application.Features.ShareLinks.Queries.GetMyShareLinks;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/share-links")]
[Authorize]
public class ShareLinksController : ControllerBase
{
    private readonly IMediator _mediator;

    public ShareLinksController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    [ProducesResponseType(typeof(GenerateShareLinkResponse), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GenerateShareLink([FromBody] GenerateShareLinkCommand command)
    {
        try
        {
            var response = await _mediator.Send(command);
            return StatusCode(StatusCodes.Status201Created, response);
        }
        catch (Exception ex) when (ex.Message == "CREATION_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "FORBIDDEN_ACTION")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
    }

    [HttpGet]
    [ProducesResponseType(typeof(List<ShareLinkDto>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetMyShareLinks()
    {
        var response = await _mediator.Send(new GetMyShareLinksQuery());
        return Ok(response);
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> DeleteShareLink(Guid id)
    {
        try
        {
            await _mediator.Send(new DeleteShareLinkCommand { ShareLinkId = id });
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "SHARE_LINK_NOT_FOUND" || ex.Message == "CREATION_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "FORBIDDEN_ACTION")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
    }

    [HttpPatch("{id}/toggle")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> ToggleShareLink(Guid id)
    {
        try
        {
            await _mediator.Send(new ToggleShareLinkCommand { ShareLinkId = id });
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "SHARE_LINK_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "FORBIDDEN_ACTION")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
    }
}
