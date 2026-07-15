using FluentValidation;

namespace OrigamiMaster.Application.Features.Gallery.Validators;

public class UpdateVisibilityValidator : AbstractValidator<Commands.UpdateVisibility.UpdateVisibilityCommand>
{
    public UpdateVisibilityValidator()
    {
        RuleFor(x => x.CreationId).NotEmpty();
        RuleFor(x => x.Visibility).Must(v => v == "Public" || v == "Private").WithMessage("INVALID_VISIBILITY");
    }
}
