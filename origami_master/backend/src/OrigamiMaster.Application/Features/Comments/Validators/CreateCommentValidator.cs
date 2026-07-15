using FluentValidation;

namespace OrigamiMaster.Application.Features.Comments.Validators;

public class CreateCommentValidator : AbstractValidator<Commands.CreateComment.CreateCommentCommand>
{
    public CreateCommentValidator()
    {
        RuleFor(x => x.PostId).NotEmpty();
        RuleFor(x => x.Content).NotEmpty().WithMessage("COMMENT_CONTENT_REQUIRED").MaximumLength(1000);
    }
}
