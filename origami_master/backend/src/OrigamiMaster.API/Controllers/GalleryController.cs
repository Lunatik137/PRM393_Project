using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using OrigamiMaster.Application.Features.Gallery.Commands.CreateCreation;
using OrigamiMaster.Application.Features.Gallery.Commands.DeleteCreation;
using OrigamiMaster.Application.Features.Gallery.Commands.UpdateVisibility;
using OrigamiMaster.Application.Features.Gallery.Commands.UpdateCreation;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using OrigamiMaster.Application.Features.Gallery.Queries.GetCreationDetail;
using OrigamiMaster.Application.Features.Gallery.Queries.GetGalleryStatistics;
using OrigamiMaster.Application.Features.Gallery.Queries.GetMyGallery;
using OrigamiMaster.Application.Features.Gallery.Queries.GetMyPostsGallery;
using AutoMapper;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("api/v1/gallery")]
[Authorize]
public class GalleryController : ControllerBase
{
    private readonly IMediator _mediator;
    private readonly ICreationRepository _creationRepository;
    private readonly IMapper _mapper;

    public GalleryController(IMediator mediator, ICreationRepository creationRepository, IMapper mapper)
    {
        _mediator = mediator;
        _creationRepository = creationRepository;
        _mapper = mapper;
    }

    [HttpPost]
    [ProducesResponseType(typeof(GalleryItemDto), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> CreateCreation([FromBody] CreateCreationRequest request)
    {
        var command = new CreateCreationCommand
        {
            OrigamiModelId = request.OrigamiModelId,
            ImageUrl = request.ImageUrl,
            Notes = request.Notes,
            Visibility = request.Visibility
        };

        try
        {
            var id = await _mediator.Send(command);
            // Fetch the created creation to return a proper DTO
            var creation = await _creationRepository.GetByIdAsync(id);
            var dto = _mapper.Map<GalleryItemDto>(creation);
            return StatusCode(StatusCodes.Status201Created, dto);
        }
        catch (Exception ex) when (ex.Message == "ORIGAMI_MODEL_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
    }

    [HttpGet]
    [ProducesResponseType(typeof(GalleryPaginationDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetMyGallery([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20, [FromQuery] string? visibility = null)
    {
        var query = new GetMyGalleryQuery
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            Visibility = visibility
        };

        var response = await _mediator.Send(query);
        return Ok(response);
    }

    [HttpGet("posts")]
    [ProducesResponseType(typeof(GalleryPaginationDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetMyPostsGallery([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 20)
    {
        var currentUserId = Guid.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value!);
        var query = new GetMyPostsGalleryQuery { UserId = currentUserId, PageNumber = pageNumber, PageSize = pageSize };
        var response = await _mediator.Send(query);
        return Ok(response);
    }

    [HttpGet("public")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(GalleryPaginationDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetPublicGallery(
        [FromQuery] string? origamiModelId,
        [FromQuery] int pageNumber = 1,
        [FromQuery] int pageSize = 20)
    {
        Guid? modelId = null;
        if (!string.IsNullOrEmpty(origamiModelId) && Guid.TryParse(origamiModelId, out var parsedId))
            modelId = parsedId;

        var creations = await _creationRepository.GetPublicAsync(modelId, pageNumber, pageSize);
        var dtos = _mapper.Map<List<GalleryItemDto>>(creations);
        return Ok(new GalleryPaginationDto
        {
            Items = dtos,
            PageNumber = pageNumber,
            PageSize = pageSize,
            HasMore = creations.Count == pageSize
        });
    }

    [HttpGet("{id}")]
    [ProducesResponseType(typeof(GalleryDetailDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetCreationDetail(Guid id)
    {
        try
        {
            var response = await _mediator.Send(new GetCreationDetailQuery { CreationId = id });
            return Ok(response);
        }
        catch (Exception ex) when (ex.Message == "CREATION_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "GALLERY_ACCESS_DENIED")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> UpdateCreation(Guid id, [FromBody] UpdateCreationCommand command)
    {
        if (id != command.CreationId)
            command.CreationId = id;

        try
        {
            await _mediator.Send(command);
            return NoContent();
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

    [HttpPatch("{id}/visibility")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public async Task<IActionResult> UpdateVisibility(Guid id, [FromBody] UpdateVisibilityRequest request)
    {
        var command = new UpdateVisibilityCommand
        {
            CreationId = id,
            Visibility = request.Visibility
        };

        try
        {
            await _mediator.Send(command);
            return NoContent();
        }
        catch (Exception ex) when (ex.Message == "CREATION_NOT_FOUND")
        {
            return NotFound(new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "FORBIDDEN_ACTION")
        {
            return StatusCode(StatusCodes.Status403Forbidden, new { Message = ex.Message });
        }
        catch (Exception ex) when (ex.Message == "CREATION_ALREADY_PUBLISHED")
        {
            return Conflict(new { Message = ex.Message });
        }
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> DeleteCreation(Guid id)
    {
        try
        {
            await _mediator.Send(new DeleteCreationCommand { CreationId = id });
            return NoContent();
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

    [HttpGet("statistics")]
    [ProducesResponseType(typeof(GalleryStatisticsDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetGalleryStatistics()
    {
        var response = await _mediator.Send(new GetGalleryStatisticsQuery());
        return Ok(response);
    }
}
