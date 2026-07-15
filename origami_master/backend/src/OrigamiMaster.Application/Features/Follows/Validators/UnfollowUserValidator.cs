using FluentValidation;

namespace OrigamiMaster.Application.Features.Follows.Validators;

public class UnfollowUserValidator : AbstractValidator<Commands.UnfollowUser.UnfollowUserCommand>
{
    public UnfollowUserValidator()
    {
        RuleFor(x => x.TargetUserId).NotEmpty();
    }
}
