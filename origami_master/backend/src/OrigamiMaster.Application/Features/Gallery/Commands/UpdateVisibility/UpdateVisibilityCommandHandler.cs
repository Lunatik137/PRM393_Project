using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Enums;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Commands.UpdateVisibility;

public class UpdateVisibilityCommandHandler : IRequestHandler<UpdateVisibilityCommand>
{
    private readonly ICreationRepository _creationRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public UpdateVisibilityCommandHandler(
        ICreationRepository creationRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _creationRepository = creationRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(UpdateVisibilityCommand request, CancellationToken cancellationToken)
    {
        var creation = await _creationRepository.GetByIdAsync(request.CreationId);
        if (creation == null)
            throw new Exception("CREATION_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (creation.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        var newVisibility = Enum.Parse<CreationVisibility>(request.Visibility);

        if (creation.IsPublished && newVisibility == CreationVisibility.Private)
        {
            throw new Exception("CREATION_ALREADY_PUBLISHED");
        }

        creation.Visibility = newVisibility;

        await _creationRepository.UpdateAsync(creation);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
