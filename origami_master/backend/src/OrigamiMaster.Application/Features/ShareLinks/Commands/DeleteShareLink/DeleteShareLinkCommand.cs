using MediatR;
using System;

namespace OrigamiMaster.Application.Features.ShareLinks.Commands.DeleteShareLink;

public class DeleteShareLinkCommand : IRequest
{
    public Guid ShareLinkId { get; set; }
}
