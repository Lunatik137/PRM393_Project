using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.OrigamiModels.Queries;

public class GetLatestOrigamiModelsQueryHandler : IRequestHandler<GetLatestOrigamiModelsQuery, IEnumerable<OrigamiSummaryDto>>
{
    private readonly IOrigamiModelRepository _repository;
    private readonly IMapper _mapper;

    public GetLatestOrigamiModelsQueryHandler(IOrigamiModelRepository repository, IMapper mapper)
    {
        _repository = repository;
        _mapper = mapper;
    }

    public async Task<IEnumerable<OrigamiSummaryDto>> Handle(GetLatestOrigamiModelsQuery request, CancellationToken cancellationToken)
    {
        var models = await _repository.GetLatestAsync(request.Limit);
        return _mapper.Map<IEnumerable<OrigamiSummaryDto>>(models);
    }
}
