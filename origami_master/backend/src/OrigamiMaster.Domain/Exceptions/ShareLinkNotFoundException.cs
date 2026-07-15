using System;

namespace OrigamiMaster.Domain.Exceptions;

public class ShareLinkNotFoundException : DomainException
{
    public ShareLinkNotFoundException(Guid id) : base($"Share link with ID {id} was not found.")
    {
    }
}
