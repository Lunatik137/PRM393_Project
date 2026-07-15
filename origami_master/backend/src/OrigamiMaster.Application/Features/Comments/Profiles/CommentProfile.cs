using AutoMapper;
using OrigamiMaster.Application.Features.Comments.DTOs;
using OrigamiMaster.Domain.Entities;

namespace OrigamiMaster.Application.Features.Comments.Profiles;

public class CommentProfile : AutoMapper.Profile
{
    public CommentProfile()
    {
        CreateMap<User, CommentAuthorDto>();

        CreateMap<Comment, CommentDto>()
            .ForMember(dest => dest.Author, opt => opt.MapFrom(src => src.User))
            .ForMember(dest => dest.IsOwner, opt => opt.Ignore());
    }
}
