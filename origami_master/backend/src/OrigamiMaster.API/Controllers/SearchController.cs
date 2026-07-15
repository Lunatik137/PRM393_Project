using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Search.DTOs;
using OrigamiMaster.Application.Features.Search.Queries.SearchGlobal;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class SearchController : ControllerBase
{
    private readonly IMediator _mediator;

    public SearchController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    [ProducesResponseType(typeof(SearchResponseDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GlobalSearch([FromQuery] string query = "")
    {
        var result = await _mediator.Send(new SearchGlobalQuery { Query = query });
        return Ok(result);
    }
}
