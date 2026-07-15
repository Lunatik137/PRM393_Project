using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.OrigamiModels.Queries;

public class GetPopularOrigamiModelsQueryHandler : IRequestHandler<GetPopularOrigamiModelsQuery, IEnumerable<OrigamiSummaryDto>>
{
    private readonly IOrigamiModelRepository _repository;
    private readonly IMapper _mapper;

    public GetPopularOrigamiModelsQueryHandler(IOrigamiModelRepository repository, IMapper mapper)
    {
        _repository = repository;
        _mapper = mapper;
    }

    public async Task<IEnumerable<OrigamiSummaryDto>> Handle(GetPopularOrigamiModelsQuery request, CancellationToken cancellationToken)
    {
        var models = await _repository.GetPopularAsync(request.Limit);
        return _mapper.Map<IEnumerable<OrigamiSummaryDto>>(models);
    }
}
