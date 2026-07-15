using AutoMapper;
using MediatR;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;
using OrigamiMaster.Domain.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.OrigamiModels.Queries;

public class GetOrigamiModelByIdQueryHandler : IRequestHandler<GetOrigamiModelByIdQuery, OrigamiDetailDto?>
{
    private readonly IOrigamiModelRepository _repository;
    private readonly IMapper _mapper;

    public GetOrigamiModelByIdQueryHandler(IOrigamiModelRepository repository, IMapper mapper)
    {
        _repository = repository;
        _mapper = mapper;
    }

    public async Task<OrigamiDetailDto?> Handle(GetOrigamiModelByIdQuery request, CancellationToken cancellationToken)
    {
        var model = await _repository.GetByIdAsync(request.Id);
        return model == null ? null : _mapper.Map<OrigamiDetailDto>(model);
    }
}
