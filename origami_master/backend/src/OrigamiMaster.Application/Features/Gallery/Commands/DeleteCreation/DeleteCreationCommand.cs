using MediatR;
using System;

namespace OrigamiMaster.Application.Features.Gallery.Commands.DeleteCreation;

public class DeleteCreationCommand : IRequest
{
    public Guid CreationId { get; set; }
}
