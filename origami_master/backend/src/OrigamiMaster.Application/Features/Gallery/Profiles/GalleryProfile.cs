using AutoMapper;
using OrigamiMaster.Application.Features.Gallery.DTOs;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Application.Features.Gallery.Profiles;

public class GalleryProfile : AutoMapper.Profile
{
    public GalleryProfile()
    {
        CreateMap<OrigamiModel, OrigamiModelSummaryDto>()
            .ForMember(dest => dest.Difficulty, opt => opt.MapFrom(src => src.Difficulty.ToString()));

        CreateMap<Creation, GalleryItemDto>()
            .ForMember(dest => dest.OrigamiModelId, opt => opt.MapFrom(src => src.OrigamiModelId))
            .ForMember(dest => dest.OrigamiModelName, opt => opt.MapFrom(src => src.OrigamiModel != null ? src.OrigamiModel.Name : string.Empty))
            .ForMember(dest => dest.Difficulty, opt => opt.MapFrom(src => src.OrigamiModel != null ? src.OrigamiModel.Difficulty.ToString() : string.Empty))
            .ForMember(dest => dest.Visibility, opt => opt.MapFrom(src => src.Visibility.ToString()))
            .ForMember(dest => dest.Caption, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.CreatorId, opt => opt.MapFrom(src => src.UserId))
            .ForMember(dest => dest.CreatorName, opt => opt.MapFrom(src => src.User != null ? src.User.Username : "Unknown User"))
            .ForMember(dest => dest.CreatorAvatar, opt => opt.MapFrom(src => src.User != null ? src.User.AvatarUrl : null));

        CreateMap<Creation, GalleryDetailDto>()
            .ForMember(dest => dest.Visibility, opt => opt.MapFrom(src => src.Visibility.ToString()))
            .ForMember(dest => dest.Caption, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.CreatorId, opt => opt.MapFrom(src => src.UserId))
            .ForMember(dest => dest.CreatorName, opt => opt.MapFrom(src => src.User != null ? src.User.Username : "Unknown User"))
            .ForMember(dest => dest.CreatorAvatar, opt => opt.MapFrom(src => src.User != null ? src.User.AvatarUrl : null));
    }
}
