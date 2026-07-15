using MediatR;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Entities;
using OrigamiMaster.Domain.Repositories;
using System;
using System.Security.Cryptography;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.ShareLinks.Commands.GenerateShareLink;

public class GenerateShareLinkCommandHandler : IRequestHandler<GenerateShareLinkCommand, GenerateShareLinkResponse>
{
    private readonly IShareLinkRepository _shareLinkRepository;
    private readonly ICreationRepository _creationRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public GenerateShareLinkCommandHandler(
        IShareLinkRepository shareLinkRepository,
        ICreationRepository creationRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _shareLinkRepository = shareLinkRepository;
        _creationRepository = creationRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task<GenerateShareLinkResponse> Handle(GenerateShareLinkCommand request, CancellationToken cancellationToken)
    {
        var creation = await _creationRepository.GetByIdAsync(request.CreationId);
        if (creation == null)
            throw new Exception("CREATION_NOT_FOUND");

        var currentUserId = _currentUserService.GetUserId();
        if (creation.UserId != currentUserId)
            throw new Exception("FORBIDDEN_ACTION");

        string token;
        bool exists;
        do
        {
            var bytes = RandomNumberGenerator.GetBytes(32);
            token = Convert.ToBase64String(bytes)
                .Replace("+", "")
                .Replace("/", "")
                .Replace("=", "");

            exists = await _shareLinkRepository.TokenExistsAsync(token);
        } while (exists);

        var shareLink = new ShareLink
        {
            Id = Guid.NewGuid(),
            CreationId = creation.Id,
            Token = token,
            IsActive = true,
            CreatedAt = DateTime.UtcNow
        };

        await _shareLinkRepository.AddAsync(shareLink);
        await _unitOfWork.SaveChangesAsync(cancellationToken);

        return new GenerateShareLinkResponse
        {
            ShareLinkId = shareLink.Id,
            Url = $"https://origamimaster.app/share/{token}"
        };
    }
}
