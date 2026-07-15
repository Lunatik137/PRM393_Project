using MediatR;
using OrigamiMaster.Application.Features.Search.DTOs;

namespace OrigamiMaster.Application.Features.Search.Queries.SearchGlobal;

public class SearchGlobalQuery : IRequest<SearchResponseDto>
{
    public string Query { get; set; } = string.Empty;
}
