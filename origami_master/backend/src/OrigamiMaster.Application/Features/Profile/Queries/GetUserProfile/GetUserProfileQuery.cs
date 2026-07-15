using MediatR;
using OrigamiMaster.Application.Features.Profile.DTOs;
using System;

namespace OrigamiMaster.Application.Features.Profile.Queries.GetUserProfile;

public class GetUserProfileQuery : IRequest<UserProfileDto>
{
    public Guid UserId { get; set; }
}
