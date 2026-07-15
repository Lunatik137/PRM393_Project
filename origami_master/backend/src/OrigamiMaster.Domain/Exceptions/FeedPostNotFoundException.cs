using System;

namespace OrigamiMaster.Domain.Exceptions;

public class FeedPostNotFoundException : DomainException
{
    public FeedPostNotFoundException(Guid id) : base($"Feed post with ID {id} was not found.")
    {
    }
}
