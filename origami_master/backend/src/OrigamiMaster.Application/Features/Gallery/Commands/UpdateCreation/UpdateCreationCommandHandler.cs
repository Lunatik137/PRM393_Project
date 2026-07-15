using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using OrigamiMaster.Domain.Enums;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Commands.UpdateCreation;

public class UpdateCreationCommandHandler : IRequestHandler<UpdateCreationCommand>
{
    private readonly ICreationRepository _creationRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public UpdateCreationCommandHandler(
        ICreationRepository creationRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _creationRepository = creationRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(UpdateCreationCommand request, CancellationToken cancellationToken)
    {
        var creation = await _creationRepository.GetByIdAsync(request.CreationId);
        if (creation == null)
            throw new Exception("CREATION_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (creation.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        if (request.Notes != null)
            creation.Notes = request.Notes;
            
        if (!string.IsNullOrEmpty(request.ImageUrl))
            creation.ImageUrl = request.ImageUrl;

        if (request.OrigamiModelId.HasValue)
            creation.OrigamiModelId = request.OrigamiModelId.Value;

        if (!string.IsNullOrEmpty(request.Visibility) && Enum.TryParse<CreationVisibility>(request.Visibility, out var visibility))
        {
            creation.Visibility = visibility;
            if (visibility == CreationVisibility.Public && !creation.IsPublished)
            {
                creation.Publish();
            }
        }

        await _creationRepository.UpdateAsync(creation);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
