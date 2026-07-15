using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Gallery.Commands.UpdateCreation;

public class UpdateCreationCommand : IRequest
{
    public Guid CreationId { get; set; }
    public string? Notes { get; set; }
    public string? Visibility { get; set; }
    public string? Difficulty { get; set; }
    public string? ImageUrl { get; set; }
    public Guid? OrigamiModelId { get; set; }
    public DateTime? CompletedAt { get; set; }
}
