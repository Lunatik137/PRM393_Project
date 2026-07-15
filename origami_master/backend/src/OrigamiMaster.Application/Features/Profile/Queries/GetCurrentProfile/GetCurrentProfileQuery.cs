using MediatR;
using OrigamiMaster.Application.Features.Profile.DTOs;

namespace OrigamiMaster.Application.Features.Profile.Queries.GetCurrentProfile;

public class GetCurrentProfileQuery : IRequest<UserProfileDto>
{
}
