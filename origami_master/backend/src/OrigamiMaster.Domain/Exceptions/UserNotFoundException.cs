using System;

namespace OrigamiMaster.Domain.Exceptions;

public class UserNotFoundException : DomainException
{
    public UserNotFoundException(Guid id) : base($"User with ID {id} was not found.")
    {
    }
}
