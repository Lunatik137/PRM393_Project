using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Gallery.Commands.UpdateVisibility;

public class UpdateVisibilityCommand : IRequest
{
    public Guid CreationId { get; set; }
    public string Visibility { get; set; } = string.Empty;
}
