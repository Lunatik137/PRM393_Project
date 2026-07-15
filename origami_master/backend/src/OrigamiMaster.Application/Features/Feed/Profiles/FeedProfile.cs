using AutoMapper;
using OrigamiMaster.Application.Features.Feed.DTOs;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Application.Features.Feed.Profiles;

public class FeedProfile : AutoMapper.Profile
{
    public FeedProfile()
    {
        CreateMap<User, FeedAuthorDto>();

        CreateMap<FeedPost, FeedPostDto>()
            .ForMember(dest => dest.Author, opt => opt.MapFrom(src => src.User))
            .ForMember(dest => dest.IsLiked, opt => opt.Ignore())
            .ForMember(dest => dest.IsFollowingAuthor, opt => opt.Ignore());
    }
}
