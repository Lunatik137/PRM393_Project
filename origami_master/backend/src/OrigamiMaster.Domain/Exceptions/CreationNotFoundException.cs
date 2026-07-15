using System;

namespace OrigamiMaster.Domain.Exceptions;

public class CreationNotFoundException : DomainException
{
    public CreationNotFoundException(Guid id) : base($"Creation with ID {id} was not found.")
    {
    }
}
