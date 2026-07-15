using MediatR;
using OrigamiMaster.Application.Features.Auth.DTOs;

namespace OrigamiMaster.Application.Features.Auth.Queries.GetCurrentUser;

public class GetCurrentUserQuery : IRequest<CurrentUserDto>
{
}
