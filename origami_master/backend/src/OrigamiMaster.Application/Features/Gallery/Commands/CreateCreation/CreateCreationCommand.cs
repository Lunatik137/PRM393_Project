using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Gallery.Commands.CreateCreation;

public class CreateCreationCommand : IRequest<Guid>
{
    public Guid? OrigamiModelId { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public string? Notes { get; set; }
    public string Visibility { get; set; } = "Private";
}
