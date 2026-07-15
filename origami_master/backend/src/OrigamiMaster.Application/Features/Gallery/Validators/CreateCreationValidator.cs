using FluentValidation;

namespace OrigamiMaster.Application.Features.Gallery.Validators;

public class CreateCreationValidator : AbstractValidator<Commands.CreateCreation.CreateCreationCommand>
{
    public CreateCreationValidator()
    {
        RuleFor(x => x.ImageUrl).MaximumLength(2048);
        RuleFor(x => x.Notes).MaximumLength(1000);
        RuleFor(x => x.Visibility).Must(v => v == "Public" || v == "Private").WithMessage("INVALID_VISIBILITY");
    }
}
