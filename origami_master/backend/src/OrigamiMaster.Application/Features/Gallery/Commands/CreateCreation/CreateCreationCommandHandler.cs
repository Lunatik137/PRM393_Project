using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Enums;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Gallery.Commands.CreateCreation;

public class CreateCreationCommandHandler : IRequestHandler<CreateCreationCommand, Guid>
{
    private readonly ICreationRepository _creationRepository;
    private readonly IOrigamiModelRepository _modelRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public CreateCreationCommandHandler(
        ICreationRepository creationRepository,
        IOrigamiModelRepository modelRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _creationRepository = creationRepository;
        _modelRepository = modelRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task<Guid> Handle(CreateCreationCommand request, CancellationToken cancellationToken)
    {
        if (request.OrigamiModelId.HasValue)
        {
            var modelExists = await _modelRepository.ExistsAsync(request.OrigamiModelId.Value);
            if (!modelExists)
                throw new Exception("ORIGAMI_MODEL_NOT_FOUND");
                
            if (string.IsNullOrEmpty(request.ImageUrl))
            {
                var model = await _modelRepository.GetByIdAsync(request.OrigamiModelId.Value);
                if (model != null)
                {
                    request.ImageUrl = model.ThumbnailUrl ?? model.CoverImageUrl ?? string.Empty;
                }
            }
        }

        var currentUserId = _currentUserService.GetUserId();

        var visibility = Enum.Parse<CreationVisibility>(request.Visibility);

        var creation = new Creation
        {
            Id = Guid.NewGuid(),
            UserId = currentUserId,
            OrigamiModelId = request.OrigamiModelId,
            ImageUrl = request.ImageUrl,
            Notes = request.Notes,
            Visibility = visibility,
            IsPublished = visibility == CreationVisibility.Public,
            CreatedAt = DateTime.UtcNow
        };

        await _creationRepository.AddAsync(creation);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return creation.Id;
    }
}
