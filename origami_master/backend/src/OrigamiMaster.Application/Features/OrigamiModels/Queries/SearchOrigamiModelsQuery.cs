using System;
using MediatR;
using OrigamiMaster.Domain.Enums;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;

namespace OrigamiMaster.Application.Features.OrigamiModels.Queries;

public class SearchOrigamiModelsQuery : IRequest<PagedResponseDto<OrigamiSummaryDto>>
{
    public string? Keyword { get; set; }
    public Guid? CategoryId { get; set; }
    public DifficultyLevel? Difficulty { get; set; }
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}
