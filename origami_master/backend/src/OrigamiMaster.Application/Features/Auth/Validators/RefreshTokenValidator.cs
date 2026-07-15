using FluentValidation;

namespace OrigamiMaster.Application.Features.Auth.Validators;

public class RefreshTokenValidator : AbstractValidator<Commands.Refresh.RefreshTokenCommand>
{
    public RefreshTokenValidator()
    {
        RuleFor(x => x.Token).NotEmpty();
    }
}
