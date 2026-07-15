using MediatR;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.OrigamiModels.Queries;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;
using OrigamiMaster.Domain.Enums;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/origami")]
public class OrigamiController : ControllerBase
{
    private readonly IMediator _mediator;

    public OrigamiController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("search")]
    [ProducesResponseType(typeof(PagedResponseDto<OrigamiSummaryDto>), 200)]
    public async Task<IActionResult> Search([FromQuery] string? keyword, [FromQuery] Guid? categoryId, [FromQuery] DifficultyLevel? difficulty, [FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20)
    {
        var result = await _mediator.Send(new SearchOrigamiModelsQuery
        {
            Keyword = keyword,
            CategoryId = categoryId,
            Difficulty = difficulty,
            PageNumber = pageNumber,
            PageSize = pageSize
        });
        return Ok(result);
    }
    
    [HttpGet]
    [ProducesResponseType(typeof(PagedResponseDto<OrigamiSummaryDto>), 200)]
    public async Task<IActionResult> GetAll([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20)
    {
        return await Search(null, null, null, pageNumber, pageSize);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(typeof(OrigamiDetailDto), 200)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> GetById(Guid id)
    {
        var result = await _mediator.Send(new GetOrigamiModelByIdQuery { Id = id });
        if (result == null) return NotFound();
        return Ok(result);
    }
    
    [HttpGet("category/{id}")]
    [ProducesResponseType(typeof(PagedResponseDto<OrigamiSummaryDto>), 200)]
    public async Task<IActionResult> GetByCategory(Guid id, [FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20)
    {
        return await Search(null, id, null, pageNumber, pageSize);
    }

    [HttpGet("popular")]
    [ProducesResponseType(typeof(IEnumerable<OrigamiSummaryDto>), 200)]
    public async Task<IActionResult> GetPopular([FromQuery] int limit = 10)
    {
        var result = await _mediator.Send(new GetPopularOrigamiModelsQuery { Limit = limit });
        return Ok(result);
    }

    [HttpGet("latest")]
    [ProducesResponseType(typeof(IEnumerable<OrigamiSummaryDto>), 200)]
    public async Task<IActionResult> GetLatest([FromQuery] int limit = 10)
    {
        var result = await _mediator.Send(new GetLatestOrigamiModelsQuery { Limit = limit });
        return Ok(result);
    }
}
