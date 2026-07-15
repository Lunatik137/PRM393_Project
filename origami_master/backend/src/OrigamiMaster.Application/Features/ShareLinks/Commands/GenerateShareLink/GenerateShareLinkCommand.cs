using MediatR;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using System;

namespace OrigamiMaster.Application.Features.ShareLinks.Commands.GenerateShareLink;

public class GenerateShareLinkCommand : IRequest<GenerateShareLinkResponse>
{
    public Guid CreationId { get; set; }
}
