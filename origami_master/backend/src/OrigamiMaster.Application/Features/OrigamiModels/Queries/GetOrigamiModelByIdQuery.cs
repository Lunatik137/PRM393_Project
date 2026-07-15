using System;
using MediatR;
using OrigamiMaster.Application.Features.OrigamiModels.DTOs;

namespace OrigamiMaster.Application.Features.OrigamiModels.Queries;

public class GetOrigamiModelByIdQuery : IRequest<OrigamiDetailDto?>
{
    public Guid Id { get; set; }
}
