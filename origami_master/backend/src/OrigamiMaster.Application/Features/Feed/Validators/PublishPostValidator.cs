using FluentValidation;

namespace OrigamiMaster.Application.Features.Feed.Validators;

public class PublishPostValidator : AbstractValidator<Commands.PublishPost.PublishPostCommand>
{
    public PublishPostValidator()
    {
        RuleFor(x => x.Description).NotEmpty().MaximumLength(1000);
    }
}
