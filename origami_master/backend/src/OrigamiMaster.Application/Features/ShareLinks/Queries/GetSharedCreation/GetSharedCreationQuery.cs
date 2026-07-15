using MediatR;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;

namespace OrigamiMaster.Application.Features.ShareLinks.Queries.GetSharedCreation;

public class GetSharedCreationQuery : IRequest<SharedCreationDto>
{
    public string Token { get; set; } = string.Empty;
}
