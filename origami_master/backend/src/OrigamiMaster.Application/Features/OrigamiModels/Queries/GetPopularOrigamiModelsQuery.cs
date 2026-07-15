using MediatR;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;
using System.Collections.Generic;

namespace OrigamiMaster.Application.Features.OrigamiModels.Queries;

public class GetPopularOrigamiModelsQuery : IRequest<IEnumerable<OrigamiSummaryDto>>
{
    public int Limit { get; set; } = 10;
}
