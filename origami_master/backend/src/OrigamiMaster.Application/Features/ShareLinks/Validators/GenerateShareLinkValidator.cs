using FluentValidation;

namespace OrigamiMaster.Application.Features.ShareLinks.Validators;

public class GenerateShareLinkValidator : AbstractValidator<Commands.GenerateShareLink.GenerateShareLinkCommand>
{
    public GenerateShareLinkValidator()
    {
        RuleFor(x => x.CreationId).NotEmpty();
    }
}
