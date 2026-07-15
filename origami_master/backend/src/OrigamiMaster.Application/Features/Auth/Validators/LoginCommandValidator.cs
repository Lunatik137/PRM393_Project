using FluentValidation;

namespace OrigamiMaster.Application.Features.Auth.Validators;

public class LoginCommandValidator : AbstractValidator<Commands.Login.LoginCommand>
{
    public LoginCommandValidator()
    {
        RuleFor(x => x.Email).NotEmpty().EmailAddress();
        RuleFor(x => x.Password).NotEmpty();
    }
}
