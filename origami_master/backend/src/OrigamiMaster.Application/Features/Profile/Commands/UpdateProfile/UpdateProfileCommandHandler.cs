using MediatR;
using OrigamiMaster.Application.Interfaces;
using OrigamiMaster.Domain.Repositories;
using System.Threading;
using System.Threading.Tasks;

namespace OrigamiMaster.Application.Features.Profile.Commands.UpdateProfile;

public class UpdateProfileCommandHandler : IRequestHandler<UpdateProfileCommand>
{
    private readonly IUserRepository _userRepository;
    private readonly ICurrentUserService _currentUserService;
    private readonly IUnitOfWork _unitOfWork;

    public UpdateProfileCommandHandler(
        IUserRepository userRepository,
        ICurrentUserService currentUserService,
        IUnitOfWork unitOfWork)
    {
        _userRepository = userRepository;
        _currentUserService = currentUserService;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(UpdateProfileCommand request, CancellationToken cancellationToken)
    {
        var currentUserId = _currentUserService.GetUserId();
        var user = await _userRepository.GetByIdAsync(currentUserId);

        if (user == null)
            throw new System.Exception("USER_NOT_FOUND");

        if (user.Username != request.Username)
        {
            var exists = await _userRepository.UsernameExistsAsync(request.Username);
            if (exists)
                throw new System.Exception("USERNAME_ALREADY_EXISTS");
        }

        user.Username = request.Username;
        user.Bio = request.Bio;
        user.AvatarUrl = request.AvatarUrl;

        await _userRepository.UpdateAsync(user);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
    }
}
