using System;

namespace OrigamiMaster.Domain.Exceptions;

public class CommentNotFoundException : DomainException
{
    public CommentNotFoundException(Guid id) : base($"Comment with ID {id} was not found.")
    {
    }
}
