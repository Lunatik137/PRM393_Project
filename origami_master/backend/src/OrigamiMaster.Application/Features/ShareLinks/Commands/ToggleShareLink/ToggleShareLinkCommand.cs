using MediatR;
using System;

namespace OrigamiMaster.Application.Features.ShareLinks.Commands.ToggleShareLink;

public class ToggleShareLinkCommand : IRequest
{
    public Guid ShareLinkId { get; set; }
}
