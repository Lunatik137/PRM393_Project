using AutoMapper;
using OrigamiMaster.Application.Features.Profile.DTOs;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Application.Features.Profile.Profiles;

public class ProfileMappingProfile : AutoMapper.Profile
{
    public ProfileMappingProfile()
    {
        CreateMap<User, UserProfileDto>()
            .ForMember(dest => dest.Statistics, opt => opt.Ignore())
            .ForMember(dest => dest.IsFollowing, opt => opt.Ignore());

        CreateMap<FeedPost, UserPostDto>()
            .ForMember(dest => dest.ImageUrl, opt => opt.MapFrom(src => src.ImageUrl ?? string.Empty));
    }
}
