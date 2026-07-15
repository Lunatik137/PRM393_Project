using System;

namespace OrigamiMaster.Application.Interfaces;

public interface ICurrentUserService
{
    Guid GetUserId();
    string GetEmail();
    string GetUsername();
    bool IsAuthenticated();
}
