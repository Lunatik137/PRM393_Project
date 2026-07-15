using FluentValidation;

namespace OrigamiMaster.Application.Features.Follows.Validators;

public class FollowUserValidator : AbstractValidator<Commands.FollowUser.FollowUserCommand>
{
    public FollowUserValidator()
    {
        RuleFor(x => x.TargetUserId).NotEmpty();
    }
}
