using AutoMapper;
using OrigamiMaster.Application.Features.ShareLinks.DTOs;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Application.Features.ShareLinks.Profiles;

public class ShareLinkProfile : AutoMapper.Profile
{
    public ShareLinkProfile()
    {
        CreateMap<ShareLink, ShareLinkDto>()
            .ForMember(dest => dest.CreationName, opt => opt.MapFrom(src => src.Creation != null && src.Creation.OrigamiModel != null ? src.Creation.OrigamiModel.Name : string.Empty));

        CreateMap<Creation, SharedCreationDto>()
            .ForMember(dest => dest.OrigamiModelName, opt => opt.MapFrom(src => src.OrigamiModel != null ? src.OrigamiModel.Name : string.Empty))
            .ForMember(dest => dest.CreatorUsername, opt => opt.MapFrom(src => src.User != null ? src.User.Username : string.Empty))
            .ForMember(dest => dest.CompletionDate, opt => opt.MapFrom(src => src.CreatedAt))
            .ForMember(dest => dest.Visibility, opt => opt.MapFrom(src => "ReadOnly"));
    }
}
