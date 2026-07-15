using MediatR;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Categories.Queries;
using OrigamiMaster.Application.Features.Categories.DTOs;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class CategoriesController : ControllerBase
{
    private readonly IMediator _mediator;

    public CategoriesController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    [ProducesResponseType(typeof(IEnumerable<CategoryDto>), 200)]
    public async Task<IActionResult> GetAll()
    {
        var result = await _mediator.Send(new GetAllCategoriesQuery());
        return Ok(result);
    }

    [HttpGet("{id}")]
    [ProducesResponseType(typeof(CategoryDto), 200)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> GetById(Guid id)
    {
        var result = await _mediator.Send(new GetCategoryByIdQuery { Id = id });
        if (result == null) return NotFound();
        return Ok(result);
    }
}
