using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;
using OrigamiMaster.Domain.Repositories;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.OrigamiModels.Queries;

public class SearchOrigamiModelsQueryHandler : IRequestHandler<SearchOrigamiModelsQuery, PagedResponseDto<OrigamiSummaryDto>>
{
    private readonly IOrigamiModelRepository _repository;
    private readonly IMapper _mapper;

    public SearchOrigamiModelsQueryHandler(IOrigamiModelRepository repository, IMapper mapper)
    {
        _repository = repository;
        _mapper = mapper;
    }

    public async Task<PagedResponseDto<OrigamiSummaryDto>> Handle(SearchOrigamiModelsQuery request, CancellationToken cancellationToken)
    {
        var (items, totalCount) = await _repository.GetPagedAsync(
            request.Keyword, request.CategoryId, request.Difficulty, request.PageNumber, request.PageSize);
            
        return new PagedResponseDto<OrigamiSummaryDto>
        {
            Items = _mapper.Map<IEnumerable<OrigamiSummaryDto>>(items),
            TotalCount = totalCount,
            PageNumber = request.PageNumber,
            PageSize = request.PageSize
        };
    }
}
