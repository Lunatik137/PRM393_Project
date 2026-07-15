using FluentValidation;

namespace OrigamiMaster.Application.Features.Profile.Validators;

public class UpdateProfileValidator : AbstractValidator<Commands.UpdateProfile.UpdateProfileCommand>
{
    public UpdateProfileValidator()
    {
        RuleFor(x => x.Username)
            .NotEmpty()
            .MinimumLength(3)
            .MaximumLength(50);

        RuleFor(x => x.Bio)
            .MaximumLength(500);

        RuleFor(x => x.AvatarUrl)
            .MaximumLength(500);
    }
}
